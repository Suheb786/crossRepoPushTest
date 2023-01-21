import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_data.dart';
import 'package:domain/model/bill_payments/bill_payments_transaction/bill_payments_transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (item.nickname != null && item.nickname!.length > 0)
                              ? item.nickname ?? ""
                              : (item.billerName != null && item.billerName!.length > 0)
                                  ? item.billerName ?? ""
                                  : "",
                          maxLines: 10,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.0.t,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h),
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
                  // SizedBox(
                  //   width: 8,
                  // ),
                  Spacer(),
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
                                color: AppColor.dark_brown,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.t),
                          ),
                          Text(
                            " ${S.of(context).JOD}",
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.t,
                                color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.brightBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0.t),
                      )
                    ],
                  )
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
}
