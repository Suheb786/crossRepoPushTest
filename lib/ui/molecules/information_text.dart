import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';

class InformationText extends StatelessWidget {
  String? image;
  String? title;

  InformationText({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvg.asset(image!),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Text(
            title!,
            style: TextStyle(
                color: Theme.of(context).primaryTextTheme.bodyText1!.color!,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        )
      ],
    );
  }
}
