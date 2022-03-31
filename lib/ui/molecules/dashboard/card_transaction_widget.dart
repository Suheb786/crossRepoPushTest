import 'package:domain/constants/enum/transaction_type_enum.dart';
import 'package:domain/model/dashboard/transactions/transactions_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class CardTransactionWidget extends StatelessWidget {
  final TransactionContent? transactions;

  const CardTransactionWidget({Key? key, this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          transactions!.label!.isNotEmpty
              ? TimeUtils.getFormattedDateForAccountTransaction(
                  transactions!.label!)
              : '-',
          //transactions!.label!,
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: transactions!.transactions![index].type ==
                        TransactionTypeEnum.PendingAuthorization,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: AppColor.dark_orange,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        S.of(context).pending,
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions!.transactions![index].memo!,
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
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            transactions!.transactions![index].amount!
                                .toStringAsFixed(3),
                            style: TextStyle(
                                color: transactions!
                                        .transactions![index].amount!
                                        .toString()
                                        .contains('-')
                                    ? AppColor.dark_brown
                                    : AppColor.darkModerateLimeGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            transactions!.transactions![index].currency!,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 10,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color),
                          ),
                        ],
                      )
                    ],
                  ),
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
