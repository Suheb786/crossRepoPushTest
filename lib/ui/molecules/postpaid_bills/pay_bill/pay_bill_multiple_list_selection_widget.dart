import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayBillsMultipleListSelectionWidget extends StatelessWidget {
  final String icon;
  final String billType;
  final String billName;
  final String billAmtDue;
  final bool isSelected;
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;
  const PayBillsMultipleListSelectionWidget(
      {Key? key,
      required this.icon,
      required this.billType,
      required this.billName,
      required this.billAmtDue,
      required this.isSelected,
      required this.paidBillsPayTypeOptionEnum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.all(24.0),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.vividYellow,
            ),
            child: AppSvg.asset(icon),
          ),
          SizedBox(
            width: 5.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                billType,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0.t),
              ),
              Text(
                billName,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.veryDarkGray2,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.t),
              ),
              this.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                  ? RichText(
                      text: TextSpan(
                          text: 'Due ',
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.veryDarkGray2,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.t),
                          children: [
                          TextSpan(
                              text: billAmtDue,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.veryDarkGray2,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0.t)),
                          TextSpan(
                              text: ' ' + S.of(context).JOD,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.veryDarkGray2,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.0.t)),
                        ]))
                  : Visibility(
                      visible: this.isSelected,
                      child: RichText(
                          text: TextSpan(
                              text: 'Due ',
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.veryDarkGray2,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.0.t),
                              children: [
                            TextSpan(
                                text: billAmtDue,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryDarkGray2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0.t)),
                            TextSpan(
                                text: ' ' + S.of(context).JOD,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryDarkGray2,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.0.t)),
                          ])),
                    )
            ],
          ),
          Spacer(),
          isSelected
              ? Container(
                  height: 40,
                  width: 40,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 10, end: 10, bottom: 10, top: 10),
                    child: AppSvg.asset(AssetUtils.tick, color: AppColor.black),
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.vividYellow,
                    borderRadius: BorderRadius.circular(100),
                  ),
                )
              : Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    border: Border.all(color: AppColor.gray1),
                  ),
                ),
        ],
      ),
    );
  }
}
