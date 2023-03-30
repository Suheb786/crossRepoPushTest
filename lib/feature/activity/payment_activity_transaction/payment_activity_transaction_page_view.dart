// ignore_for_file: deprecated_member_use

import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/payment_activity_transacton_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import 'accept_request_money_otp_screen/accept_request_money_otp_page.dart';

class PaymentActivityTransactionPageView extends BasePageViewWidget<PaymentActivityTransactionViewModel> {
  PaymentActivityTransactionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 52.0.h),
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta!.isNegative) {
            } else {
              Navigator.pop(context);
            }
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                child: Center(
                  child: Text(
                    S.of(context).paymentActivity,
                    style: TextStyle(
                        color: AppColor.veryDarkGray2,
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0.t),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 35.0.h),
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 8.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              height: 4.0.h,
                              width: 64.0.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4), color: AppColor.white_gray),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 38.0.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppStreamBuilder<String>(
                                    stream: model.transactionTypeResponseStream,
                                    initialData: StringUtils.isDirectionRTL(context)
                                        ? "كل الحركات"
                                        : 'All Transactions',
                                    dataBuilder: (context, transactionType) {
                                      return InkWell(
                                        onTap: () {
                                          PaymentActivityFilterDialog.show(context, type: FilterType.type,
                                              onSelected: (value) {
                                            Navigator.pop(context);
                                            model.updateTransactionType(value);
                                          }, onDismissed: () {
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: AppColor.whiteGray,
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                transactionType!,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 12.0.t,
                                                    color: AppColor.veryDarkGray2,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional.only(
                                                  start: 12.0.w,
                                                ),
                                                child: AppSvg.asset(
                                                  AssetUtils.dropDown,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                AppStreamBuilder<String>(
                                    stream: model.paymentPeriodResponseStream,
                                    initialData:
                                        StringUtils.isDirectionRTL(context) ? "آخر 30 يوم" : 'Last 30 days',
                                    dataBuilder: (mContext, paymentPeriod) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                        child: InkWell(
                                          onTap: () {
                                            PaymentActivityFilterDialog.show(context, type: FilterType.period,
                                                onSelected: (value) {
                                              Navigator.pop(context);
                                              model.updatePaymentPeriod(value);
                                            }, onDismissed: () {
                                              Navigator.pop(context);
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: AppColor.whiteGray,
                                            ),
                                            padding:
                                                EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  paymentPeriod!,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 12.0.t,
                                                      color: AppColor.veryDarkGray2,
                                                      fontWeight: FontWeight.w600),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional.only(start: 12.0.w),
                                                  child: AppSvg.asset(AssetUtils.dropDown),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 0.0.h, start: 24.0.w, end: 24.0.w),
                              child: AppStreamBuilder<Resource<PaymentActivityResponse>>(
                                  stream: model.requestMoneyActivity,
                                  initialData: Resource.none(),
                                  dataBuilder: (context, requestActivity) {
                                    switch (requestActivity!.status) {
                                      case Status.SUCCESS:
                                        return ListView.builder(
                                          itemBuilder: (context, index) {
                                            return (requestActivity.data?.paymentActivityContent ?? [])
                                                        .length >
                                                    0
                                                ? PaymentActivityTransactionWidget(
                                                    content: requestActivity
                                                            .data?.paymentActivityContent?[index] ??
                                                        PaymentActivityContent(),
                                                    onAcceptButton: (RequestMoneyActivityList data) {
                                                      debugPrint('RequestMoneyActivityList');
                                                      //TODO ACCEPT/REJECT POP UP
                                                      RTPConfirmationDialog.show(
                                                        context,
                                                        amount: "",
                                                        isAmountVisible: false,
                                                        cdtrAcct: data.cdtrAcct,
                                                        cdtrDpText:
                                                            StringUtils.getFirstInitials(data.cdtrName),
                                                        cdtrName: data.cdtrName,
                                                        description: RichText(
                                                            maxLines: 3,
                                                            text: TextSpan(
                                                                text: data.cdtrName,
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 14.0.t,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColor.veryDarkGray1),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        S.current.isRequesting.toLowerCase(),

                                                                    // "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: " " +
                                                                            data.amount.toString() +
                                                                            " " +
                                                                            S.of(context).JOD,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 14.0.t,
                                                                            fontWeight: FontWeight.w700,
                                                                            color: AppColor.veryDarkGray1),
                                                                        children: [
                                                                          TextSpan(
                                                                            text: S.current
                                                                                .fromYouWouldYouLikeToAcceptIt,
                                                                            style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 14.0.t,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w400,
                                                                              // color: AppColor.sky_blue_mid,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ])),
                                                        showDescription: true,
                                                        actionWidget: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);

                                                                ///TODO AcceptRequestMoneyOtp screen Navigation
                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.AcceptRequestMoneyOtp,
                                                                    arguments:
                                                                        AcceptRequestMoneyOtpPageArgument(
                                                                            amount: data.amount.toString(),
                                                                            iban: data.cdtrAcct,
                                                                            statusInfo: S.of(context).sentTo,
                                                                            name: data.cdtrName,
                                                                            dbtrAcct: data.dbtrAcct,
                                                                            currency: 'JOD',
                                                                            rtpStatus: 'True',
                                                                            CtgyPurp: data.ctgyPurp,
                                                                            payRefNo: data.payRefNo,
                                                                            dbtrPstlAdr: data.dbtrAddr,
                                                                            cdtrRecordID: data.cdtrRecordID,
                                                                            cdtrPstlAdr: data.cdtrAddr,
                                                                            OrgnlMsgId: data.msgID,
                                                                            rgltryRptg: data.rgltryRptg,
                                                                            dbtrRecordID: data.dbtrRecordID,
                                                                            cdtrAcct: data.cdtrAcct,
                                                                            dbtrAlias: data.dbtrAlias,
                                                                            cdtrBic: data.cdtrAgt,
                                                                            dbtrName: data.dbtrName,
                                                                            cdtrAlias: data.cdtrAlias,
                                                                            cdtrName: data.cdtrName,
                                                                            custID: '',
                                                                            rejectADdInfo: '',
                                                                            rejectReason: ''));
                                                              },
                                                              child: Container(
                                                                width: double.infinity,
                                                                height: 48.h,
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.sky_blue_mid,
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    vertical: 16.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).accept,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: AppColor.white,
                                                                      fontSize: 12.0.t,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 8.h),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.RejectRequestPayment,
                                                                    arguments:
                                                                        RejectRequestPaymentPageArgument(
                                                                            amount: data.amount.toString(),
                                                                            name: data.cdtrName,
                                                                            iban: data.cdtrAcct,
                                                                            statusInfo: S
                                                                                .of(context)
                                                                                .requestSuccessFullyRejected,
                                                                            custID: '',
                                                                            OrgnlMsgId: data.cdtrAgt,
                                                                            rtpStatus: 'True'));
                                                              },
                                                              child: Container(
                                                                width: double.infinity,
                                                                height: 48.h,
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.white,
                                                                  border: Border.all(
                                                                      color: AppColor.sky_blue_mid),
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    vertical: 16.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).reject,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: AppColor.sky_blue_mid,
                                                                      fontSize: 12.0.t,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        listOfDetails: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 16.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  S.current.date,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.t,
                                                                      color: AppColor.very_dark_gray1,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  TimeUtils.convertDateTimeToDate(
                                                                      data.rtpDate.toString()),
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.t,
                                                                    color: AppColor.black,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 16.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  S.current.time,
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.t,
                                                                      color: AppColor.very_dark_gray1,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                      data.rtpDate.toString()),
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.t,
                                                                    color: AppColor.black,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    onRejectButton: (RequestMoneyActivityList data) {
                                                      //* ACCEPT/REJECT POP UP
                                                      RTPConfirmationDialog.show(
                                                        context,
                                                        amount: "",
                                                        isAmountVisible: false,
                                                        cdtrAcct: data.cdtrAcct,
                                                        cdtrDpText:
                                                            StringUtils.getFirstInitials(data.cdtrName),
                                                        cdtrName: data.cdtrName,
                                                        description: RichText(
                                                            maxLines: 3,
                                                            text: TextSpan(
                                                                text: data.cdtrName,
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 14.0.t,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AppColor.veryDarkGray1),
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        S.current.isRequesting.toLowerCase(),

                                                                    // "${(content.data?[index].amount ?? 0.0).toString()} ${S.of(context).JOD}",
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: " " +
                                                                            data.amount.toString() +
                                                                            " " +
                                                                            S.of(context).JOD,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 14.0.t,
                                                                            fontWeight: FontWeight.w700,
                                                                            color: AppColor.veryDarkGray1),
                                                                        children: [
                                                                          TextSpan(
                                                                            text: S.current
                                                                                .fromYouWouldYouLikeToAcceptIt,
                                                                            style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 14.0.t,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w400,
                                                                              // color: AppColor.sky_blue_mid,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ])),
                                                        showDescription: true,
                                                        actionWidget: Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.AcceptRequestMoneyOtp,
                                                                    arguments:
                                                                        AcceptRequestMoneyOtpPageArgument(
                                                                            amount: data.amount.toString(),
                                                                            iban: data.cdtrAcct,
                                                                            statusInfo: S.of(context).sentTo,
                                                                            name: data.cdtrName,
                                                                            dbtrAcct: data.dbtrAcct,
                                                                            currency: 'JOD',
                                                                            rtpStatus: 'True',
                                                                            CtgyPurp: data.ctgyPurp,
                                                                            payRefNo: data.payRefNo,
                                                                            dbtrPstlAdr: data.dbtrAddr,
                                                                            cdtrRecordID: data.cdtrRecordID,
                                                                            cdtrPstlAdr: data.cdtrAddr,
                                                                            OrgnlMsgId: data.msgID,
                                                                            rgltryRptg: data.rgltryRptg,
                                                                            dbtrRecordID: data.dbtrRecordID,
                                                                            cdtrAcct: data.cdtrAcct,
                                                                            dbtrAlias: data.dbtrAlias,
                                                                            cdtrBic: data.cdtrAgt,
                                                                            dbtrName: data.dbtrName,
                                                                            cdtrAlias: data.cdtrAlias,
                                                                            cdtrName: data.cdtrName,
                                                                            custID: '',
                                                                            rejectADdInfo: '',
                                                                            rejectReason: ''));
                                                              },
                                                              child: Container(
                                                                width: double.infinity,
                                                                height: 48.h,
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.sky_blue_mid,
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    vertical: 16.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).accept,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: AppColor.white,
                                                                      fontSize: 12.0.t,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(height: 8.h),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                                Navigator.pushNamed(
                                                                    context, RoutePaths.RejectRequestPayment,
                                                                    arguments:
                                                                        RejectRequestPaymentPageArgument(
                                                                            amount: data.amount.toString(),
                                                                            name: data.cdtrName,
                                                                            iban: data.cdtrAcct,
                                                                            statusInfo: S
                                                                                .of(context)
                                                                                .requestSuccessFullyRejected,
                                                                            custID: '',
                                                                            OrgnlMsgId: data.cdtrAgt,
                                                                            rtpStatus: 'True'));
                                                              },
                                                              child: Container(
                                                                width: double.infinity,
                                                                height: 48.h,
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.white,
                                                                  border: Border.all(
                                                                      color: AppColor.sky_blue_mid),
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    vertical: 16.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).reject,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      color: AppColor.sky_blue_mid,
                                                                      fontSize: 12.0.t,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        listOfDetails: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 16.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  S.current.date,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.t,
                                                                      color: AppColor.very_dark_gray1,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  TimeUtils.convertDateTimeToDate(
                                                                      data.rtpDate.toString()),
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.t,
                                                                    color: AppColor.black,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 16.h,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Text(
                                                                  S.current.time,
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontSize: 12.t,
                                                                      color: AppColor.very_dark_gray1,
                                                                      fontWeight: FontWeight.w400),
                                                                ),
                                                                Text(
                                                                  TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                      data.rtpDate.toString()),
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontSize: 12.t,
                                                                    color: AppColor.black,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      );

                                                      ///TODO Reject Request
                                                      // model.requestToPayResult(
                                                      //   CustID: "",
                                                      //   RTPStatus: "",
                                                      //   OrgnlMsgId: (data.msgID),
                                                      //   RejectADdInfo: "",
                                                      //   RejectReason: "",
                                                      //   GetToken: true,
                                                      // );
                                                    },
                                                  )
                                                : Center(
                                                    child: Text(
                                                      S.of(context).noRTPActivityToDisplay,
                                                    ),
                                                  );
                                          },
                                          shrinkWrap: true,
                                          itemCount: requestActivity.data!.paymentActivityContent!.length,
                                        );

                                      case Status.ERROR:
                                        if (requestActivity.appError!.type ==
                                            ErrorType.ERROR_WHILE_REQUESTING_MONEY_ACTIVITY) {
                                          return Center(
                                            child: Text(
                                              S.of(context).noRTPActivityToDisplay,
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      default:
                                        return Container();
                                    }
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
