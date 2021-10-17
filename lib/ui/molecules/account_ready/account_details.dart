import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AccountDetails extends StatelessWidget {

  String? title;
  String? value;

  AccountDetails({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title!,
            style: TextStyle(
                color: AppColor.light_gray1,
                fontWeight: FontWeight.w400,
                fontSize: 12
            ),
          ),
        ),
        Text(
          value!,
          style: TextStyle(
              color: AppColor.light_gray1,
              fontWeight: FontWeight.w400,
              fontSize: 12
          ),
        )
      ],
    );
  }
}
