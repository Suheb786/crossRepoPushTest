import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_otp_fields.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'accept_request_money_otp_page_view_model.dart';

class AcceptRequestMoneyOtpPageView extends BasePageViewWidget<AcceptRequestMoneyOtpPageViewModel> {
  AcceptRequestMoneyOtpPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 96.0.h, start: 24.w, end: 24.w, bottom: 36.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).requestMoney.toUpperCase(),
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: AppColor.veryDarkGray2,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              // "${S.of(context).enterOtpHeader} \n ${'+962 79 322 8080'}",
              "${S.of(context).enterOtpHeader}\n ${model.argument.mobileCode.replaceAll('00', '+')}" +
                  " ${model.argument.mobileNumber}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: AppColor.veryDarkGray2,
              ),
            ),
            SizedBox(
              height: 32.h,
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
                        stream: model.approveRTPRequestStream,
                        initialData: Resource.none(),
                        onData: (data) async {
                          if (data.status == Status.SUCCESS) {
                            ///LOG EVENT TO FIREBASE
                            await FireBaseLogUtil.fireBaseLog("rtp_accepted", {"is_rtp_accepted": true});
                            Navigator.pushNamed(context, RoutePaths.PaymentTransationSuccess,
                                arguments: PaymentTransationSuccessArgument(
                                    ammount: model.argument.approveRtpData.amount,
                                    name: model.argument.approveRtpData.name,
                                    statusInfo: model.argument.approveRtpData.statusInfo,
                                    iban: model.argument.approveRtpData.iban));
                            // model.getRequestMoneyActivity(
                            //     true, model.filterDays, model.transactionType);
                          }
                        },
                        dataBuilder: (context, snapshot) {
                          return AppStreamBuilder<Resource<bool>>(
                              stream: model.otpValidationStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  // /TODO approveRTPRequest

                                  model.approveRTPRequest(
                                      custID: model.argument.approveRtpData.custID,
                                      dbtrAcct: model.argument.approveRtpData.dbtrAcct,
                                      dbtrName: model.argument.approveRtpData.dbtrName,
                                      dbtrPstlAdr: model.argument.approveRtpData.dbtrPstlAdr,
                                      dbtrRecordID: model.argument.approveRtpData.dbtrRecordID,
                                      currency: model.argument.approveRtpData.currency,
                                      amount: model.argument.approveRtpData.amount,
                                      dbtrAlias: model.argument.approveRtpData.dbtrAlias,
                                      cdtrBic: model.argument.approveRtpData.cdtrBic,
                                      cdtrName: model.argument.approveRtpData.cdtrName,
                                      cdtrAcct: model.argument.approveRtpData.cdtrAcct,
                                      cdtrPstlAdr: model.argument.approveRtpData.cdtrPstlAdr,
                                      cdtrRecordID: model.argument.approveRtpData.cdtrRecordID,
                                      cdtrAlias: model.argument.approveRtpData.cdtrAlias,
                                      rgltryRptg: model.argument.approveRtpData.rgltryRptg,
                                      payRefNo: model.argument.approveRtpData.payRefNo,
                                      OrgnlMsgId: model.argument.approveRtpData.orgnlMsgId,
                                      CtgyPurp: model.argument.approveRtpData.ctgyPurp,
                                      rejectReason: model.argument.approveRtpData.rejectReason,
                                      rtpStatus: model.argument.approveRtpData.rtpStatus,
                                      rejectADdInfo: model.argument.approveRtpData.rejectADdInfo,
                                      otpCode: model.otpController.text,
                                      getToken: true);

                                  //    Navigator.pushReplacementNamed(context, RoutePaths.CliqIdCreationSuccess);

                                }
                              },
                              dataBuilder: (context, otpValidationResponse) {
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity!.isNegative) {
                                      model.validateOtp();
                                    } else {
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Card(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
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
                                          Column(
                                            children: [
                                              CountdownTimer(
                                                controller: model.countDownController,
                                                onEnd: () {},
                                                endTime: model.endTime,
                                                textStyle: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 16.t,
                                                    color:
                                                        Theme.of(context).accentTextTheme.bodyText1!.color!),
                                                widgetBuilder: (context, currentTimeRemaining) {
                                                  return currentTimeRemaining == null
                                                      ? TextButton(
                                                          onPressed: () {
                                                            model.makeApproveRTPOtpRequest();
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
                                              AppStreamBuilder<bool>(
                                                stream: model.showButtonStream,
                                                initialData: false,
                                                dataBuilder: (BuildContext context, isValid) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                      top: 26.0.h,
                                                    ),
                                                    child: Visibility(
                                                      visible: isValid!,
                                                      child: AnimatedButton(
                                                          buttonText: S.of(context).swipeToProceed),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
