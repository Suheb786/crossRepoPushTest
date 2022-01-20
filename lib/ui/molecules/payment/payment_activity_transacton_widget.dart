import 'package:domain/model/payment/payment_activity_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentActivityTransactionWidget extends StatelessWidget {
  final PaymentActivityContent? transactions;

  const PaymentActivityTransactionWidget({Key? key, this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          // TimeUtils.getFormattedDateForTransaction(transactions!.label!),
          transactions!.rtpDate.toString(),
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
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Text(
                          StringUtils.getFirstInitials(
                              transactions!.data![index].name!),
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   "You requested ${transactions!.data![index].amount}",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w800, fontSize: 12),
                        // ),
                        // Text(
                        //   "from ${transactions!.data![index].name}",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.w800, fontSize: 12),
                        // ),
                        RichText(
                            text: TextSpan(
                                text: S.of(context).requestedFrom,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).primaryColorDark),
                                children: [
                              TextSpan(
                                  text:
                                      " ${transactions!.data![index].amount} JOD",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Theme.of(context).primaryColorDark),
                                  children: [
                                    TextSpan(
                                        text: S.of(context).from,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context)
                                                .primaryColorDark),
                                        children: [
                                          TextSpan(
                                            text:
                                                " ${transactions!.data![index].name}",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          )
                                        ])
                                  ])
                            ])),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Text(
                                DateFormat.Hms().format(
                                    transactions!.data![index].rtpDate!),
                                style: TextStyle(
                                    color: AppColor.gray1,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 9),
                                child: Container(
                                  height: 20,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color:
                                          transactions!.data![index].status! ==
                                                  "Pending"
                                              ? AppColor.dark_orange
                                              : AppColor.darkModerateLimeGreen,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Center(
                                    child: Text(
                                      transactions!.data![index].status!,
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 44),
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
