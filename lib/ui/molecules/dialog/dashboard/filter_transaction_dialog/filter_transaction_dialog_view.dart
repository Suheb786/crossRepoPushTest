import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/filter_transaction_dialog/filter_transaction_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FilterTransactionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;

  const FilterTransactionDialogView({this.onDismissed, this.onSelected});

  ProviderBase providerBase() {
    return filterTransactionDialogViewModelProvier;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<FilterTransactionDialogViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
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
                                  S.of(context).transactionPeriod,
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
                                    height: 64.h,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.w),
                                      color: AppColor.vividYellow,
                                    ),
                                  ),
                                ),
                                AppScrollableListViewWidget(
                                  key: ValueKey(StringUtils.isDirectionRTL(context)
                                      ? model.filterTransactionListAr.length
                                      : model.filterTransactionList.length),
                                  child: ClickableListWheelScrollView(
                                    scrollController: model.scrollController,
                                    itemHeight: 64.h,
                                    itemCount: StringUtils.isDirectionRTL(context)
                                        ? model.filterTransactionListAr.length
                                        : model.filterTransactionList.length,
                                    onItemTapCallback: (index) {
                                      model.currentIndexUpdate(index);
                                    },
                                    child: ListWheelScrollView.useDelegate(
                                        controller: model.scrollController,
                                        itemExtent: 64.h,
                                        onSelectedItemChanged: (int index) {
                                          model.currentIndexUpdate(index);
                                        },
                                        physics: FixedExtentScrollPhysics(),
                                        perspective: 0.0000000001,
                                        childDelegate: ListWheelChildBuilderDelegate(
                                            childCount: model.filterTransactionList.length,
                                            builder: (BuildContext context, int index) {
                                              return ListScrollWheelListWidget(
                                                label: StringUtils.isDirectionRTL(context)
                                                    ? model.filterTransactionListAr[index]
                                                    : model.filterTransactionList[index],
                                                textColor: currentIndex == index
                                                    ? Theme.of(context).primaryColorDark
                                                    : AppColor.dark_gray_1,
                                                widgetColor: Colors.transparent,
                                              );
                                            })),
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                              child: AppPrimaryButton(
                                onPressed: () {
                                  onSelected!.call(StringUtils.isDirectionRTL(context)
                                      ? model.filterTransactionListAr[currentIndex!]
                                      : model.filterTransactionList[currentIndex!]);
                                },
                                text: S.of(context).confirm,
                              ),
                            )
                          ],
                        );
                      },
                    )),
                Positioned(
                  bottom: 12.h,
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
        providerBase: providerBase());
  }
}
