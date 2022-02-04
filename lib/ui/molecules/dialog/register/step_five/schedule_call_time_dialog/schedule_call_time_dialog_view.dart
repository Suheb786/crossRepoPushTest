import 'package:clickable_list_wheel_view/clickable_list_wheel_widget.dart';
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
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';

class ScheduleCallTimeDialogView extends StatelessWidget {
  final Function? onDismissed;
  final Function(AvailableTimeSlots)? onSelected;
  final String? title;
  final List<AvailableTimeSlots> data;

  ScheduleCallTimeDialogView(
      {this.onDismissed, this.onSelected, this.title, required this.data});

  ProviderBase providerBase() {
    return scheduleCallTimeDialogViwModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ScheduleCallTimeViewModel>(
      providerBase: providerBase(),
      onModelReady: (model) {
        model.setOptionData(data);
      },
      builder: (context, model, child) {
        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
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
                            padding: const EdgeInsets.only(top: 32.0),
                            child: Center(
                              child: Text(
                                title!,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          child: Container(
                                            height: 64,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              color: AppColor.vividYellow,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.5,
                                          child: AppScrollableListViewWidget(
                                            key: ValueKey(data.data!.length),
                                            child: ClickableListWheelScrollView(
                                              scrollController:
                                                  model.scrollController,
                                              itemHeight: 64,
                                              itemCount: data.data!.length,
                                              onItemTapCallback: (index) {
                                                model.selectMobileNumber(index);
                                              },
                                              child: ListWheelScrollView
                                                  .useDelegate(
                                                      controller: model
                                                          .scrollController,
                                                      itemExtent: 64,
                                                      onSelectedItemChanged:
                                                          (int index) {
                                                        model
                                                            .selectMobileNumber(
                                                                index);
                                                      },
                                                      physics:
                                                          FixedExtentScrollPhysics(),
                                                      perspective: 0.0000000001,
                                                      childDelegate:
                                                          ListWheelChildBuilderDelegate(
                                                              childCount: data
                                                                  .data!.length,
                                                              builder: (BuildContext
                                                                      context,
                                                                  int index) {
                                                                return ScheduleCallItemWidget(
                                                                  item: data
                                                                          .data![
                                                                      index],
                                                                );
                                                              })),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Text(
                                        "No Options Available",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: AppColor.dark_violet_4),
                                      ),
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
                                      onSelected!
                                          .call(model.selectedOptionData!);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      height: 57,
                                      width: 57,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color!),
                                      child: AppSvg.asset(AssetUtils.tick,
                                          color: Theme.of(context).accentColor),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 16),
                                    child: Center(
                                      child: Text(
                                        S.of(context).swipeDownToCancel,
                                        style: TextStyle(
                                            fontSize: 10,
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
    );
  }
}
