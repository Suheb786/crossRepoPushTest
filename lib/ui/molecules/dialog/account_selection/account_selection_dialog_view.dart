import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'account_selection_dialog_model.dart';

class AccountSelectionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(Account)? onSelected;
  final List<Account> accountList;
  final String title;

  AccountSelectionDialogView(
      {this.onDismissed, required this.onSelected, required this.title, required this.accountList});

  ProviderBase providerBase() {
    return accountSelectionDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountSelectionDialogModel>(
        onModelReady: (AccountSelectionDialogModel model) {
          model.allCategories.clear();
          model.allCategories.addAll(accountList);
        },
        builder: (context, model, child) {
          return GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity! > 0) {
                onDismissed?.call();
              }
            },
            child: Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0.w)),
                insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
                child: AppStreamBuilder<int>(
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
                                  borderRadius: BorderRadius.circular(16.w),
                                  color: Theme.of(context).canvasColor,
                                ),
                              ),
                            ),
                            AppScrollableListViewWidget(
                              key: ValueKey(model.allCategories.length),
                              child: ClickableListWheelScrollView(
                                scrollController: model.scrollController,
                                itemHeight: 90.h,
                                itemCount: model.allCategories.length,
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
                                                      // "Main Account - Primary",
                                                      "${account.isSubAccount! ? "${account.nickName ?? "Sub Account"}" : "Main Account - Primary"}",
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
                                                    SizedBox(height: 15.h),
                                                    RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "${account.availableBalance ?? "0.00"}",
                                                            style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontSize: 14.0.t,
                                                              color: index == currentIndex
                                                                  ? Theme.of(context).primaryColorDark
                                                                  : Theme.of(context).colorScheme.surfaceTint,
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
                                                                  : Theme.of(context).colorScheme.surfaceTint,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ],
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
                        InkWell(
                          onTap: () {
                            onSelected?.call(model.allCategories[currentIndex!]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                            height: 57.h,
                            width: 57.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyLarge!.color!),
                            child:
                                AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                          child: Center(
                            child: Text(
                              S.of(context).swipeDownToCancel,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 10.t,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.dark_gray_1),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                )),
          );
        },
        providerBase: providerBase());
  }
}
