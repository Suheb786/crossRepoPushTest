import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreatePasswordInfoDialogView extends StatelessWidget {
  final Function? onDismissed;

  const CreatePasswordInfoDialogView({Key? key, this.onDismissed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      insetPadding: EdgeInsets.only(left: 24, right: 24, bottom: 56, top: 204),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  S.of(context).passwordDialogHeader,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.gray_black),
                ),
                SizedBox(height: 32),
                Text(
                  S.of(context).passwordDialogContent,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColor.gray_black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                onDismissed?.call();
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 36),
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
