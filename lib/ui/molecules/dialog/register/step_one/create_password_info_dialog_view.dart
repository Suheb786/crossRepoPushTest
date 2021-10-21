import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreatePasswordInfoDialogView extends StatelessWidget {
  const CreatePasswordInfoDialogView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 56, top: 204),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).passwordDialogHeader,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 32),
            Text(
              S.of(context).passwordDialogContent,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 315),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(16),
                height: 57,
                width: 57,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColor.dark_violet_4),
                child: AppSvg.asset(AssetUtils.tick),
              ),
            )
          ],
        ),
      ),
    );
  }
}
