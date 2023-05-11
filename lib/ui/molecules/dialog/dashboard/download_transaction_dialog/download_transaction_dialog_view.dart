import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/download_transaction_dialog/download_transaction_page_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class DownloadTransactionDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String)? onSelected;
  final List<String>? years;

  const DownloadTransactionDialogView({this.onDismissed, this.onSelected, this.years});

  ProviderBase providerBase() {
    return downloadTransactionDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<DownloadTransactionDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.0.w, right: 24.0.w, bottom: 36.0.h, top: 204.0.h),
              child: AppStreamBuilder<int>(
                stream: model!.currentIndexStream,
                initialData: 0,
                dataBuilder: (context, currentIndex) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        onDismissed?.call();
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 32.0.h),
                          child: Center(
                            child: Text(
                              S.of(context).downloadStatement,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 16.0.t,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        years!.length > 0
                            ? Expanded(
                                child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                                    child: Container(
                                      height: 64.0.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColor.vividYellow,
                                      ),
                                    ),
                                  ),
                                  AppScrollableListViewWidget(
                                    key: ValueKey(years!.length),
                                    child: ClickableListWheelScrollView(
                                      scrollController: model.scrollController,
                                      itemHeight: 64.0.h,
                                      itemCount: years!.length,
                                      onItemTapCallback: (index) {
                                        model.currentIndexUpdate(index);
                                      },
                                      child: ListWheelScrollView.useDelegate(
                                          controller: model.scrollController,
                                          itemExtent: 64.0.h,
                                          onSelectedItemChanged: (int index) {
                                            model.currentIndexUpdate(index);
                                          },
                                          physics: FixedExtentScrollPhysics(),
                                          perspective: 0.0000000001,
                                          childDelegate: ListWheelChildBuilderDelegate(
                                              childCount: years!.length,
                                              builder: (BuildContext context, int index) {
                                                return ListScrollWheelListWidget(
                                                  label: TimeUtils.getFormattedMMMYYYY(years![index]),
                                                  textColor: currentIndex == index
                                                      ? Theme.of(context).primaryColorDark
                                                      : AppColor.dark_gray_1,
                                                  widgetColor: Colors.transparent,
                                                );
                                              })),
                                    ),
                                  )
                                ],
                              ))
                            : Expanded(
                                child: Center(
                                  child: Text('No Data to Display'),
                                ),
                              ),
                        InkWell(
                          onTap: () {
                            years!.length > 0
                                ? onSelected!.call(years![currentIndex!])
                                : Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 57.0.h,
                            width: 57.0.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).textTheme.bodyMedium!.color!),
                            child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            onDismissed?.call();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0.h, bottom: 16.0.h),
                            child: Center(
                              child: Text(
                                S.of(context).swipeDownToCancel,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 10.0.t,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.dark_gray_1),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
        },
        providerBase: providerBase());
  }
}
