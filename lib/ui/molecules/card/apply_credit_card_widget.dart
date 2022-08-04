import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ApplyCreditCardWidget extends StatelessWidget {
  final bool isSmallDevices;

  const ApplyCreditCardWidget({Key? key, this.isSmallDevices: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetUtils.zigzagBackground),
                    fit: BoxFit.cover,
                    scale: isSmallDevices ? 1.3 : 1,
                    matchTextDirection: true)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(top: 23, end: 23, start: 23),
                  child: AppSvg.asset(AssetUtils.blink_updated_logo,
                      height: isSmallDevices ? 26 : 33.64, width: isSmallDevices ? 52 : 72),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: isSmallDevices ? 20 : 58),
                  child: Align(
                    alignment: Alignment.center,
                    child: AppSvg.asset(AssetUtils.cardCircle, height: isSmallDevices ? 72 : 96),
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.only(top: 10, start: 23, end: 23),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).blinkCreditCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: isSmallDevices ? 10 : 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor),
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: isSmallDevices ? 50 : 88,
                      // bottom: isSmallDevices ? 30 : 50,
                      start: isSmallDevices ? 34 : 24,
                      end: isSmallDevices ? 34 : 24),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.BlinkCreditCard);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentTextTheme.bodyText1?.color,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            S.of(context).applyNow,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: isSmallDevices ? 12 : 14,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
