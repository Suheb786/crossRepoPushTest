import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ResumeCreditCardApplicationView extends StatelessWidget {
  final bool isSmallDevices;

  const ResumeCreditCardApplicationView({this.isSmallDevices: false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(15),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
            child: Container(
              padding: EdgeInsetsDirectional.only(
                  top: 22, bottom: 40, start: 24, end: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppSvg.asset(AssetUtils.blinkWhite,
                      height: isSmallDevices ? 26 : 33.64,
                      width: isSmallDevices ? 52 : 72),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: AppSvg.asset(AssetUtils.cardCircle,
                            height: isSmallDevices ? 72 : 96),
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
                              fontSize: isSmallDevices ? 12 : 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).accentColor),
                        ),
                      ),
                    ],
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
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color,
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
            ),
          ),
        ),
      ),
    );
  }
}
