import 'package:domain/model/user/confirm_application_data_get/additional_income_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AdditionalIncomeListWidget extends StatelessWidget {
  final String? title;
  final AdditionalIncomeInfo? additionalIncomeInfo;

  const AdditionalIncomeListWidget({Key? key, this.title, this.additionalIncomeInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              title!,
              softWrap: true,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.very_dark_gray),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  additionalIncomeInfo!.additionalIncomeSource!,
                  softWrap: true,
                  maxLines: 3,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Text(
                  "${S.of(context).JOD} ${num.parse(additionalIncomeInfo!.totalIncome!).toStringAsFixed(3)}",
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
