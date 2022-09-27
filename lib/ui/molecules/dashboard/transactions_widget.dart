import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionContent? transactions;

  const TransactionWidget({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transactions!.label!.isNotEmpty
              ? TimeUtils.getFormattedDateForAccountTransaction(transactions!.label!)
              : '-',
          //transactions!.label!,
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
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactions!.transactions![index].description!,
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
                            TimeUtils.getFormattedTimeForTransaction(
                                transactions!.transactions![index].time!.toString()),
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
                            transactions!.transactions![index].trnxType == "D"
                                ? "-" + transactions!.transactions![index].amount!.toStringAsFixed(3)
                                : transactions!.transactions![index].amount!.toStringAsFixed(3),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: transactions!.transactions![index].trnxType == "D"
                                    ? AppColor.dark_brown
                                    : AppColor.darkModerateLimeGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.t),
                          ),
                          Text(
                            " ${transactions!.transactions![index].amountCur}",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            transactions!.transactions![index].balance!.toStringAsFixed(3),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0.t),
                          ),
                          Text(
                            " ${transactions!.transactions![index].balanceCur}",
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.0.t,
                                color: Theme.of(context).inputDecorationTheme.hintStyle!.color),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            },
            shrinkWrap: true,
            itemCount: transactions!.transactions!.length,
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
