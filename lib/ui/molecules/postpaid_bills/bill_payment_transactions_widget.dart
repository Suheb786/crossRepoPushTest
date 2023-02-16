import 'package:domain/constants/enum/transaction_status_bills_enum.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_data.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/get_bill_payments_categories.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class BillPaymentsTransactionWidget extends StatelessWidget {
  final BillPaymentsTransactionData? billPaymentsTransactionData;

  const BillPaymentsTransactionWidget({Key? key, this.billPaymentsTransactionData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          billPaymentsTransactionData?.label != null && billPaymentsTransactionData!.label!.isNotEmpty
              ? TimeUtils.getFormattedDateForAccountTransaction(billPaymentsTransactionData!.label!)
              : '-',
          //billPaymentsTransactionData!.label!,
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: 15.0.t,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        Card(
          margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
          color: Theme.of(context).accentColor,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var item = billPaymentsTransactionData?.billPaymentsTransactionDataList?[index] ??
                  BillPaymentsTransactionList();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(start: 52.0, bottom: 10.0),
                    height: 25.0.h,
                    width: 80.0.w,
                    decoration: BoxDecoration(
                      color: getStatus(item.status ?? TransactionStatusBillsEnum.PENDING) == "success"
                          ? AppColor.darkModerateLimeGreen
                          : AppColor.dark_brown,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text(
                          getStatusTitle(context, item.status ?? TransactionStatusBillsEnum.PENDING),
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.white,
                              fontSize: 14.t,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: EdgeInsets.only(bottom: 10.0),
                        width: 40.w,
                        height: 40.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: AppColor.gray_2),
                            borderRadius: BorderRadius.circular(100)),
                        child: Image.asset(
                          GetBillPaymentsCategories.path(item.iconCode),
                          matchTextDirection: false,
                          width: 25.w,
                          height: 25.h,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 4.0.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${getNickNameOrBillerName(item, context)}",
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.0.t,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "- ${double.parse(item.amount ?? "0").toStringAsFixed(3)}",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                color: getStatus(item.status ??
                                                            TransactionStatusBillsEnum.PENDING) ==
                                                        "success"
                                                    ? AppColor.dark_brown
                                                    : AppColor.gray5,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.0.t),
                                          ),
                                          Text(
                                            " ${S.of(context).JOD}",
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.0.t,
                                                color:
                                                    Theme.of(context).inputDecorationTheme.hintStyle!.color),
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 4.0.h,
                                      // ),
                                      // Text(
                                      //   "",
                                      //   style: TextStyle(
                                      //       fontFamily: StringUtils.appFont,
                                      //       color: AppColor.brightBlue,
                                      //       fontWeight: FontWeight.w600,
                                      //       fontSize: 12.0.t),
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            item.refNo != null && item.refNo!.isNotEmpty
                                ? Padding(
                                    padding: EdgeInsetsDirectional.only(start: 4.0.w),
                                    child: Text(
                                      item.refNo ?? "",
                                      style: TextStyle(
                                        color: AppColor.veryDarkGray2,
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.0.t,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  )
                                : Container(),
                            // item.billingNumber != null && item.billingNumber!.isNotEmpty
                            //     ? Padding(
                            //         padding: EdgeInsetsDirectional.only(top: 4.0.h, start: 4.0.w),
                            //         child: Text(
                            //           item.billingNumber ?? "",
                            //           maxLines: 10,
                            //           style: TextStyle(
                            //             color: AppColor.veryDarkGray2,
                            //             fontFamily: StringUtils.appFont,
                            //             fontSize: 12.0.t,
                            //             fontWeight: FontWeight.w400,
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                            Padding(
                              padding: EdgeInsetsDirectional.only(top: 4.0.h, start: 4.0.w),
                              child: Text(
                                item.paymentDate != null && item.paymentDate!.isNotEmpty
                                    ? TimeUtils.getFormattedTimeForTransaction(item.paymentDate!.toString())
                                    : "",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                    fontSize: 12.0.t,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
            shrinkWrap: true,
            itemCount: billPaymentsTransactionData?.billPaymentsTransactionDataList?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                child: Container(
                  height: 1,
                  color: AppColor.light_grayish_violet,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String getNickNameOrBillerName(BillPaymentsTransactionList item, BuildContext context) {
    if ((item.nickname != null && item.nickname!.length > 0)) {
      return item.nickname ?? "";
    } else {
      if (StringUtils.isDirectionRTL(context)) {
        if ((item.billerNameAr != null && item.billerNameAr!.length > 0)) {
          return item.billerNameAr ?? "";
        }
      } else {
        if ((item.billerName != null && item.billerName!.length > 0)) {
          return item.billerName ?? "";
        }
      }
    }
    return "";
  }

  getStatus(TransactionStatusBillsEnum status) {
    switch (status) {
      case TransactionStatusBillsEnum.SUCCESS:
        return "success";
      case TransactionStatusBillsEnum.FAIL:
        return "fail";

      default:
        return "pending";
    }
  }

  getStatusTitle(BuildContext context, TransactionStatusBillsEnum status) {
    switch (status) {
      case TransactionStatusBillsEnum.SUCCESS:
        return S.of(context).successS;
      case TransactionStatusBillsEnum.FAIL:
        return S.of(context).failed;

      default:
        return S.of(context).processing;
    }
  }
}
