import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DebitCardErrorWidget extends StatelessWidget {
  final double? fontSize;
  final bool isSmallDevices;

  DebitCardErrorWidget({this.fontSize, this.isSmallDevices = false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      color: Theme.of(context).canvasColor,
      margin: EdgeInsets.zero,
      shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(AssetUtils.debitBlurWidget), fit: BoxFit.fill, scale: isSmallDevices ? 1.3 : 1, matchTextDirection: true)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppSvg.asset(AssetUtils.failure),
            SizedBox(
              height: 16.0.h,
            ),
            Text(
              S.of(context).creditCardIssuanceFailure,
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.secondary, fontSize: 14.0.t, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
