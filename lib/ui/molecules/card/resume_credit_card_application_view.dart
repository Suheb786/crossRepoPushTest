import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ResumeCreditCardApplicationView extends StatelessWidget {
  final double? iconHeight;
  final double? blinkIconWidth;
  final double? blinkIconHeight;

  const ResumeCreditCardApplicationView(
      {this.iconHeight, this.blinkIconWidth, this.blinkIconHeight, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 22, bottom: 40, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSvg.asset(AssetUtils.blinkWhite,
              height: blinkIconHeight, width: blinkIconWidth),
          SizedBox(height: 69),
          Align(
            alignment: Alignment.center,
            child: AppSvg.asset(AssetUtils.cardCircle, height: iconHeight!),
          ),
          SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              S.of(context).resumeCreditCardProcess,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(
            height: 28,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, RoutePaths.CreditCardActivationStatus);
              },
              child: Container(
                height: 48,
                width: 232,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Theme.of(context).accentTextTheme.bodyText1!.color,
                ),
                child: Center(
                  child: Text(
                    S.of(context).resumeCreditCardText,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
