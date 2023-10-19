import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'account_selection_dialog_model.dart';

class AccountSelectionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Account)? onSelected;
  final List<Account> accountList;
  final String title;
  final bool showBalances;
  final bool onWillPop;

  AccountSelectionDialogView(
      {this.onDismissed,
      required this.onSelected,
      required this.title,
      required this.accountList,
      this.showBalances = true,
      this.onWillPop = true});

  ProviderBase providerBase() {
    return accountSelectionDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<AccountSelectionDialogModel>(
          onModelReady: (AccountSelectionDialogModel model) {
            model.allCategories.clear();
            model.allCategories.addAll(accountList);
          },
          builder: (context, model, child) {
            return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0.w)),
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
                                    height: showBalances ? 90.h : 70.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      color: Theme.of(context).canvasColor,
                                    ),
                                  ),
                                ),
                                AppScrollableListViewWidget(
                                  key: ValueKey(model.allCategories.length),
                                  child: ClickableListWheelScrollView(
                                    scrollController: model.scrollController,
                                    itemHeight: showBalances ? 100.h : 70.h,
                                    itemCount: model.allCategories.length,
                                    onItemTapCallback: (index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    child: ListWheelScrollView.useDelegate(
                                        controller: model.scrollController,
                                        itemExtent: showBalances ? 100.h : 70.h,
                                        onSelectedItemChanged: (int index) {
                                          model.currentIndexUpdate(index);
                                        },
                                        physics: FixedExtentScrollPhysics(),
                                        perspective: 0.0000000001,
                                        childDelegate: ListWheelChildBuilderDelegate(
                                            childCount: model.allCategories.length,
                                            builder: (BuildContext context, int index) {
                                              Account account = model.allCategories[index];
                                              return Padding(
                                                padding: EdgeInsetsDirectional.only(start: 48.w),
                                                child: Row(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(height: 17.h),
                                                        Text(
                                                          account.isSubAccount == false
                                                              ? (account.nickName == null ||
                                                                      account.nickName == ""
                                                                  ? (S.current.mainAccount)
                                                                  : (S.current.mainAccount +
                                                                      " - " +
                                                                      (account.nickName ?? "")))
                                                              : (account.nickName == null ||
                                                                      account.nickName == ""
                                                                  ? (S.current.subAccount)
                                                                  : (S.current.subAccount +
                                                                      " - " +
                                                                      (account.nickName ?? ""))),
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.0.t,
                                                              color: currentIndex == index
                                                                  ? Theme.of(context).primaryColorDark
                                                                  : Theme.of(context).colorScheme.surfaceTint,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          "${account.accountNo ?? ""}",
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 10.0.t,
                                                              color: index == currentIndex
                                                                  ? Theme.of(context).colorScheme.shadow
                                                                  : Theme.of(context).colorScheme.surfaceTint,
                                                              fontWeight: FontWeight.w600),
                                                        ),
                                                        Visibility(
                                                            visible: showBalances,
                                                            child: SizedBox(height: 15.h)),
                                                        Visibility(
                                                          visible: showBalances,
                                                          child: RichText(
                                                            text: TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text: StringUtils.formatBalance(
                                                                      account.availableBalance ?? '0.00'),
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 14.0.t,
                                                                    color: index == currentIndex
                                                                        ? Theme.of(context).primaryColorDark
                                                                        : Theme.of(context)
                                                                            .colorScheme
                                                                            .surfaceTint,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text: " " + S.current.JOD.toUpperCase(),
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.0.t,
                                                                    color: index == currentIndex
                                                                        ? Theme.of(context).primaryColorDark
                                                                        : Theme.of(context)
                                                                            .colorScheme
                                                                            .surfaceTint,
                                                                    fontWeight: FontWeight.w600,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })),
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 42.h),
                              child: AppPrimaryButton(
                                onPressed: () {
                                  onSelected?.call(model.allCategories[currentIndex!]);
                                },
                                text: S.of(context).confirm,
                              ),
                            )
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
                    )
                  ],
                ));
          },
          providerBase: providerBase()),
    );
  }
}
