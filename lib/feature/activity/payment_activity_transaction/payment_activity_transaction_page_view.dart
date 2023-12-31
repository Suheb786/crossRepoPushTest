import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/cliq/approve_rtp_otp/approve_rtp_otp.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/payment_activity_transacton_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/no_data_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035, vertical: 22.h),
        padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.16) - 12.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 48.0.w),
              child: Center(
                child: Text(
                  model.paymentActivityTransactionPageArgument.title,
                  style: TextStyle(
                      color: model.paymentActivityTransactionPageArgument.titleColor,
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.0.t),
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16))),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: (MediaQuery.of(context).size.height * 0.007)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 38.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppStreamBuilder<String>(
                                stream: model.transactionTypeResponseStream,
                                initialData: S.of(context).allTransaction,
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
                                              color: Theme.of(context).colorScheme.surfaceTint,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                            AppStreamBuilder<String>(
                                stream: model.paymentPeriodResponseStream,
                                initialData: S.of(context).last30Day,
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
                                        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
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
                                              child: AppSvg.asset(
                                                AssetUtils.dropDown,
                                                color: Theme.of(context).colorScheme.surfaceTint,
                                              ),
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
                          padding: EdgeInsetsDirectional.only(top: 10.0.h, start: 24.0.w, end: 24.0.w),
                          child: AppStreamBuilder<Resource<ApproveRTPOtp>>(
                              stream: model.approveRTPOtpStream,
                              initialData: Resource.none(),
                              onData: (data) async {
                                if (data.status == Status.SUCCESS) {
                                  Navigator.pushNamed(context, RoutePaths.AcceptRequestMoneyOtp,
                                      arguments: AcceptRequestMoneyOtpPageArgument(
                                          approveRtpData: model.approveRtpData,
                                          mobileCode: data.data?.mobileCode ?? '',
                                          mobileNumber: data.data?.mobileNumber ?? ''));
                                } else if (data.status == Status.ERROR) {}
                              },
                              dataBuilder: (context, approveRTPOtpResponse) {
                                return AppStreamBuilder<Resource<PaymentActivityResponse>>(
                                    stream: model.requestMoneyActivity,
                                    initialData: Resource.none(),
                                    onData: (data) async {
                                      if (data.status == Status.SUCCESS) {
                                        ///LOG EVENT TO FIREBASE
                                        await FireBaseLogUtil.fireBaseLog("transaction_history_success",
                                            {"is_transaction_history_success": true});
                                      } else if (data.status == Status.ERROR) {
                                        ///LOG EVENT TO FIREBASE
                                        await FireBaseLogUtil.fireBaseLog("transaction_history_failed",
                                            {"is_transaction_history_failed": true});
                                      }
                                    },
                                    dataBuilder: (context, requestActivity) {
                                      switch (requestActivity!.status) {
                                        case Status.SUCCESS:
                                          return (requestActivity.data?.paymentActivityContent ?? []).length >
                                                  0
                                              ? ListView.builder(
                                                  itemBuilder: (context, index) {
                                                    return PaymentActivityTransactionWidget(
                                                      content: requestActivity
                                                              .data?.paymentActivityContent?[index] ??
                                                          PaymentActivityContent(),
                                                      onTapOutWardSendMoney: (RequestMoneyActivityList) {
                                                        RTPConfirmationDialog.show(
                                                          context,
                                                          amount: "- " +
                                                              '${(RequestMoneyActivityList.amount?.toStringAsFixed(3)).toString()}',
                                                          currency: RequestMoneyActivityList.curr ?? '',
                                                          isAmountVisible: true,
                                                          cdtrAcct: RequestMoneyActivityList.cdtrAcct ?? '',
                                                          cdtrDpText: StringUtils.getFirstInitials(
                                                              RequestMoneyActivityList.cdtrName),
                                                          cdtrName: RequestMoneyActivityList.cdtrName ?? '',
                                                          description: Container(),
                                                          showDescription: false,
                                                          onDismiss: () {
                                                            Navigator.pop(context);
                                                          },
                                                          actionWidget: GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.CreditConfirmation,
                                                                  arguments: CreditConfirmationArgument(
                                                                      crediterDP: StringUtils.getFirstInitials(
                                                                          RequestMoneyActivityList.cdtrName),
                                                                      transactionType:
                                                                          RequestMoneyActivityList.paymentType
                                                                              .toString(),
                                                                      date: TimeUtils.convertDateTimeToDate(
                                                                          RequestMoneyActivityList.paymentDate
                                                                              .toString()),
                                                                      time:
                                                                          TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                              RequestMoneyActivityList
                                                                                  .paymentDate
                                                                                  .toString()),
                                                                      refID: RequestMoneyActivityList.payRefNo,
                                                                      accountNo: RequestMoneyActivityList.cdtrAcct,
                                                                      amount: "- ${RequestMoneyActivityList.amount}",
                                                                      crediterName: RequestMoneyActivityList.cdtrName,
                                                                      msgID: RequestMoneyActivityList.msgID,
                                                                      currency: RequestMoneyActivityList.curr));
                                                            },
                                                            child: Container(
                                                              width: double.infinity,
                                                              decoration: BoxDecoration(
                                                                color: AppColor.white,
                                                                border:
                                                                    Border.all(color: AppColor.white_gray),
                                                                borderRadius: BorderRadius.circular(100),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                  horizontal: 24.0.w,
                                                                  vertical: 16.h,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      S.of(context).creditConfirmation,
                                                                      textAlign: TextAlign.start,
                                                                      style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        color: AppColor.skyblue,
                                                                        fontSize: 12.0.t,
                                                                        fontWeight: FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    AppSvg.asset(
                                                                        AssetUtils.creditConfirmation,
                                                                        height: 16.h,
                                                                        width: 16.h)
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
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
                                                                    S.current.transactionType,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.very_dark_gray1,
                                                                        fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    RequestMoneyActivityList.paymentType
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.black,
                                                                        fontWeight: FontWeight.w700),
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
                                                                    S.current.date,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.very_dark_gray1,
                                                                        fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    TimeUtils.convertDateTimeToDate(
                                                                        RequestMoneyActivityList.paymentDate
                                                                            .toString()),
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.black,
                                                                        fontWeight: FontWeight.w700),
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
                                                                    S.of(context).time,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.very_dark_gray1,
                                                                        fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    TimeUtils.getFormattedTimeFor12HrsFormat(
                                                                        RequestMoneyActivityList.paymentDate
                                                                            .toString()),
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.black,
                                                                        fontWeight: FontWeight.w700),
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
                                                                    S.current.refID,
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.very_dark_gray1,
                                                                        fontWeight: FontWeight.w400),
                                                                  ),
                                                                  Text(
                                                                    RequestMoneyActivityList.payRefNo ?? '',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.t,
                                                                        color: AppColor.black,
                                                                        fontWeight: FontWeight.w700),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                        //  }
                                                      },
                                                      onTapInWardSendMoney: (RequestMoneyActivityList data) {
                                                        ///Normal Incoming (Show return payment option)
                                                        if (RequestMoneyActivityStatusEnum
                                                                    .CATEGORY_ACCEPTED ==
                                                                data.trxStatus &&
                                                            (data.allowReturn ?? false)) {
                                                          ///* RETURN PAYMENT POP UP
                                                          RTPConfirmationDialog.show(
                                                            context,
                                                            amount: " " +
                                                                '${(data.amount?.toStringAsFixed(3)).toString()}',
                                                            currency: data.curr ?? '',
                                                            isAmountVisible: true,
                                                            cdtrAcct: data.dbtrAcct ?? '',
                                                            cdtrDpText:
                                                                StringUtils.getFirstInitials(data.dbtrName),
                                                            cdtrName: data.dbtrName ?? '',
                                                            description: Container(),
                                                            listOfDetails: Column(
                                                              children: [
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
                                                                          data.paymentDate.toString()),
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.black,
                                                                          fontWeight: FontWeight.w700),
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
                                                                          color: AppColor.very_dark_gray1,
                                                                          fontSize: 12.t,
                                                                          fontWeight: FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      TimeUtils
                                                                          .getFormattedTimeFor12HrsFormat(
                                                                              data.paymentDate.toString()),
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          color: AppColor.black,
                                                                          fontSize: 12.t,
                                                                          fontWeight: FontWeight.w700),
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
                                                                      S.of(context).refID,
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          color: AppColor.very_dark_gray1,
                                                                          fontSize: 12.t,
                                                                          fontWeight: FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      data.payRefNo ?? '',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          color: AppColor.black,
                                                                          fontSize: 12.t,
                                                                          fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                            onDismiss: () {
                                                              Navigator.pop(context);
                                                            },
                                                            showDescription: false,
                                                            actionWidget: GestureDetector(
                                                              onTap: () {
                                                                if (ProviderScope.containerOf(context)
                                                                        .read(appHomeViewModelProvider)
                                                                        .dashboardDataContent
                                                                        .dashboardFeatures
                                                                        ?.returnPaymentFeatureEnabled ??
                                                                    false) {
                                                                  Navigator.pop(context);
                                                                  Navigator.pushNamed(context,
                                                                      RoutePaths.ReturnPaymentSliderPage,
                                                                      arguments:
                                                                          ReturnPaymentTransactionSliderPageArgument(
                                                                              name: data.dbtrName,
                                                                              iban: data.dbtrAcct,
                                                                              statusInfo: S.current.sentTo,
                                                                              custID: "",
                                                                              OrgnlMsgId: data.msgID,
                                                                              rtpStatus: "True",
                                                                              messageID: data.msgID,
                                                                              dbtrAcct: data.dbtrAcct,
                                                                              dbtrName: data.dbtrName,
                                                                              cdtrAcct: data.cdtrAcct,
                                                                              cdtrName: data.cdtrName,
                                                                              currency: data.curr,
                                                                              rtrnReason: "",
                                                                              rtrnAddInfo: "",
                                                                              isDispute: false,
                                                                              amount: data.amount,
                                                                              disputeRefNo: data.payRefNo,
                                                                              otpCode: "",
                                                                              getToken: true));
                                                                } else {
                                                                  model.showToastWithError(AppError(
                                                                      cause: Exception(),
                                                                      error: ErrorInfo(message: ''),
                                                                      type: ErrorType
                                                                          .CLIQ_RETURN_PAYMENT_OFFLINE));
                                                                }
                                                              },
                                                              child: Container(
                                                                width: double.infinity,
                                                                decoration: BoxDecoration(
                                                                  color: AppColor.sky_blue_mid,
                                                                  borderRadius: BorderRadius.circular(100),
                                                                ),
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                    horizontal: 16.0.w,
                                                                    vertical: 16.h,
                                                                  ),
                                                                  child: Text(
                                                                    S.of(context).returnPayment,
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
                                                          );
                                                        } else {
                                                          RTPConfirmationDialog.show(
                                                            context,
                                                            currency: data.curr ?? '',
                                                            amount: " " +
                                                                '${(data.amount?.toStringAsFixed(3)).toString()}',
                                                            isAmountVisible: false,
                                                            cdtrAcct: data.dbtrAcct ?? '',
                                                            cdtrDpText:
                                                                StringUtils.getFirstInitials(data.dbtrName),
                                                            cdtrName: data.dbtrName ?? '',
                                                            showDescription: true,
                                                            actionWidget: Container(),
                                                            onDismiss: () {
                                                              Navigator.pop(context);
                                                            },
                                                            description: RichText(
                                                                text: TextSpan(
                                                                    text: data.dbtrName ?? '',
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        color: AppColor.veryDarkGray1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w700),
                                                                    children: [
                                                                  TextSpan(
                                                                    text: " " +
                                                                        S.of(context).returned.toLowerCase(),
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.0.t,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        ' ${(data.amount?.toStringAsFixed(3)).toString()} ${data.curr} ',
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: AppColor.veryDarkGray1),
                                                                  ),
                                                                  TextSpan(
                                                                    text: S.of(context).toYou + '.',
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 12.0.t,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: Theme.of(context)
                                                                            .primaryColorDark),
                                                                  ),
                                                                ])),
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
                                                                      S.current.status,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.very_dark_gray1,
                                                                          fontWeight: FontWeight.w400),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: model.getColor(data.trxStatus),
                                                                      ),
                                                                      padding: EdgeInsets.only(
                                                                          left: 8.w,
                                                                          right: 8.w,
                                                                          top: 4.h,
                                                                          bottom: 1.h),
                                                                      child: Text(
                                                                        data.trxStatus
                                                                                ?.getPaymentTransactionStatus(
                                                                                    context: context) ??
                                                                            '',
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 12.t,
                                                                            color: AppColor.white,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 16.h,
                                                                ),
                                                                // Row(
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment.spaceBetween,
                                                                //   children: [
                                                                //     Text(
                                                                //       S.current.reason,
                                                                //       style: TextStyle(
                                                                //           fontFamily: StringUtils.appFont,
                                                                //           fontSize: 12.t,
                                                                //           color: AppColor.very_dark_gray1,
                                                                //           fontWeight: FontWeight.w400),
                                                                //     ),
                                                                //     Spacer(),
                                                                //     Expanded(
                                                                //       child: Align(
                                                                //         alignment: Alignment.centerRight,
                                                                //         child: Text(
                                                                //           data.trxReason ?? '',
                                                                //           textAlign: TextAlign.end,
                                                                //           style: TextStyle(
                                                                //               fontFamily:
                                                                //                   StringUtils.appFont,
                                                                //               fontSize: 12.t,
                                                                //               color: AppColor.black,
                                                                //               fontWeight:
                                                                //                   FontWeight.w700),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   ],
                                                                // ),
                                                                // SizedBox(
                                                                //   height: 16.h,
                                                                // ),
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
                                                                          data.paymentDate.toString()),
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.black,
                                                                          fontWeight: FontWeight.w700),
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
                                                                      TimeUtils
                                                                          .getFormattedTimeFor12HrsFormat(
                                                                              data.paymentDate.toString()),
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.black,
                                                                          fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }
                                                      },
                                                      onAcceptButton: (RequestMoneyActivityList data) {
                                                        RTPConfirmationDialog.show(
                                                          context,
                                                          amount: "",
                                                          isAmountVisible: false,
                                                          currency: data.curr ?? '',
                                                          cdtrAcct: data.cdtrAcct ?? '',
                                                          cdtrDpText:
                                                              StringUtils.getFirstInitials(data.cdtrName),
                                                          cdtrName: data.cdtrName ?? '',
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
                                                                      text: S.current.isRequesting
                                                                          .toLowerCase(),

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
                                                                              '${(data.amount?.toStringAsFixed(3)).toString()}' +
                                                                              " " +
                                                                              data.curr.toString(),
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
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.0.t,
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
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

                                                                  model.approveRtpData = ApproveRtpData(
                                                                      amount: data.amount.toString(),
                                                                      iban: data.cdtrAcct ?? '',
                                                                      statusInfo: S.of(context).sentTo,
                                                                      name: data.cdtrName ?? '',
                                                                      dbtrAcct: data.dbtrAcct ?? '',
                                                                      currency: data.curr ?? '',
                                                                      rtpStatus: 'True',
                                                                      ctgyPurp: data.ctgyPurp ?? '',
                                                                      payRefNo: data.payRefNo ?? '',
                                                                      dbtrPstlAdr: data.dbtrAddr ?? '',
                                                                      cdtrRecordID: data.cdtrRecordID ?? '',
                                                                      cdtrPstlAdr: data.cdtrAddr ?? '',
                                                                      orgnlMsgId: data.msgID ?? '',
                                                                      rgltryRptg: data.rgltryRptg ?? '',
                                                                      dbtrRecordID: data.dbtrRecordID ?? '',
                                                                      cdtrAcct: data.cdtrAcct ?? '',
                                                                      dbtrAlias: data.dbtrAlias ?? '',
                                                                      cdtrBic: data.cdtrAgt ?? '',
                                                                      dbtrName: data.dbtrName ?? '',
                                                                      cdtrAlias: data.cdtrAlias ?? '',
                                                                      cdtrName: data.cdtrName ?? '',
                                                                      custID: '',
                                                                      rejectADdInfo: '',
                                                                      rejectReason: '');

                                                                  model.makeApproveRTPOtpRequest();
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
                                                                  Navigator.pushNamed(context,
                                                                      RoutePaths.RejectRequestPayment,
                                                                      arguments:
                                                                          RejectRequestPaymentPageArgument(
                                                                              amount: data.amount.toString(),
                                                                              name: data.cdtrName ?? '',
                                                                              iban: data.cdtrAcct ?? '',
                                                                              statusInfo: S
                                                                                  .of(context)
                                                                                  .requestSuccessFullyRejected,
                                                                              custID: '',
                                                                              OrgnlMsgId: data.msgID ?? '',
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
                                                          onDismiss: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                      },
                                                      onRejectButton: (RequestMoneyActivityList data) {
                                                        //* ACCEPT/REJECT POP UP
                                                        RTPConfirmationDialog.show(
                                                          context,
                                                          amount: "",
                                                          currency: data.curr ?? '',
                                                          isAmountVisible: false,
                                                          cdtrAcct: data.cdtrAcct ?? '',
                                                          cdtrDpText:
                                                              StringUtils.getFirstInitials(data.cdtrName),
                                                          cdtrName: data.cdtrName ?? '',
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
                                                                      text: S.current.isRequesting
                                                                          .toLowerCase(),

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
                                                                              '${(data.amount?.toStringAsFixed(3)).toString()}' +
                                                                              " " +
                                                                              data.curr.toString(),
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
                                                                                fontFamily:
                                                                                    StringUtils.appFont,
                                                                                fontSize: 14.0.t,
                                                                                overflow:
                                                                                    TextOverflow.ellipsis,
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
                                                                  model.approveRtpData = ApproveRtpData(
                                                                      amount: data.amount.toString(),
                                                                      iban: data.cdtrAcct ?? '',
                                                                      statusInfo: S.of(context).sentTo,
                                                                      name: data.cdtrName ?? '',
                                                                      dbtrAcct: data.dbtrAcct ?? '',
                                                                      currency: data.curr ?? '',
                                                                      rtpStatus: 'True',
                                                                      ctgyPurp: data.ctgyPurp ?? '',
                                                                      payRefNo: data.payRefNo ?? '',
                                                                      dbtrPstlAdr: data.dbtrAddr ?? '',
                                                                      cdtrRecordID: data.cdtrRecordID ?? '',
                                                                      cdtrPstlAdr: data.cdtrAddr ?? '',
                                                                      orgnlMsgId: data.msgID ?? '',
                                                                      rgltryRptg: data.rgltryRptg ?? '',
                                                                      dbtrRecordID: data.dbtrRecordID ?? '',
                                                                      cdtrAcct: data.cdtrAcct ?? '',
                                                                      dbtrAlias: data.dbtrAlias ?? '',
                                                                      cdtrBic: data.cdtrAgt ?? '',
                                                                      dbtrName: data.dbtrName ?? '',
                                                                      cdtrAlias: data.cdtrAlias ?? '',
                                                                      cdtrName: data.cdtrName ?? '',
                                                                      custID: '',
                                                                      rejectADdInfo: '',
                                                                      rejectReason: '');
                                                                  model.makeApproveRTPOtpRequest();
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
                                                                  Navigator.pushNamed(context,
                                                                      RoutePaths.RejectRequestPayment,
                                                                      arguments:
                                                                          RejectRequestPaymentPageArgument(
                                                                              amount: data.amount.toString(),
                                                                              name: data.cdtrName ?? '',
                                                                              iban: data.cdtrAcct ?? '',
                                                                              statusInfo: S
                                                                                  .of(context)
                                                                                  .requestSuccessFullyRejected,
                                                                              custID: '',
                                                                              OrgnlMsgId: data.msgID ?? '',
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
                                                          onDismiss: () {
                                                            Navigator.pop(context);
                                                          },
                                                        );
                                                      },
                                                      onTapRTPStatus: (RequestMoneyActivityList data) {
                                                        if (RequestMoneyActivityStatusEnum
                                                                    .CATEGORY_REJECTED ==
                                                                data.trxStatus ||
                                                            RequestMoneyActivityStatusEnum
                                                                    .CATEGORY_ACCEPTED ==
                                                                data.trxStatus) {
                                                          /// STATUS POP UP
                                                          RTPConfirmationDialog.show(
                                                            context,
                                                            currency: data.curr ?? '',
                                                            amount: " " +
                                                                '${(data.amount?.toStringAsFixed(3)).toString()}',
                                                            isAmountVisible: false,
                                                            cdtrAcct: data.dbtrAcct ?? '',
                                                            cdtrDpText:
                                                                StringUtils.getFirstInitials(data.dbtrName),
                                                            cdtrName: data.dbtrName ?? '',
                                                            showDescription: true,
                                                            actionWidget: Container(),
                                                            description: RichText(
                                                                text: TextSpan(
                                                                    text: S.current.yourequested,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        fontWeight: FontWeight.w400,
                                                                        color: AppColor.veryDarkGray1),
                                                                    children: [
                                                                  TextSpan(
                                                                    text:
                                                                        ' ${(data.amount?.toStringAsFixed(3)).toString()} ',
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontSize: 14.0.t,
                                                                        fontWeight: FontWeight.w700,
                                                                        color: AppColor.veryDarkGray1),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: S.current.fromSingleLine,
                                                                        style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 14.0.t,
                                                                          overflow: TextOverflow.ellipsis,
                                                                          fontWeight: FontWeight.w400,
                                                                          // color: AppColor.sky_blue_mid,
                                                                        ),
                                                                        children: [
                                                                          TextSpan(
                                                                            text: " ${data.dbtrName ?? ''}",
                                                                            style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 14.0.t,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              fontWeight: FontWeight.w700,
                                                                              // color: AppColor.sky_blue_mid,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ])),
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
                                                                      S.current.status,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.very_dark_gray1,
                                                                          fontWeight: FontWeight.w400),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                        color: model.getColor(data.trxStatus),
                                                                      ),
                                                                      padding: EdgeInsets.only(
                                                                          left: 8.w,
                                                                          right: 8.w,
                                                                          top: 4.h,
                                                                          bottom: 1.h),
                                                                      child: Text(
                                                                        data.trxStatus
                                                                                ?.getPaymentTransactionStatus(
                                                                                    context: context) ??
                                                                            '',
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontSize: 12.t,
                                                                            color: AppColor.white,
                                                                            fontWeight: FontWeight.w700),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 16.h,
                                                                ),
                                                                // Row(
                                                                //   mainAxisAlignment:
                                                                //       MainAxisAlignment.spaceBetween,
                                                                //   children: [
                                                                //     Text(
                                                                //       S.current.reason,
                                                                //       style: TextStyle(
                                                                //           fontFamily: StringUtils.appFont,
                                                                //           fontSize: 12.t,
                                                                //           color: AppColor.very_dark_gray1,
                                                                //           fontWeight: FontWeight.w400),
                                                                //     ),
                                                                //     Spacer(),
                                                                //     Expanded(
                                                                //       child: Align(
                                                                //         alignment: Alignment.centerRight,
                                                                //         child: Text(
                                                                //           data.trxReason ?? '',
                                                                //           textAlign: TextAlign.end,
                                                                //           style: TextStyle(
                                                                //               fontFamily:
                                                                //                   StringUtils.appFont,
                                                                //               fontSize: 12.t,
                                                                //               color: AppColor.black,
                                                                //               fontWeight:
                                                                //                   FontWeight.w700),
                                                                //         ),
                                                                //       ),
                                                                //     ),
                                                                //   ],
                                                                // ),
                                                                // SizedBox(
                                                                //   height: 16.h,
                                                                // ),
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
                                                                          fontWeight: FontWeight.w700),
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
                                                                      TimeUtils
                                                                          .getFormattedTimeFor12HrsFormat(
                                                                              data.rtpDate.toString()),
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontSize: 12.t,
                                                                          color: AppColor.black,
                                                                          fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            onDismiss: () {
                                                              Navigator.pop(context);
                                                            },
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      requestActivity.data!.paymentActivityContent!.length,
                                                )
                                              : Center(
                                                  child: NoDataWidget(
                                                    errorMessage: S.of(context).noRTPActivityToDisplay,
                                                  ),
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
                                    });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
