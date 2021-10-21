import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../../../../di/register/register_modules.dart';
import '../../../../ui/molecules/app_keyboard_hide.dart';
import '../../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../../utils/parser/error_parser.dart';
import '../../../../utils/resource.dart';
import '../../../../utils/status.dart';

class ValidateOtpPageView extends BasePageViewWidget<ValidateOtpViewModel> {
  ValidateOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).accountRegistration,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Column(
              children: [
                Text(
                  S.of(context).enterOtpHeader,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.very_dark_gray,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '+962 79 322 8080',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.vivid_orange,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            child: AppStreamBuilder<bool>(
              stream: model.errorDetectorStream,
              initialData: false,
              dataBuilder: (context, isValid) {
                return ShakeAnimatedWidget(
                  enabled: isValid ?? false,
                  duration: Duration(milliseconds: 100),
                  shakeAngle: Rotation.deg(z: 1),
                  curve: Curves.easeInOutSine,
                  child: AppStreamBuilder<Resource<bool>>(
                    stream: model.verifyOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(registerStepOneViewModelProvider)
                            .pageController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return GestureDetector(
                        onHorizontalDragUpdate: (details) {
                          if (details.primaryDelta!.isNegative) {
                            model.validateOtp();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(registerStepOneViewModelProvider)
                                .pageController
                                .previousPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          }
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 2,
                          shadowColor: AppColor.black.withOpacity(0.32),
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
                                      end: Alignment.topCenter)),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SingleChildScrollView(
                                        physics: ClampingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            AppOtpFields(
                                              length: 6,
                                              controller: model.otpController,
                                              onChanged: (val) =>
                                                  model.validate(),
                                            ),
                                            Visibility(
                                              visible: isValid!,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  ErrorParser
                                                      .getLocalisedStringError(
                                                          error: isOtpVerified!
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
                                            Center(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 32.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: Text(
                                                  S.of(context).changeMyNumber,
                                                  style: TextStyle(
                                                    color:
                                                        AppColor.vivid_orange,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            )),
                                            SizedBox(
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                      ),
                                      CountdownTimer(
                                        controller: model.countDownController,
                                        onEnd: () {},
                                        endTime: model.endTime,
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: AppColor.white),
                                        widgetBuilder:
                                            (context, currentTimeRemaining) {
                                          return currentTimeRemaining == null
                                              ? TextButton(
                                                  onPressed: () {
                                                    model.updateTime();
                                                  },
                                                  child: Text(
                                                    'Resend Code',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: AppColor.white),
                                                  ))
                                              : Text(
                                                  S.of(context).resendIn(
                                                      '${currentTimeRemaining.min ?? 00}:${currentTimeRemaining.sec ?? 00}'),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          AppColor.soft_violet),
                                                );
                                        },
                                      ),
                                    ],
                                  ),
                                  AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return Visibility(
                                          visible: isValid!,
                                          child: Positioned(
                                            bottom: 0,
                                            left: 45,
                                            right: 45,
                                            child: AnimatedButton(
                                              buttonText:
                                                  S.of(context).swipeToProceed,
                                            ),
                                          ),
                                        );
                                      })
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
      ),
    );
  }
}
