import 'package:domain/constants/enum/payment_type_enum.dart';
import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history.dart';
import 'package:domain/model/manage_contacts/beneficiary_transaction_history_content.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class BeneficiaryTransactionWidget extends StatelessWidget {
  final BeneficiaryTransactionHistoryContent? content;

  const BeneficiaryTransactionWidget({
    Key? key,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: (content?.data ?? []).isNotEmpty ? true : false,
          child: Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: Text(
              TimeUtils.getFormattedDateMonth(content?.date ?? ''),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.0.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyMedium?.color),
            ),
          ),
        ),
        Visibility(
          visible: (content?.data ?? []).isNotEmpty ? true : false,
          child: Card(
            margin: EdgeInsets.only(top: 16.0.h, bottom: 32.0.h),
            color: Theme.of(context).colorScheme.secondary,
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(left: 24.0.w, right: 24.h, top: 16.h, bottom: 16.0.h),
              itemBuilder: (context, index) {
                return (content?.data?[index].trxDir ==
                        RequestMoneyActivityStatusEnum.TRANSACTION_DIRECTORY_INCOMING)
                    ? Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _inwardMoney(context, content?.data?[index]),
                            Text(
                              content?.data?[index].paymentType == PaymentTypeEnum.RTP_REQUEST
                                  ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                      content?.data?[index].rtpDate ?? '')
                                  : TimeUtils.getFormattedTimeFor12HrsFormat(
                                      content?.data?[index].paymentDate ?? ''),
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t,
                                  color: Theme.of(context).textTheme.titleMedium?.color),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _outwardMoney(context, content?.data?[index]),
                            Text(
                              content?.data?[index].paymentType == PaymentTypeEnum.RTP_REQUEST
                                  ? TimeUtils.getFormattedTimeFor12HrsFormat(
                                      content?.data?[index].rtpDate ?? '')
                                  : TimeUtils.getFormattedTimeFor12HrsFormat(
                                      content?.data?[index].paymentDate ?? ''),
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t,
                                  color: Theme.of(context).textTheme.titleMedium?.color),
                            )
                          ],
                        ),
                      );
              },
              shrinkWrap: true,
              itemCount: (content?.data ?? []).length,
              separatorBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0.h),
                  child: AppDivider(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _inwardMoney(
    BuildContext context,
    BeneficiaryTransactionHistory? data,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).moneyReceivedFrom + " ${data?.dbtrName ?? ''}",
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 12.0.t,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surfaceVariant),
          ),
        ),
        SizedBox(
          width: 43.w,
        ),
        RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
                text: "-${data?.amount?.toStringAsFixed(3).toString() ?? ''} ",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.scrim),
                children: [
                  TextSpan(
                    text: "${data?.curr ?? ''}",
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 10.0.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                  )
                ]))
      ],
    );
  }

  Widget _outwardMoney(
    BuildContext context,
    BeneficiaryTransactionHistory? data,
  ) {
    return Row(
      children: [
        Expanded(
          child: Text(
            S.of(context).moneySentTo + " ${data?.cdtrName ?? ''}",
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 12.0.t,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.surfaceVariant),
          ),
        ),
        SizedBox(
          width: 43.w,
        ),
        RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
                text: "-${data?.amount?.toStringAsFixed(3).toString() ?? ''} ",
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.0.t,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.scrim),
                children: [
                  TextSpan(
                    text: "${data?.curr ?? ''}",
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 10.0.t,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onInverseSurface),
                  )
                ]))
      ],
    );
  }
}
