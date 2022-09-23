import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/change_my_number_dialog/change_my_number_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ValidateOtpPageView extends BasePageViewWidget<ValidateOtpViewModel> {
  ValidateOtpPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<bool>>(
                stream: model.changeMyNumberStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ProviderScope.containerOf(context)
                        .read(accountRegistrationViewModelProvider)
                        .updateMobileNumber(model.mobileNumberParams);
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.verifyOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        // var event = {
                        //   "definitionId": "ValidateOtp",
                        //   "properties": {"validated": true}
                        // };
                        // InfobipMobilemessaging.submitEventImmediately(event);
                        model.saveUserData();
                        Navigator.pushReplacementNamed(context, RoutePaths.Dashboard);
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          print(ProviderScope.containerOf(context)
                              .read(accountRegistrationViewModelProvider)
                              .appSwiperController
                              .page);
                          if (ProviderScope.containerOf(context)
                                  .read(accountRegistrationViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              2.0) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (details.primaryVelocity!.isNegative) {
                              } else {
                                model.validateOtp();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.validateOtp();
                              } else {
                                // ProviderScope.containerOf(context)
                                //     .read(accountRegistrationViewModelProvider)
                                //     .previousPage();
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
                                  SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppOtpFields(
                                          length: 6,
                                          controller: model.otpController,
                                          onChanged: (val) {
                                            if (val.length == 6) model.validate(val);
                                          },
                                        ),
                                        Center(
                                            child: Padding(
                                          padding: EdgeInsets.only(top: 32.0.h),
                                          child: InkWell(
                                            onTap: () {
                                              ChangeMyNumberDialog.show(context,
                                                  countryList: ProviderScope.containerOf(context)
                                                      .read(accountRegistrationViewModelProvider)
                                                      .countryDataList, onDismissed: () {
                                                Navigator.pop(context);
                                              }, onSelected: (country, mobileNo) {
                                                model.mobileNumberParams = MobileNumberParams(
                                                    mobileNumber: mobileNo, mobileCode: country.phoneCode!);
                                                Navigator.pop(context);
                                                model.changeMyNumber(mobileNo, country.phoneCode!);
                                              });
                                            },
                                            child: Text(
                                              S.of(context).changeMyNumber,
                                              style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: Theme.of(context).accentTextTheme.bodyText1!.color!,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
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
                                                    model.updateTime();
                                                  },
                                                  child: Text(
                                                    S.of(context).resendCode,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        color: Theme.of(context)
                                                            .accentTextTheme
                                                            .bodyText1!
                                                            .color!),
                                                  ))
                                              : Text(
                                                  S.of(context).resendIn(
                                                      '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 14.t,
                                                      color: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .color!),
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
                  );
                }),
          );
        },
      ),
    );
  }
}
