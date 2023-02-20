import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/bill_payments/pay_post_paid_bill/pay_post_paid_bill.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/paid_bill_conent.dart';
import 'package:domain/model/bill_payments/pay_prepaid_bill/pay_prepaid.dart';
import 'package:domain/model/bill_payments/validate_biller_otp/validate_biller_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page.dart';
import 'package:neo_bank/feature/prepaid_bill/prepaid_bills_success/prepaid_bills_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/app_progress.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'enter_otp_bill_payments_view_model.dart';

class EnterOtpBillPaymentsPageView extends BasePageViewWidget<EnterOtpBillPaymentsViewModel> {
  EnterOtpBillPaymentsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<PayPostPaidBill>>(
        stream: model.payPostPaidStream,
        initialData: Resource.none(),
        onData: (data) {
          if (data.status == Status.SUCCESS) {
            if (AppConstantsUtils.NICK_NAME.toString().trim().isNotEmpty) {
              AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = true;
            }
            Navigator.pushNamed(context, RoutePaths.PaidBillsSuccessPage,
                arguments: PaidBillsSuccessPageArguments(
                  data.data?.content?.billerList?[0].totalAmount ?? "0.0",
                  data.data?.content?.billerList?[0].fee ?? "0.0",
                  data.data?.content?.billerList?[0].billerName ?? "",
                  data.data?.content?.billerList?[0].billerNameAR ?? "",
                  AppConstantsUtils.NICK_NAME,
                  data.data?.content?.billerList?[0].refNo ?? "",
                  data.data?.content?.billerList?[0].isPaid ?? false,
                ));
            var errorBillFail = data.data?.content?.billerList?[0].statusDescription ?? "";
            if (errorBillFail == "err-377") {
              model.showToastWithError(AppError(
                  cause: Exception(),
                  error: ErrorInfo(message: ''),
                  type: ErrorType.BILL_PAYMENT_SORRY_MESSAGE));
            }
            if (errorBillFail == "err-379") {
              model.showToastWithError(AppError(
                  cause: Exception(),
                  error: ErrorInfo(message: ''),
                  type: ErrorType.REJECTED_DUE_TO_EXPIRY_DATE));
            }
          }
        },
        dataBuilder: (BuildContext context, data) {
          return AppStreamBuilder<Resource<PayPrePaid>>(
            initialData: Resource.none(),
            stream: model.payPrePaidStream,
            onData: (value) {
              if (value.status == Status.SUCCESS) {
                if (AppConstantsUtils.NICK_NAME.toString().trim().isNotEmpty) {
                  AppConstantsUtils.IS_NEW_BILL_ADD_API_CALL = true;
                }
                Navigator.pushNamed(context, RoutePaths.PrePaidBillsSuccessPage,
                    arguments: PrePaidBillsSuccessPageArguments(value.data!.content ?? PaidBillContent()));

                var errorBillFail = value.data?.content?.paidBill?[0].statusDescription ?? "";
                if (errorBillFail == "err-377") {
                  model.showToastWithError(AppError(
                      cause: Exception(),
                      error: ErrorInfo(message: ''),
                      type: ErrorType.BILL_PAYMENT_SORRY_MESSAGE));
                }
                if (errorBillFail == "err-379") {
                  model.showToastWithError(AppError(
                      cause: Exception(),
                      error: ErrorInfo(message: ''),
                      type: ErrorType.REJECTED_DUE_TO_EXPIRY_DATE));
                }
              }
            },
            dataBuilder: (context, snapshot) {
              return AppStreamBuilder<bool>(
                stream: model.errorDetectorStream,
                initialData: false,
                dataBuilder: (context, isError) {
                  return AppStreamBuilder<Resource<ValidateBillerOtp>>(
                    stream: model.enterOtpBillPaymentsResponseStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.LOADING) {
                        AppProgress(context);
                      } else {
                        Navigator.pop(context);
                      }
                      if (data.status == Status.SUCCESS) {
                        ProviderScope.containerOf(context)
                            .read(confirmBillPaymentAmountPageViewModelProvider)
                            .isOtpSend = data.data?.content?.isOtpSend;
                        ProviderScope.containerOf(context)
                            .read(confirmBillPaymentAmountPageViewModelProvider)
                            .isOtpRequired = data.data?.content?.isOtpRequired;
                        if (data.data?.content?.isOtpRequired == true &&
                            data.data?.content?.isOtpSend == true) {
                          // if(model.otpController.text == 6){
                          //   if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.PREPAID_KEY) {
                          //     model.payPrePaidBill(context);
                          //   } else if (AppConstantsUtils.BILLER_TYPE == AppConstantsUtils.POSTPAID_KEY) {
                          //     model.payPostPaidBill(context);
                          //   }
                          // }
                        } else if (data.data?.content?.isOtpSend == false) {
                          model.showToastWithError(AppError(
                              cause: Exception(),
                              error: ErrorInfo(message: ''),
                              type: ErrorType.SENDING_DEVICE_OTP_ERROR));
                        }
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return AppStreamBuilder<bool>(
                          stream: model.showButtonStream,
                          initialData: false,
                          dataBuilder: (context, isValid) {
                            return ShakeAnimatedWidget(
                              enabled: isError ?? false,
                              duration: Duration(milliseconds: 100),
                              shakeAngle: Rotation.deg(z: 1),
                              curve: Curves.easeInOutSine,
                              child: GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  FocusScope.of(context).unfocus();
                                  if (ProviderScope.containerOf(context)
                                          .read(payBillPageViewModelProvider)
                                          .appSwiperController
                                          .page ==
                                      2.0) {
                                    if (StringUtils.isDirectionRTL(context)) {
                                      if (!details.primaryVelocity!.isNegative) {
                                        if (model.otpController.text.length < 6) {
                                          AppError(
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.INVALID_OTP,
                                              cause: Exception());
                                          return;
                                        } else {
                                          if (ProviderScope.containerOf(context)
                                                      .read(confirmBillPaymentAmountPageViewModelProvider)
                                                      .isOtpSend ==
                                                  true &&
                                              ProviderScope.containerOf(context)
                                                      .read(confirmBillPaymentAmountPageViewModelProvider)
                                                      .isOtpRequired ==
                                                  true) {
                                            if (AppConstantsUtils.BILLER_TYPE ==
                                                AppConstantsUtils.PREPAID_KEY) {
                                              model.payPrePaidBill(context);
                                            } else if (AppConstantsUtils.BILLER_TYPE ==
                                                AppConstantsUtils.POSTPAID_KEY) {
                                              model.payPostPaidBill(context);
                                            }
                                          }
                                        }
                                      } else {
                                        ProviderScope.containerOf(context)
                                            .read(payBillPageViewModelProvider)
                                            .previousPage();
                                      }
                                    } else {
                                      if (details.primaryVelocity!.isNegative) {
                                        if (model.otpController.text.length < 6) {
                                          AppError(
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.INVALID_OTP,
                                              cause: Exception());
                                          return;
                                        } else {
                                          if (ProviderScope.containerOf(context)
                                                      .read(confirmBillPaymentAmountPageViewModelProvider)
                                                      .isOtpSend ==
                                                  true &&
                                              ProviderScope.containerOf(context)
                                                      .read(confirmBillPaymentAmountPageViewModelProvider)
                                                      .isOtpRequired ==
                                                  true) {
                                            if (AppConstantsUtils.BILLER_TYPE ==
                                                AppConstantsUtils.PREPAID_KEY) {
                                              model.payPrePaidBill(context);
                                            } else if (AppConstantsUtils.BILLER_TYPE ==
                                                AppConstantsUtils.POSTPAID_KEY) {
                                              model.payPostPaidBill(context);
                                            }
                                          }
                                        }
                                      } else {
                                        ProviderScope.containerOf(context)
                                            .read(payBillPageViewModelProvider)
                                            .previousPage();
                                      }
                                    }
                                  }
                                },
                                child: _cardView(context, model),
                              ),
                            );
                          });
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  _cardView(BuildContext context, EnterOtpBillPaymentsViewModel model) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                ? 0
                : MediaQuery.of(context).viewInsets.bottom - 48.0.h),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
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
                                      fontSize: 14.0.t,
                                      color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                                ))
                            : Text(
                                S.of(context).resendIn(
                                    '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 14.0.t,
                                    color: Theme.of(context).accentTextTheme.bodyText1!.color!),
                              );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.0.t, bottom: 74.0),
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
                )
              ],
            )),
      ),
    );
  }
}
