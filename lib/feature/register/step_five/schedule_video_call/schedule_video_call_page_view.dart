import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';

class ScheduleVideoCallPageView
    extends BasePageViewWidget<ScheduleVideoCallPageViewModel> {
  ScheduleVideoCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Expanded(
          child: AppStreamBuilder<bool>(
            stream: model.errorDetectorStream,
            initialData: false,
            dataBuilder: (context, error) {
              return ShakeAnimatedWidget(
                enabled: error ?? false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.scheduleVideoCallStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerStepFiveViewModelProvider)
                          .registrationStepFivePageController
                          .next(
                              );
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateScheduleVideoCallDetails();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(registerStepFiveViewModelProvider)
                              .registrationStepFivePageController
                              .move(1);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context)
                            .cardTheme
                            .copyWith(color: AppColor.white)
                            .color,
                        margin: EdgeInsets.zero,
                        shadowColor: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText:
                                              S.of(context).preferredDate,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.preferredDateController,
                                          readOnly: true,
                                          key: model.preferredDateKey,
                                          onPressed: () {
                                            DatePicker.show(context,
                                                onSelected: (date) {
                                              model.preferredDateController
                                                      .text =
                                                  TimeUtils.getFormattedDOB(
                                                      date);
                                              model.isValid();
                                            }, onCancelled: () {
                                              Navigator.pop(context);
                                            },
                                                title: S
                                                    .of(context)
                                                    .preferredDate);
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16,
                                                width: 16,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                child: AppSvg.asset(
                                                    AssetUtils.calendar,
                                                    color: Theme.of(context)
                                                        .primaryColorDark));
                                          },
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        AppTextField(
                                          labelText:
                                              S.of(context).preferredTime,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.preferredTimeController,
                                          readOnly: true,
                                          key: model.preferredTimeKey,
                                          onPressed: () {
                                            YearMonthDialog.show(context,
                                                title: S
                                                    .of(context)
                                                    .preferredTimeSmall,
                                                calendarEnum: CalendarEnum.TIME,
                                                onSelected: (time) {
                                              Navigator.pop(context);
                                              model.preferredTimeController
                                                  .text = time;
                                              model.isValid();
                                            }, onDismissed: () {
                                              Navigator.pop(context);
                                            });
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16,
                                                width: 16,
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: AppSvg.asset(
                                                    AssetUtils.downArrow,
                                                    color:
                                                        AppColor.dark_gray_1));
                                          },
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.allFieldValidatorStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return (isValid!)
                                              ? AnimatedButton(
                                                  buttonText: S
                                                      .of(context)
                                                      .swipeToProceed,
                                                  buttonHeight: 50,
                                                )
                                              : Container();
                                        }),
                                  ),
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
