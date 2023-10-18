import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../../../base/base_widget.dart';
import '../../../../../di/dialog/select_list_from_list_dialog_di.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/asset_utils.dart';
import '../../../../../utils/string_utils.dart';
import '../../../app_scollable_list_view_widget.dart';
import '../../../listwheel_scroll_view_widget/select_transfer_to_account.dart';

class SelectAccountListDialogPageView extends StatelessWidget {
  final Function()? onDismissed;
  final Function(Account)? onConfirm;
  final List<Account> accountList;

  final String title;
  final bool onWillPop;

  const SelectAccountListDialogPageView(
      {Key? key,
      this.onDismissed,
      this.onConfirm,
      required this.title,
      required this.accountList,
      this.onWillPop = true})
      : super(key: key);

  ProviderBase providerBase() {
    return selectFromListDialogPageViewModel;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<SelectAccountListDialogPageViewModel>(
          builder: (context, model, child) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 56.h, top: 204.h),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  AppStreamBuilder<int>(
                    stream: model!.currentIndexStream,
                    initialData: 0,
                    dataBuilder: (context, currentIndex) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 32.0.h),
                            child: Center(
                              child: Text(
                                title,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 16.t,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                child: Container(
                                  height: 90.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Theme.of(context).canvasColor,
                                  ),
                                ),
                              ),
                              AppScrollableListViewWidget(
                                key: ValueKey(accountList.length),
                                child: ClickableListWheelScrollView(
                                  scrollController: model.scrollController,
                                  itemHeight: 100.h,
                                  itemCount: accountList.length,
                                  onItemTapCallback: (index) {
                                    model.currentIndexUpdate(index);
                                  },
                                  child: ListWheelScrollView.useDelegate(
                                      controller: model.scrollController,
                                      itemExtent: 100.h,
                                      onSelectedItemChanged: (int index) {
                                        model.currentIndexUpdate(index);
                                      },
                                      physics: FixedExtentScrollPhysics(),
                                      perspective: 0.0000000001,
                                      childDelegate: ListWheelChildBuilderDelegate(
                                          childCount: accountList.length,
                                          builder: (BuildContext context, int index) {
                                            return SelectTransferToAccountWidget(
                                              account: accountList[index],
                                              isSelected: currentIndex == index ? true : false,
                                            );
                                          })),
                                ),
                              ),
                            ],
                          )),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 42.h),
                            child: AppPrimaryButton(
                                text: S.current.confirm,
                                onPressed: () {
                                  onConfirm?.call(
                                    accountList[currentIndex ?? 0],
                                  );
                                }),
                          ),
                        ],
                      );
                    },
                  ),
                  Positioned(
                    bottom: -24.h,
                    child: InkWell(
                      onTap: () {
                        onDismissed?.call();
                      },
                      child: Container(
                          height: 48.h,
                          width: 48.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
                              shape: BoxShape.circle,
                              color: Theme.of(context).colorScheme.secondary),
                          child: Image.asset(
                            AssetUtils.close_bold,
                            scale: 3.5,
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
          providerBase: providerBase()),
    );
  }
}
