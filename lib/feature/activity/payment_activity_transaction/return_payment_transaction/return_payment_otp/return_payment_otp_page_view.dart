import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_otp/return_payment_otp_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ReturnPaymentOtpPageView extends BasePageViewWidget<ReturnPaymentOtpPageViewModel> {
  ReturnPaymentOtpPageView(ProviderBase model) : super(model);

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
                    initialData: Resource.none(),
                    stream: model.returnRTPrequeststream,
                    onData: (value) async {
                      if (value.status == Status.SUCCESS) {
                        await FireBaseLogUtil.fireBaseLog(
                            "return_payment_success", {"is_return_payment_success": true});

                        Navigator.pushNamed(context, RoutePaths.PaymentTransationSuccess,
                            arguments: PaymentTransationSuccessArgument(
                                ammount: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .amount
                                    .toString(),
                                name: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .name,
                                statusInfo: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .statusInfo,
                                iban: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .iban));
                      } else if (value.status == Status.ERROR) {
                        await FireBaseLogUtil.fireBaseLog(
                            "return_payment_failure", {"is_return_payment_failure": true});
                      }
                    },
                    dataBuilder: (context, returnRTPrequestSnapshot) {
                      return AppStreamBuilder<Resource<bool>>(
                          stream: model.returnPaymentOtpValidationStream,
                          initialData: Resource.none(),
                          onData: (value) {
                            if (value.status == Status.SUCCESS) {
                              model.returnRTPrequest(
                                custID: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .custID,
                                messageID: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .messageID,
                                dbtrAcct: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .dbtrAcct,
                                dbtrName: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .dbtrName,
                                cdtrAcct: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .cdtrAcct,
                                cdtrName: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .cdtrName,
                                currency: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .currency,
                                amount: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .amount,
                                rtrnReason: ProviderScope.containerOf(context)
                                    .read(returnPaymentSelectionPageViewModelProvider)
                                    .returnReasonCode,
                                rtrnAddInfo: ProviderScope.containerOf(context)
                                    .read(returnPaymentSelectionPageViewModelProvider)
                                    .reasonToReturnController
                                    .text,
                                isDispute: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .isDispute,
                                disputeRefNo: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .disputeRefNo,
                                otpCode: model.otpController.text,
                                getToken: ProviderScope.containerOf(context)
                                    .read(returnPaymentTransactionSliderPageViewModelProvider)
                                    .returnArgument
                                    .getToken,
                              );
                            }
                          },
                          dataBuilder: (context, enterOTP) {
                            return Card(
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
                                              key: model.otpKey,
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
                                              color: AppColor.sky_blue_mid,
                                            ),
                                            widgetBuilder: (context, currentTimeRemaining) {
                                              return currentTimeRemaining == null
                                                  ? TextButton(
                                                      onPressed: () {
                                                        model.otpController.clear();
                                                        ProviderScope.containerOf(context)
                                                            .read(returnPaymentSelectionPageViewModelProvider)
                                                            .returnRTPrequestOTP();
                                                      },
                                                      child: Text(
                                                        S.of(context).resendCode,
                                                        style: TextStyle(
                                                            fontFamily: StringUtils.appFont,
                                                            fontSize: 14.t,
                                                            fontWeight: FontWeight.w600,
                                                            color: Theme.of(context)
                                                                .textTheme
                                                                .bodyLarge!
                                                                .color!),
                                                      ))
                                                  : Text(
                                                      S.of(context).resendIn(
                                                          '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          fontSize: 14.t,
                                                          fontWeight: FontWeight.w600,
                                                          color:
                                                              Theme.of(context).textTheme.bodyLarge!.color!),
                                                    );
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                                            child: AppStreamBuilder<bool>(
                                                stream: model.showButtonSubjectStream,
                                                initialData: false,
                                                dataBuilder: (context, isValid) {
                                                  return AppPrimaryButton(
                                                    text: S.of(context).next,
                                                    isDisabled: !isValid!,
                                                    onPressed: () {
                                                      model.validateOTP();
                                                    },
                                                  );
                                                }),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              model.otpController.clear();

                                              ProviderScope.containerOf(context)
                                                  .read(returnPaymentTransactionSliderPageViewModelProvider)
                                                  .previousPage();
                                            },
                                            child: Text(
                                              S.current.back,
                                              style: TextStyle(
                                                color: AppColor.brightBlue,
                                                fontSize: 14.t,
                                                letterSpacing: 1.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            );
                          });
                    }));
          }),
    );
  }
}
