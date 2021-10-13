import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';

class IdVerificationInfoText extends StatelessWidget {
  String? image;
  String? title;

  IdVerificationInfoText({required this.image, required this.title});

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
                color: AppColor.white,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        )
      ],
    );
  }
}
