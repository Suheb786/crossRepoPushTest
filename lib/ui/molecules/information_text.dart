import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';

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
      this.containerColor: AppColor.vividYellow,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 56,
          width: 56,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: containerColor,
            shape: BoxShape.circle,
          ),
          child: AppSvg.asset(image!, color: iconColor),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            title!,
            style: TextStyle(
                color: textColor ??
                    Theme.of(context).primaryTextTheme.bodyText1!.color!,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        )
      ],
    );
  }
}
