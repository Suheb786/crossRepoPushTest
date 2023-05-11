import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/enter_otp/enter_otp_view_model.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EnterOtpPageView extends BasePageViewWidget<EnterOtpViewModel> {
  EnterOtpPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<TransferSuccessResponse>>(
                stream: model.transferStream,
                initialData: Resource.none(),
                onData: (data) async {
                  if (data.status == Status.SUCCESS) {
                    ///LOGGING EVENT TO APP FLYER
                    model.logEventsForAppFlyer(
                        eventName: 'send_money_to_new_contact',
                        eventValue: {"money_sent": data.data?.transferSuccessContent?.amount ?? 0.0});

                    if (ProviderScope.containerOf(context)
                        .read(sendToNewRecipientViewModelProvider)
                        .isFriend) {
                      ///LOG EVENT TO FIREBASE
                      await FireBaseLogUtil.fireBaseLog("send_money_success_new_contact_saved", {
                        "is_money_sent": true,
                        "money_sent": data.data?.transferSuccessContent?.amount ?? 0.0
                      });
                    } else {
                      ///LOG EVENT TO FIREBASE
                      await FireBaseLogUtil.fireBaseLog("send_money_success_new_contact", {
                        "is_money_sent": true,
                        "money_sent": data.data?.transferSuccessContent?.amount ?? 0.0
                      });
                    }
                    data.data?.transferSuccessContent?.paymentMadeTo = ProviderScope.containerOf(context)
                        .read(sendToNewRecipientViewModelProvider)
                        .ibanOrMobileController
                        .text;
                    Navigator.pushNamed(context, RoutePaths.SendAmountToContactSuccess,
                        arguments: data.data!.transferSuccessContent);
                  } else if (data.status == Status.ERROR) {
                    ///LOG EVENT TO FIREBASE
                    await FireBaseLogUtil.fireBaseLog(
                        "send_money_new_contact_failure", {"is_money_sent": false});

                    if (data.appError!.type == ErrorType.INVALID_OTP_NETWORK) {
                      model.showToastWithError(data.appError!);
                    } else if (data.appError!.type == ErrorType.DAILY_LIMIT_EXCEDED) {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.SendMoneyFailure,
                        arguments: SendMoneyFailurePageArgument(
                            title: S.of(context).sendMoneyNotSuccessful,
                            content: S.of(context).dailyLimitExceededorTryLater),
                      );
                    } else if (data.appError!.type == ErrorType.NICKNAME_ALREADY_EXISTS) {
                      model.showToastWithError(data.appError!);
                    } else if (data.appError!.type == ErrorType.LOGIN_REGISTER_DISABLED) {
                      model.showToastWithError(data.appError!);
                    } else {
                      Navigator.pushNamed(
                        context,
                        RoutePaths.SendMoneyFailure,
                        arguments: SendMoneyFailurePageArgument(
                            title: S.of(context).sendMoneyNotSuccessful,
                            content: S.of(context).tryAgainLater),
                      );
                    }
                  }
                },
                dataBuilder: (context, transferResponse) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.enterOtpResponseStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        model.transfer(
                            nickName: ProviderScope.containerOf(context)
                                    .read(sendToNewRecipientViewModelProvider)
                                    .addNickNameController
                                    .text
                                    .isEmpty
                                ? ""
                                : ProviderScope.containerOf(context)
                                    .read(sendToNewRecipientViewModelProvider)
                                    .addNickNameController
                                    .text,
                            transferResponse: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .transferResponse,
                            memo: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .purposeDetail!
                                .strCode!,
                            isFriend: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .isFriend,
                            beneficiaryImage: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .selectedProfile,
                            limit: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .limit!,
                            amount: ProviderScope.containerOf(context)
                                .read(sendMoneyViewModelProvider)
                                .currentPinValue,
                            recipientName: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .recipientNameController
                                .text,
                            recipientAddress: ProviderScope.containerOf(context)
                                .read(sendToNewRecipientViewModelProvider)
                                .recipientAddressController
                                .text);
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (ProviderScope.containerOf(context)
                                  .read(paymentToNewRecipientViewModelProvider)
                                  .appSwiperController
                                  .page ==
                              1.0) {
                            FocusScope.of(context).unfocus();
                            if (StringUtils.isDirectionRTL(context)) {
                              if (!details.primaryVelocity!.isNegative) {
                                model.enterOtp();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(paymentToNewRecipientViewModelProvider)
                                    .previousPage();
                                // .previous(animation: true);
                              }
                            } else {
                              if (details.primaryVelocity!.isNegative) {
                                model.enterOtp();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(paymentToNewRecipientViewModelProvider)
                                    .previousPage();
                                // .previous(animation: true);
                              }
                            }
                          }
                        },
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                    ? 0
                                    : MediaQuery.of(context).viewInsets.bottom - 48.0.h),
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 24.0.w),
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
                                              fontSize: 16.0.t,
                                              color: Theme.of(context).textTheme.bodyMedium!.color!),
                                          widgetBuilder: (context, currentTimeRemaining) {
                                            return currentTimeRemaining == null
                                                ? TextButton(
                                                    onPressed: () {
                                                      model.updateTime(
                                                          amount: ProviderScope.containerOf(context)
                                                              .read(sendMoneyViewModelProvider)
                                                              .currentPinValue);
                                                    },
                                                    child: Text(
                                                      S.of(context).resendCode,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.0.t,
                                                          color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                    ))
                                                : Text(
                                                    S.of(context).resendIn(
                                                        '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.0.t,
                                                        color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                  );
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 16.0.t),
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
