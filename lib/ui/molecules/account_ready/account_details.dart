import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AccountDetails extends StatelessWidget {
  String? title;
  String? value;
  bool? showIcon;

  AccountDetails(
      {required this.title, required this.value, this.showIcon = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
        Row(
          children: [
            Text(
              value!,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
            SizedBox(
              width: 7,
            ),
            Visibility(
              visible: showIcon!,
              child: AppSvg.asset(AssetUtils.copy),
            )
          ],
        )
      ],
    );
  }
}
