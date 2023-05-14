import 'package:domain/model/register/additional_income.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AdditionalIncomeSelectorWidget extends StatelessWidget {
  final Color? textColor;
  final AdditionalIncome additionalIncome;
  final Function? onTap;

  const AdditionalIncomeSelectorWidget({
    Key? key,
    required this.additionalIncome,
    this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 28.h, start: 24.w, end: 24.w),
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: additionalIncome.isSelected ? AppColor.vividYellow : Colors.transparent,
                  border: Border.all(
                      color: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
                      width: 1)),
            ),
            SizedBox(
              width: 16.w,
            ),
            Flexible(
              child: Text(
                StringUtils.isDirectionRTL(context) ? additionalIncome.typeAr ?? '' : additionalIncome.type!,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: textColor ?? AppColor.black,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
