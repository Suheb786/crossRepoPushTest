import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
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
                onData: (data) {
                  print('status---->${data.status}');
                  if (data.status == Status.SUCCESS) {
                    print('success');

                    ///LOGGING EVENT TO APP FLYER
                    model.logEventsForAppFlyer(
                        eventName: 'send_money_to_new_contact',
                        eventValue: {"money_sent": data.data?.transferSuccessContent?.amount ?? 0.0});
                    Navigator.pushNamed(context, RoutePaths.SendAmountToContactSuccess,
                        arguments: data.data!.transferSuccessContent);
                  } else if (data.status == Status.ERROR) {
                    print('error');
                    print('error code-->${data.appError!.type}');
                    Navigator.pushNamed(context, RoutePaths.SendMoneyFailure);
                  }
                },
                dataBuilder: (context, transferResponse) {
                  return AppStreamBuilder<Resource<bool>>(
                    stream: model.enterOtpBillPaymentsResponseStream,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                      } else if (data.status == Status.ERROR) {
                        model.showToastWithError(data.appError!);
                      }
                    },
                    dataBuilder: (context, isOtpVerified) {
                      return Container(
                        padding: EdgeInsetsDirectional.only(top: 56.h),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: DotsIndicator(
                                dotsCount: 2,
                                position: 2.0,
                                mainAxisSize: MainAxisSize.max,
                                decorator: DotsDecorator(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    activeSize: Size(MediaQuery.of(context).size.width / 2.5, 5),
                                    size: Size(MediaQuery.of(context).size.width / 2.5, 5),
                                    spacing: EdgeInsets.symmetric(horizontal: 1),
                                    activeShape:
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    activeColor: Theme.of(context).accentColor,
                                    color: AppColor.very_dark_gray1.withOpacity(0.5)),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 36.h),
                              child: Column(
                                children: [
                                  Text(
                                    S.of(context).payBill,
                                    style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontSize: 10.t,
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 8.h),
                                    child: Text(
                                      S.of(context).confirmYourPaymentAmtBelow,
                                    ),
                                  ),
                                  Expanded(
                                      child: GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      if (ProviderScope.containerOf(context)
                                              .read(paymentToNewRecipientViewModelProvider)
                                              .appSwiperController
                                              .page ==
                                          1.0) {
                                        FocusScope.of(context).unfocus();
                                        if (StringUtils.isDirectionRTL(context)) {
                                          if (!details.primaryVelocity!.isNegative) {
                                            model.enterOtpBillPayments();
                                          } else {
                                            ProviderScope.containerOf(context)
                                                .read(paymentToNewRecipientViewModelProvider)
                                                .previousPage();
                                            // .previous(animation: true);
                                          }
                                        } else {
                                          if (details.primaryVelocity!.isNegative) {
                                            model.enterOtpBillPayments();
                                          } else {
                                            ProviderScope.containerOf(context)
                                                .read(paymentToNewRecipientViewModelProvider)
                                                .previousPage();
                                            // .previous(animation: true);
                                          }
                                        }
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: 96.0.h, bottom: 56.0.h, start: 24.w, end: 24.w),
                                      child: GestureDetector(
                                        onHorizontalDragUpdate: (details) {
                                          if (details.primaryDelta!.isNegative) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Text(
                                              "asldkaslkdakl",
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  color: AppColor.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20.0.t),
                                            ),
                                            SizedBox(
                                              height: 3.h,
                                            ),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                text: "0.0",
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 28.0.t),
                                              ),
                                              TextSpan(
                                                text: ' ${S.of(context).JOD}',
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: AppColor.gray5,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.0.t),
                                              ),
                                            ])),
                                            SizedBox(
                                              height: 43.h,
                                            ),
                                            Expanded(
                                              child: Card(
                                                margin: EdgeInsets.zero,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context).viewInsets.bottom - 50.0.h <=
                                                                  0
                                                              ? 0
                                                              : MediaQuery.of(context).viewInsets.bottom -
                                                                  48.0.h),
                                                  child: Container(
                                                      padding: EdgeInsets.symmetric(
                                                          vertical: 32.0.h, horizontal: 24.0.w),
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
                                                                    color: Theme.of(context)
                                                                        .accentTextTheme
                                                                        .bodyText1!
                                                                        .color!),
                                                                widgetBuilder:
                                                                    (context, currentTimeRemaining) {
                                                                  return currentTimeRemaining == null
                                                                      ? TextButton(
                                                                          onPressed: () {
                                                                            model.updateTime();
                                                                          },
                                                                          child: Text(
                                                                            S.of(context).resendCode,
                                                                            style: TextStyle(
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.0.t,
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
                                                                              fontSize: 14.0.t,
                                                                              color: Theme.of(context)
                                                                                  .accentTextTheme
                                                                                  .bodyText1!
                                                                                  .color!),
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
                                                                          buttonText:
                                                                              S.of(context).swipeToProceed,
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
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            )),
                          ],
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
