import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: AppColor.veryDarkGray1,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: fontSize,
              height: lineHeight,
            ),
          ),
        ),
      ],
    );
  }
}
