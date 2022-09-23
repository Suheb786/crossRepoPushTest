import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin/otp_for_change_card_pin/otp_for_change_card_pin_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page.dart';
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

class OtpForChangeCardPinPageView extends BasePageViewWidget<OtpForChangeCardPinPageViewModel> {
  OtpForChangeCardPinPageView(ProviderBase model) : super(model);

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
                stream: model.changDebitCardPinStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    Navigator.pushNamed(context, RoutePaths.ChangeCardPinSuccess,
                        arguments: ChangeCardPinSuccessArguments(
                            cardType: ProviderScope.containerOf(context)
                                .read(changeCardPinViewModelProvider)
                                .changeCardPinArguments
                                .cardType!));
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, isOtpVerified) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.verifyOtpStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                                    .read(changeCardPinViewModelProvider)
                                    .changeCardPinArguments
                                    .cardType ==
                                CardType.DEBIT
                            ? model.changeDebitCardPin(
                                cardNumber: ProviderScope.containerOf(context)
                                        .read(changeCardPinViewModelProvider)
                                        .changeCardPinArguments
                                        .cardNumber ??
                                    '',
                                pin: ProviderScope.containerOf(context)
                                    .read(enterNewCardPinViewModelProvider)
                                    .confirmPinController
                                    .text,
                                tokenizedPan: ProviderScope.containerOf(context)
                                        .read(changeCardPinViewModelProvider)
                                        .changeCardPinArguments
                                        .tokenizedPan ??
                                    '')
                            : () {};
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(changeCardPinViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              1.0) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                model.validateOtp();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(changeCardPinViewModelProvider)
                                    .previousPage();
                                // .previous();
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.validateOtp();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(changeCardPinViewModelProvider)
                                    .previousPage();
                                // .previous();
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
                                            model.validate(val);
                                          },
                                        ),
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
                                                    model.resendOtp();
                                                  },
                                                  child: Text(
                                                    S.of(context).resendCode,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        fontWeight: FontWeight.w600,
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
                                                      fontWeight: FontWeight.w600,
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
                                      ),
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
