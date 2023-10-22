import 'package:domain/constants/enum/payment_type_enum.dart';
import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/no_data_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../di/payment/payment_modules.dart';

class PaymentActivityPageView extends BasePageViewWidget<PaymentActivityViewModel> {
  PaymentActivityPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 2,
        color: Theme.of(context).canvasColor,
        margin: EdgeInsetsDirectional.zero,
        shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
        child: Container(
          padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 32.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).paymentActivity,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 12.0.t,
                    fontWeight: FontWeight.w600,
                    color: AppColor.gray_black),
              ),
              SizedBox(
                height: 24.0.h,
              ),
              Expanded(
                child: AppStreamBuilder<Resource<List<RequestMoneyActivityList>>>(
                    stream: ProviderScope.containerOf(context)
                        .read(paymentHomeViewModelProvider)
                        .paymentActivityListStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, activity) {
                      switch (activity!.status) {
                        case Status.SUCCESS:
                          return ((activity.data ?? []).length > 0)
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount:
                                      ((activity.data ?? []).length > 4) ? 5 : ((activity.data ?? []).length),
                                  shrinkWrap: true,
                                  itemBuilder: (mContext, index) {
                                    return Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          top: index == 0 ? 0 : 16.h, bottom: index == 4 ? 10.0.h : 0),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50.0.h,
                                            width: 50.0.w,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                shape: BoxShape.circle),
                                            child: Center(
                                              child: Text(
                                                getNameValue(activity.data?[index]).length > 1
                                                    ? StringUtils.getFirstInitials(
                                                        getNameValue(activity.data?[index]))
                                                    : "",
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    color: Theme.of(context).colorScheme.secondary,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14.0.t),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional.only(start: 8.0.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  (activity.data?[index].trxDir == RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
                                                          activity.data?[index].paymentType ==
                                                              PaymentTypeEnum.RTP_REQUEST)
                                                      ? Text.rich(TextSpan(
                                                          text: '${activity.data![index].cdtrName}',
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 12.0.t),
                                                          children: [
                                                              TextSpan(
                                                                  text: S.of(context).requested,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 12.0.t)),
                                                              TextSpan(
                                                                  text:
                                                                      '${activity.data?[index].amount?.toStringAsFixed(3)} ${activity.data?[index].curr} ',
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 12.0.t)),
                                                              TextSpan(
                                                                  text: S.of(context).fromYou,
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontWeight: FontWeight.w400,
                                                                      fontSize: 12.0.t)),
                                                            ]))
                                                      : (activity.data?[index].trxDir ==
                                                                  RequestMoneyActivityStatusEnum
                                                                      .TRANSACTION_DIRECTORY_OUTGOING &&
                                                              activity.data?[index].paymentType ==
                                                                  PaymentTypeEnum.RTP_REQUEST)
                                                          ? Text.rich(TextSpan(
                                                              text: S.of(context).youRequested,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 12.0.t),
                                                              children: [
                                                                  TextSpan(
                                                                      text:
                                                                          '${activity.data![index].amount?.toStringAsFixed(3)} ${activity.data![index].curr} ',
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12.0.t)),
                                                                  TextSpan(
                                                                      text: S.of(context).fromS,
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: 12.0.t)),
                                                                  TextSpan(
                                                                      text:
                                                                          '${activity.data![index].dbtrName}',
                                                                      style: TextStyle(
                                                                          fontFamily: StringUtils.appFont,
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12.0.t)),
                                                                ]))
                                                          : (activity.data?[index].trxDir ==
                                                                      RequestMoneyActivityStatusEnum
                                                                          .TRANSACTION_DIRECTORY_INCOMING &&
                                                                  activity.data?[index].paymentType ==
                                                                      PaymentTypeEnum.SEND_MONEY)
                                                              ? Text.rich(TextSpan(
                                                                  text: '${activity.data![index].dbtrName} ',
                                                                  style: TextStyle(
                                                                      fontFamily: StringUtils.appFont,
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 12.0.t),
                                                                  children: [
                                                                      TextSpan(
                                                                          text: ((activity.data?[index]
                                                                                      .allowReturn ??
                                                                                  false)
                                                                              ? S
                                                                                  .of(context)
                                                                                  .sent
                                                                                  .toLowerCase()
                                                                              : S.of(context).returned),
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12.0.t)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${activity.data![index].amount?.toStringAsFixed(3)} ${activity.data![index].curr} ',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.0.t)),
                                                                      TextSpan(
                                                                          text: S.of(context).toYou,
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12.0.t)),
                                                                    ]))
                                                              : (activity.data?[index].trxDir ==
                                                                          RequestMoneyActivityStatusEnum
                                                                              .TRANSACTION_DIRECTORY_OUTGOING &&
                                                                      activity.data?[index].paymentType ==
                                                                          PaymentTypeEnum.SEND_MONEY)
                                                                  ? Text.rich(TextSpan(text: S.of(context).youSent, style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 12.0.t), children: [
                                                                      TextSpan(
                                                                          text:
                                                                              '${activity.data![index].amount?.toStringAsFixed(3)} ${activity.data![index].curr} ',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.0.t)),
                                                                      TextSpan(
                                                                          text: S.of(context).to,
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 12.0.t)),
                                                                      TextSpan(
                                                                          text:
                                                                              ' ${activity.data![index].cdtrName}',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.0.t)),
                                                                    ]))
                                                                  : Container(),
                                                  Visibility(
                                                    visible: !(activity.data?[index].trxDir ==
                                                            RequestMoneyActivityStatusEnum
                                                                .TRANSACTION_DIRECTORY_INCOMING &&
                                                        activity.data?[index].paymentType ==
                                                            PaymentTypeEnum.SEND_MONEY),
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional.only(top: 6.0.h),
                                                      child: Container(
                                                        padding: EdgeInsetsDirectional.only(
                                                            start: 8.0.w,
                                                            end: 8.0.w,
                                                            top: 3.0.h,
                                                            bottom: 2.0.h),
                                                        decoration: BoxDecoration(
                                                          color: model
                                                              .getColor((activity.data![index].trxStatus)),
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        child: Text(
                                                          activity.data?[index].trxStatus
                                                                  ?.getPaymentTransactionStatus(
                                                                      context: context) ??
                                                              '',
                                                          style: TextStyle(
                                                            color: Theme.of(context).colorScheme.secondary,
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 12.0.t,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Center(
                                  child: NoDataWidget(
                                    errorMessage: S.of(context).noRTPActivityToDisplay,
                                  ),
                                );

                        default:
                          return Container();
                      }
                    }),
              ),
              SizedBox(
                height: 24.0.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getNameValue(RequestMoneyActivityList? data) {
    if (data?.trxDir == RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
        data?.paymentType == PaymentTypeEnum.SEND_MONEY) {
      return data?.dbtrName ?? '';
    } else if (data?.trxDir == RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_OUTGOING &&
        data?.paymentType == PaymentTypeEnum.SEND_MONEY) {
      return data?.cdtrName ?? '';
    } else if (data?.trxDir == RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING &&
        data?.paymentType == PaymentTypeEnum.RTP_REQUEST) {
      return data?.cdtrName ?? '';
    } else {
      return data?.dbtrName ?? '';
    }
  }
}
