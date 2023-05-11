import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog_view_model.dart';
import 'package:neo_bank/ui/molecules/listwheel_scroll_view_widget/list_scroll_wheel_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EmploymentStatusDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(String, String)? onSelected;

  const EmploymentStatusDialogView({this.onDismissed, this.onSelected});

  ProviderBase providerBase() {
    return employmentStatusDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<EmploymentStatusDialogViewModel>(
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 36.h, top: 204.h),
              child: GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    onDismissed?.call();
                  }
                },
                child: AppStreamBuilder<int>(
                  stream: model!.currentIndexStream,
                  initialData: 0,
                  dataBuilder: (context, currentIndex) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 32.0.h),
                          child: Center(
                            child: Text(
                              S.of(context).employmentStatusSmall,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 14.t,
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
                                  borderRadius: BorderRadius.circular(16),
                                  color: AppColor.vividYellow,
                                ),
                              ),
                            ),
                            AppScrollableListViewWidget(
                              key: ValueKey(StringUtils.isDirectionRTL(context)
                                  ? model.employmentStatusListAr.length
                                  : model.employmentStatusList.length),
                              child: ClickableListWheelScrollView(
                                scrollController: model.scrollController,
                                itemHeight: 64.h,
                                itemCount: StringUtils.isDirectionRTL(context)
                                    ? model.employmentStatusListAr.length
                                    : model.employmentStatusList.length,
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
                                        childCount: model.employmentStatusList.length,
                                        builder: (BuildContext context, int index) {
                                          return ListScrollWheelListWidget(
                                            label: StringUtils.isDirectionRTL(context)
                                                ? model.employmentStatusListAr[index]
                                                : model.employmentStatusList[index],
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
                        InkWell(
                          onTap: () {
                            onSelected!.call(
                                StringUtils.isDirectionRTL(context)
                                    ? model.employmentStatusListAr[currentIndex!]
                                    : model.employmentStatusList[currentIndex!],
                                model.employmentStatusList[currentIndex]);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                            height: 57.h,
                            width: 57.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).textTheme.bodyMedium!.color!),
                            child: AppSvg.asset(AssetUtils.tick, color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 16.h),
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
                ),
              ));
        },
        providerBase: providerBase());
  }
}
