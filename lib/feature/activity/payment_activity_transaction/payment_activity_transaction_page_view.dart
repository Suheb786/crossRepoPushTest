import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog.dart';
import 'package:neo_bank/ui/molecules/payment/payment_activity_transacton_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

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
                        fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 14.0.t),
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
                                  borderRadius: BorderRadius.circular(4), color: AppColor.whiteGray),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 24.0.h, start: 24.0.w, end: 38.0.w),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding:
                                                EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 16.0.w),
                                            child: Row(
                                              children: [
                                                Text(
                                                  transactionType!,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 12.0.t,
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
                                              PaymentActivityFilterDialog.show(context,
                                                  type: FilterType.period, onSelected: (value) {
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
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 28.0.h, start: 24.0.w, end: 24.0.w),
                              child: AppStreamBuilder<Resource<bool>>(
                                  stream: model.requestToPayResultStream,
                                  initialData: Resource.none(),
                                  onData: (data) async {
                                    if (data.status == Status.SUCCESS) {
                                      ///LOG EVENT TO FIREBASE
                                      await FireBaseLogUtil.fireBaseLog(
                                          "rtp_rejected", {"is_rtp_rejected": true});
                                      model.getRequestMoneyActivity(
                                          true, model.filterDays, model.transactionType);
                                    }
                                  },
                                  dataBuilder: (context, snapshot) {
                                    return AppStreamBuilder<Resource<bool>>(
                                        stream: model.approveRTPRequestStream,
                                        initialData: Resource.none(),
                                        onData: (data) async {
                                          if (data.status == Status.SUCCESS) {
                                            ///LOG EVENT TO FIREBASE
                                            await FireBaseLogUtil.fireBaseLog(
                                                "rtp_accepted", {"is_rtp_accepted": true});
                                            model.getRequestMoneyActivity(
                                                true, model.filterDays, model.transactionType);
                                          }
                                        },
                                        dataBuilder: (context, snapshot) {
                                          return AppStreamBuilder<Resource<PaymentActivityResponse>>(
                                              stream: model.requestMoneyActivity,
                                              initialData: Resource.none(),
                                              dataBuilder: (context, requestActivity) {
                                                switch (requestActivity!.status) {
                                                  case Status.SUCCESS:
                                                    return ListView.builder(
                                                      itemBuilder: (context, index) {
                                                        return (requestActivity
                                                                            .data?.paymentActivityContent ??
                                                                        [])
                                                                    .length >
                                                                0
                                                            ? PaymentActivityTransactionWidget(
                                                                content: requestActivity.data
                                                                        ?.paymentActivityContent?[index] ??
                                                                    PaymentActivityContent(),
                                                                onAcceptButton:
                                                                    (RequestMoneyActivityList data) {
                                                                  model.approveRTPRequest(
                                                                      custID: "",
                                                                      dbtrAcct: "",
                                                                      dbtrName: "",
                                                                      dbtrPstlAdr: "",
                                                                      dbtrRecordID: "",
                                                                      currency: "",
                                                                      amount: "",
                                                                      dbtrAlias: "",
                                                                      cdtrBic: (data.cdtrAgt),
                                                                      cdtrName: "",
                                                                      cdtrAcct: "",
                                                                      cdtrPstlAdr: (data.cdtrAddr),
                                                                      cdtrRecordID: "",
                                                                      cdtrAlias: "",
                                                                      rgltryRptg: "",
                                                                      payRefNo: "",
                                                                      rejectReason: "",
                                                                      rtpStatus: "",
                                                                      rejectADdInfo: "",
                                                                      getToken: true);
                                                                },
                                                                onRejectButton:
                                                                    (RequestMoneyActivityList data) {
                                                                  model.requestToPayResult(
                                                                      CustID: "",
                                                                      RTPStatus: "",
                                                                      OrgnlMsgId: (data.msgID),
                                                                      RejectADdInfo: "",
                                                                      RejectReason: "");
                                                                },
                                                              )
                                                            : Center(
                                                                child: Text(
                                                                  S.of(context).noRTPActivityToDisplay,
                                                                ),
                                                              );
                                                      },
                                                      shrinkWrap: true,
                                                      itemCount: requestActivity
                                                          .data!.paymentActivityContent!.length,
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
                                        });
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
