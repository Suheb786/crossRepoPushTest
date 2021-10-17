import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AccountReadyHeader extends StatelessWidget {

  String? title;
  String? subTitle;

  AccountReadyHeader({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title!,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: AppColor.very_light_violet),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle!,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColor.very_light_violet),
        ),
      ],
    );
  }
}
