import 'package:animated_widgets/animated_widgets.dart';
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
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ScheduleVideoCallPageView
    extends BasePageViewWidget<ScheduleVideoCallPageViewModel> {
  ScheduleVideoCallPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Text(
          S.of(context).personalDetails,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).pleaseSelectPreferredAgentForVideoCall,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.very_dark_gray,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
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
                          .nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
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
                              .jumpToPage(1);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            decoration: BoxDecoration(
                              color: AppColor.very_soft_violet,
                              gradient: LinearGradient(
                                  colors: [
                                    AppColor.dark_violet,
                                    AppColor.dark_moderate_blue
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
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
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
                                                            localisedHelper:
                                                                S.of(context)),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.vivid_red),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                ///TODO: move after dialog integration
                                                model.preferredDateController
                                                    .text = '15 October 2021';
                                                model.isValid();
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: AppSvg.asset(
                                                      AssetUtils.calendar)),
                                            );
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
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
                                                            localisedHelper:
                                                                S.of(context)),
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            AppColor.vivid_red),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                ///TODO: move after dialog integration
                                                model.preferredTimeController
                                                    .text = '10:30 AM';
                                                model.isValid();
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
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
                                    padding: EdgeInsets.only(right: 45),
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
