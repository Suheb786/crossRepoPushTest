import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/qr_scan_otp/qr_scan_otp_page_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_via_qr_success/send_money_via_qr_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';
import '../../../../utils/color_utils.dart';

class QRScanOTPPageView extends BasePageViewWidget<QRScanOTPPageViewModel> {
  QRScanOTPPageView(ProviderBase model) : super(model);

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
            child: AppStreamBuilder<Resource<QRTransferResponse>>(
                stream: model.transferQRStream,
                initialData: Resource.none(),
                onData: (data) async {
                  if (data.status == Status.SUCCESS) {
                    ///LOG EVENT TO FIREBASE
                    await FirebaseAnalytics.instance.logEvent(name: "payment_success", parameters: {
                      "is_payment_success": true.toString(),
                      "request_id": ProviderScope.containerOf(context)
                              .read(sendMoneyQrScanningViewModelProvider)
                              .arguments
                              ?.requestId ??
                          ''
                    });

                    ///Log event to infobip
                    var event = {
                      "definitionId": "PaymentSuccess",
                      "properties": {"completed": true}
                    };
                    InfobipMobilemessaging.submitEventImmediately(event);

                    Navigator.pushNamed(context, RoutePaths.SendMoneyQrScanningSuccess,
                        arguments: SendMoneyViaQRSuccessPageArguments(
                            referenceNo: data.data?.qrContent?.reference ?? '',
                            amount: '${data.data?.qrContent?.amount ?? ''}',
                            user: data.data?.qrContent?.name ?? ''));
                  }
                },
                dataBuilder: (context, checkSendMoneyResponse) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (ProviderScope.containerOf(context)
                              .read(sendMoneyQrScanningViewModelProvider)
                              .appSwiperController
                              .page ==
                          1.0) {
                        FocusScope.of(context).unfocus();
                        if (StringUtils.isDirectionRTL(context)) {
                          if (!details.primaryVelocity!.isNegative) {
                            model.transferQR(context: context);
                          } else {
                            ProviderScope.containerOf(context)
                                .read(sendMoneyQrScanningViewModelProvider)
                                .previousPage();
                          }
                        } else {
                          if (details.primaryVelocity!.isNegative) {
                            model.transferQR(context: context);
                          } else {
                            ProviderScope.containerOf(context)
                                .read(sendMoneyQrScanningViewModelProvider)
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
                                                model.resendOtp();
                                              },
                                              child: Text(
                                                S.of(context).resendCode,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 14.t,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context).textTheme.bodyLarge!.color!),
                                              ))
                                          : Text(
                                              S.of(context).resendIn(
                                                  '${currentTimeRemaining.min != null ? (currentTimeRemaining.min! < 10 ? "0${currentTimeRemaining.min}" : currentTimeRemaining.min) : "00"}:${currentTimeRemaining.sec != null ? (currentTimeRemaining.sec! < 10 ? "0${currentTimeRemaining.sec}" : currentTimeRemaining.sec) : "00"}'),
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w600,
                                                  color: Theme.of(context).textTheme.bodyLarge!.color!),
                                            );
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 16.0.h,bottom: 16.0.h),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.showButtonStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return AppPrimaryButton(
                                            text: S.of(context).next,
                                            isDisabled: !isValid!,
                                            onPressed: () {
                                              model.transferQR(context: context);
                                            },
                                          );
                                        }),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      ProviderScope.containerOf(context)
                                          .read(sendMoneyQrScanningViewModelProvider)
                                          .previousPage();
                                    },
                                    child: Text(
                                      S.of(context).back,
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14.0.t,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.brightBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
