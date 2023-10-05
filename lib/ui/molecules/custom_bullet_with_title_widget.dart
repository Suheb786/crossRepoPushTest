import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CustomBulletWithTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final double lineHeight;

  const CustomBulletWithTitle({
    required this.title,
    required this.fontSize,
    this.lineHeight = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 4.w,
          height: 4.h,
          margin: EdgeInsets.only(top: 7.h),
          decoration: BoxDecoration(
            color: AppColor.veryDarkGray1,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: StringUtils.appFont,
              fontSize: fontSize,
              height: lineHeight,
            ),
          ),
        ),
      ],
    );
  }
}
