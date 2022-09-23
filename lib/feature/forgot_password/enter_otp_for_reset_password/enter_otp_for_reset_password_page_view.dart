import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/feature/forgot_password/enter_otp_for_reset_password/enter_otp_for_reset_password_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EnterOTPForResetPasswordPageView extends BasePageViewWidget<EnterOTPForResetPasswordPageViewModel> {
  EnterOTPForResetPasswordPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.errorDetectorStream,
        initialData: false,
        dataBuilder: (context, isValid) {
          return ShakeAnimatedWidget(
            enabled: isValid ?? false,
            duration: Duration(milliseconds: 100),
            shakeAngle: Rotation.deg(z: 1),
            curve: Curves.easeInOutSine,
            child: AppStreamBuilder<Resource<VerifyForgetPasswordOtpResponse>>(
              stream: model.verifyOtpStream,
              initialData: Resource.none(),
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushNamed(context, RoutePaths.ResetPasswordSuccess);
                } else if (data.status == Status.ERROR) {
                  model.showToastWithError(data.appError!);
                }
              },
              dataBuilder: (context, isOtpVerified) {
                return GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (ProviderScope.containerOf(context)
                            .read(forgotPasswordViewModelProvider)
                            .appSwiperController
                            .page ==
                        2.0) {
                      if (StringUtils.isDirectionRTL(context)) {
                        if (!details.primaryVelocity!.isNegative) {
                          model.validateOtp(context);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(forgotPasswordViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      } else {
                        if (details.primaryVelocity!.isNegative) {
                          model.validateOtp(context);
                        } else {
                          ProviderScope.containerOf(context)
                              .read(forgotPasswordViewModelProvider)
                              .previousPage();
                          // .previous(animation: true);
                        }
                      }
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppOtpFields(
                              length: 6,
                              controller: model.otpController,
                              onChanged: (val) {
                                if (val.length == 6) model.validate(val);
                              },
                            ),
                            Column(
                              children: [
                                CountdownTimer(
                                  controller: model.countDownController,
                                  onEnd: () {},
                                  endTime: model.endTime,
                                  textStyle: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 16.t,
                                      color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                  widgetBuilder: (context, currentTimeRemaining) {
                                    return currentTimeRemaining == null
                                        ? TextButton(
                                            onPressed: () {
                                              model.updateTime(context);
                                            },
                                            child: Text(
                                              S.of(context).resendCode,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.t,
                                                  color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                            ))
                                        : Text(
                                            S.of(context).resendIn(
                                                '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14.t,
                                                color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                          );
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 16.0.h),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return Visibility(
                                          visible: isValid!,
                                          child: AnimatedButton(
                                            buttonHeight: 50,
                                            buttonText: S.of(context).swipeToProceed,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
