import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
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
          // TimeUtils.getFormattedDateForTransaction(transactions!.label!),
          transactions!.label!,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColorDark),
        ),
        Card(
          margin: EdgeInsets.only(top: 16, bottom: 32),
          color: Theme.of(context).accentColor,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 17),
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
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            TimeUtils.getFormattedTimeForTransaction(
                                transactions!.transactions![index].time!
                                    .toString()),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color,
                                fontSize: 12,
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
                                ? "-" +
                                    transactions!.transactions![index].amount!
                                        .toString()
                                : transactions!.transactions![index].amount!
                                    .toString(),
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          Text(
                            " ${transactions!.transactions![index].amountCur}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            transactions!.transactions![index].balance!
                                .toStringAsFixed(3),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          Text(
                            " ${transactions!.transactions![index].balanceCur}",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color),
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
                padding: const EdgeInsets.symmetric(vertical: 15.0),
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
