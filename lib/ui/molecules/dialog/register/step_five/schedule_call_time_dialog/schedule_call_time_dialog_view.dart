import 'package:domain/model/account/available_time_slots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/di/usecase/account/account_usecase_provider.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_scollable_list_view_widget.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/schedule_call_time_dialog/schedule_call_time_dialog_viewmodel.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/schedule_call_time_dialog/schedule_call_time_item_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/clickable_scrall_view/list_wheel_scrall_view.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../../no_data_widget.dart';

class ScheduleCallTimeDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AvailableTimeSlots)? onSelected;
  final String? title;
  final List<AvailableTimeSlots> data;
  final bool onWillPop;

  ScheduleCallTimeDialogView(
      {this.onDismissed, this.onSelected, this.title, required this.data, this.onWillPop = true});

  ProviderBase providerBase() {
    return scheduleCallTimeDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => onWillPop,
      child: BaseWidget<ScheduleCallTimeViewModel>(
        providerBase: providerBase(),
        onModelReady: (model) {
          model.setOptionData(data);
        },
        builder: (context, model, child) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              insetPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
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
                    return AppStreamBuilder<Resource<List<AvailableTimeSlots>>>(
                      stream: model.optionalDataStream,
                      initialData: Resource.none(),
                      dataBuilder: (context, data) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 32.0.h),
                              child: Center(
                                child: Text(
                                  title!,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                                height: MediaQuery.of(context).size.height / 2.5,
                                child: data!.data!.length > 0
                                    ? Stack(
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
                                          Container(
                                            height: MediaQuery.of(context).size.height / 2.5,
                                            child: AppScrollableListViewWidget(
                                              key: ValueKey(data.data!.length),
                                              child: ClickableListWheelScrollView(
                                                scrollController: model.scrollController,
                                                itemHeight: 64.h,
                                                itemCount: data.data!.length,
                                                onItemTapCallback: (index) {
                                                  model.selectMobileNumber(index);
                                                },
                                                child: ListWheelScrollView.useDelegate(
                                                    controller: model.scrollController,
                                                    itemExtent: 64.h,
                                                    onSelectedItemChanged: (int index) {
                                                      model.selectMobileNumber(index);
                                                    },
                                                    physics: FixedExtentScrollPhysics(),
                                                    perspective: 0.0000000001,
                                                    childDelegate: ListWheelChildBuilderDelegate(
                                                        childCount: data.data!.length,
                                                        builder: (BuildContext context, int index) {
                                                          return ScheduleCallItemWidget(
                                                            item: data.data![index],
                                                          );
                                                        })),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Center(
                                        child: NoDataWidget(),
                                      )),
                            GestureDetector(
                              onVerticalDragEnd: (details) {
                                if (!details.primaryVelocity!.isNegative) {
                                  onDismissed?.call();
                                }
                              },
                              child: Container(
                                color: AppColor.white.withOpacity(0),
                                child: Column(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        onSelected!.call(model.selectedOptionData!);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                                        height: 57.h,
                                        width: 57.w,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context).textTheme.bodyLarge!.color!),
                                        child: AppSvg.asset(AssetUtils.tick,
                                            color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.0.h, bottom: 16.h),
                                      child: Center(
                                        child: Text(
                                          S.of(context).swipeDownToCancel,
                                          style: TextStyle(
                                              fontSize: 10.t,
                                              fontWeight: FontWeight.w400,
                                              color: AppColor.dark_gray_1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ));
        },
      ),
    );
  }
}
