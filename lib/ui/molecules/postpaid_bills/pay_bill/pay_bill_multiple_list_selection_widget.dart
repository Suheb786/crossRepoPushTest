import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/get_bill_payments_categories.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayBillsMultipleListSelectionWidget extends StatelessWidget {
  final String icon;
  final String biller;
  final String nickName;
  final String billAmtDue;
  final String fees;
  final String maxValue;
  final bool isSelected;
  final bool isDisabled;
  final bool isPartial;
  final PostPaidBillsPayTypeOptionEnum paidBillsPayTypeOptionEnum;

  const PayBillsMultipleListSelectionWidget(
      {Key? key,
      required this.icon,
      required this.biller,
      required this.nickName,
      required this.billAmtDue,
      required this.fees,
      required this.maxValue,
      required this.isSelected,
      required this.isPartial,
      required this.isDisabled,
      required this.paidBillsPayTypeOptionEnum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.gray_2),
                      borderRadius: BorderRadius.circular(100)),
                  child: Image.asset(
                    GetBillPaymentsCategories.path(icon),
                    matchTextDirection: false,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          nickName,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0.t),
                        ),
                      ),
                      Text(
                        biller,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.veryDarkGray2,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0.t),
                      ),
                      this.paidBillsPayTypeOptionEnum == PostPaidBillsPayTypeOptionEnum.PAYALLBILLS
                          ? RichText(
                              text: TextSpan(
                                  text: S.of(context).due + " ",
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
                              visible: this.isSelected || double.parse(billAmtDue) > 0.0,
                              child: RichText(
                                  text: TextSpan(
                                      text: S.of(context).due + " ",
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
                            ),
                      Visibility(
                        visible: double.parse(fees) > 0.0,
                        child: RichText(
                            text: TextSpan(
                                text: S.of(context).fees + " ",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryDarkGray2,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0.t),
                                children: [
                              TextSpan(
                                  text: fees,
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
                ),
                // Spacer(),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          isSelected && !isDisabled
              ? Container(
                  height: 40.w,
                  width: 40.w,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w, bottom: 10.h, top: 10.h),
                    child: AppSvg.asset(AssetUtils.tick, color: AppColor.black),
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.vividYellow,
                    borderRadius: BorderRadius.circular(100),
                  ))
              : Container(
                  width: 40.0.w,
                  height: 40.0.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    border: !isDisabled
                        ? Border.all(color: AppColor.gray1.withOpacity(0.5))
                        : Border.all(color: AppColor.gray1),
                  ),
                ),
        ],
      ),
    );
  }
}
