import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class InformationText extends StatelessWidget {
  final String? image;
  final String? title;
  final Color? iconColor;
  final Color? containerColor;
  final Color? textColor;

  InformationText(
      {required this.image,
      required this.title,
      this.iconColor,
      this.containerColor = AppColor.vividYellow,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56.h,
          width: 56.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: containerColor,
            shape: BoxShape.circle,
          ),
          child: AppSvg.asset(image!, color: iconColor),
        ),
        SizedBox(
          width: 16.w,
        ),
        Expanded(
          child: Text(
            title!,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: textColor ?? Theme.of(context).primaryTextTheme.bodyLarge?.color!,
                fontWeight: FontWeight.w600,
                fontSize: 14.t),
          ),
        )
      ],
    );
  }
}
