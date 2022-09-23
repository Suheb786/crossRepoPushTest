import 'package:domain/constants/enum/transaction_status_enum.dart';
import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class PaymentActivityTransactionWidget extends StatelessWidget {
  final PaymentActivityContent? transactions;

  const PaymentActivityTransactionWidget({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // TimeUtils.getFormattedDateForTransaction(transactions!.label!),
          transactions!.rtpDate!.day.toString() + " " + DateFormat.MMMM().format(transactions!.rtpDate!),
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
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 17.0.h),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: 50.0.h,
                      width: 50.0.w,
                      decoration:
                          BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Text(
                          transactions!.data![index].name!.split(" ").length > 1
                              ? StringUtils.getFirstInitials(transactions!.data![index].name!)
                              : "",
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0.t),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 14.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "You requested ${transactions!.data![index].amount}",
                          //   style: TextStyle(fontFamily: StringUtils.appFont,
                          //       fontWeight: FontWeight.w800, fontSize: 12.0.t),
                          // ),
                          // Text(
                          //   "from ${transactions!.data![index].name}",
                          //   style: TextStyle(fontFamily: StringUtils.appFont,
                          //       fontWeight: FontWeight.w800, fontSize: 12.0.t),
                          // ),
                          RichText(
                              maxLines: 3,
                              text: TextSpan(
                                  text: S.of(context).youRequested,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 12.0.t,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).primaryColorDark),
                                  children: [
                                    TextSpan(
                                        text: " ${transactions!.data![index].amount} ${S.of(context).JOD}",
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 12.0.t,
                                            fontWeight: FontWeight.w600,
                                            color: Theme.of(context).primaryColorDark),
                                        children: [
                                          TextSpan(
                                              text: S.of(context).from,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 12.0.t,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).primaryColorDark),
                                              children: [
                                                TextSpan(
                                                  text: " ${transactions!.data![index].name}",
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontSize: 12.0.t,
                                                      overflow: TextOverflow.ellipsis,
                                                      fontWeight: FontWeight.w600,
                                                      color: Theme.of(context).primaryColorDark),
                                                )
                                              ])
                                        ])
                                  ])),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0.h),
                            child: Row(
                              children: [
                                Text(
                                  TimeUtils.getFormattedTimeForTransaction(
                                      transactions!.data![index].rtpDate.toString()),
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.gray1,
                                      fontSize: 12.0.t,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(start: 9.0.w),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 2.0.h),
                                    decoration: BoxDecoration(
                                        color: getColor(transactions!.data![index].status!),
                                        borderRadius: BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                        transactions!.data![index].status!.toString(),
                                        style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            color: Theme.of(context).accentColor,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.0.t),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0.h),
                    child: Divider(
                      thickness: 4,
                      color: Colors.red,
                    ),
                  )
                ],
              );
            },
            shrinkWrap: true,
            itemCount: transactions!.data!.length,
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

  Color getColor(TransactionStatusEnum value) {
    switch (value) {
      case TransactionStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case TransactionStatusEnum.CATEGORY_REJECTED:
        return AppColor.vividRed;
      case TransactionStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
