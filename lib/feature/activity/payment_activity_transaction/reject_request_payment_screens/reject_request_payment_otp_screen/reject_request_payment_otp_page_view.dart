import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_otp_screen/reject_request_payment_page_view_model.dart';
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

class RejectRequestPaymentOtpPageView extends BasePageViewWidget<RejectRequestPaymentOtpPageViewModel> {
  RejectRequestPaymentOtpPageView(ProviderBase model) : super(model);

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
                stream: model.requestToPayResultStream,
                initialData: Resource.none(),
                onData: (data) async {
                  if (data.status == Status.SUCCESS) {
                    ///LOG EVENT TO FIREBASE
                    await FireBaseLogUtil.fireBaseLog("reject_rtp_success", {"is_reject_rtp_success": true});

                    Navigator.pushNamed(context, RoutePaths.PaymentTransationSuccess,
                        arguments: PaymentTransationSuccessArgument(
                            ammount: ProviderScope.containerOf(context)
                                .read(rejectRequestPaymentPageViewModelProvider)
                                .argument
                                .amount,
                            name: ProviderScope.containerOf(context)
                                .read(rejectRequestPaymentPageViewModelProvider)
                                .argument
                                .name,
                            statusInfo: ProviderScope.containerOf(context)
                                .read(rejectRequestPaymentPageViewModelProvider)
                                .argument
                                .statusInfo,
                            iban: ProviderScope.containerOf(context)
                                .read(rejectRequestPaymentPageViewModelProvider)
                                .argument
                                .iban));

                    // model.getRequestMoneyActivity(
                    //     true, model.filterDays, model.transactionType);
                  } else if (data.status == Status.ERROR) {
                    await FireBaseLogUtil.fireBaseLog("reject_rtp_failure", {"is_reject_rtp_failure": true});
                  }
                },
                dataBuilder: (context, snapshot) {
                  return AppStreamBuilder<Resource<bool>>(
                      stream: model.otpValidationStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          if (data.data!) {
                            model.requestToPayResult(
                                CustID: ProviderScope.containerOf(context)
                                    .read(rejectRequestPaymentPageViewModelProvider)
                                    .argument
                                    .custID,
                                OrgnlMsgId: ProviderScope.containerOf(context)
                                    .read(rejectRequestPaymentPageViewModelProvider)
                                    .argument
                                    .OrgnlMsgId,
                                RTPStatus: ProviderScope.containerOf(context)
                                    .read(rejectRequestPaymentPageViewModelProvider)
                                    .argument
                                    .rtpStatus,
                                RejectReason: ProviderScope.containerOf(context)
                                    .read(selectRejectReasonPageViewModelProvider)
                                    .reasonToRejectController
                                    .text,
                                RejectADdInfo: ProviderScope.containerOf(context)
                                    .read(selectRejectReasonPageViewModelProvider)
                                    .rejectADdInfo,
                                GetToken: true,
                                otpCode: model.otpController.text);
                            //  Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);

                          }
                        }
                      },
                      dataBuilder: (context, enterOtpForCliqResponse) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(rejectRequestPaymentPageViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                1.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.validateOtp();
                                } else {
                                  model.otpController.clear();
                                  ProviderScope.containerOf(context)
                                      .read(rejectRequestPaymentPageViewModelProvider)
                                      .previousPage();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.validateOtp();
                                } else {
                                  model.otpController.clear();
                                  ProviderScope.containerOf(context)
                                      .read(rejectRequestPaymentPageViewModelProvider)
                                      .previousPage();
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
                                            key: model.otpControllerKey,
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
                                              color: Theme.of(context).textTheme.bodyMedium!.color!),
                                          widgetBuilder: (context, currentTimeRemaining) {
                                            return currentTimeRemaining == null
                                                ? TextButton(
                                                    onPressed: () {
                                                      model.makeRejectOtpRequest();
                                                    },
                                                    child: Text(
                                                      S.of(context).resendCode,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.t,
                                                          fontWeight: FontWeight.w600,
                                                          color: Theme.of(context).textTheme.bodyMedium!.color!),
                                                    ))
                                                : Text(
                                                    S.of(context).resendIn(
                                                        '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).textTheme.bodyMedium!.color!),
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
                                                    buttonHeight: 50.h,
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
                      });
                }),
          );
        },
      ),
    );
  }
}
