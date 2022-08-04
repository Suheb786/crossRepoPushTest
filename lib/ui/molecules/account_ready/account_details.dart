import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountDetails extends StatelessWidget {
  final String? title;
  final String? value;
  final bool? showIcon;

  AccountDetails({required this.title, required this.value, this.showIcon = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title!,
            style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 12),
          ),
        ),
        Row(
          children: [
            Text(
              value!,
              style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600, fontSize: 12),
            ),
            SizedBox(
              width: 7,
            ),
            Visibility(
              visible: showIcon!,
              child: InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: value ?? ''))
                        .then((value) => Fluttertoast.showToast(msg: 'Copied'));
                  },
                  child: AppSvg.asset(AssetUtils.copy)),
            )
          ],
        )
      ],
    );
  }
}
