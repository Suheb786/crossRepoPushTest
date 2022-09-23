import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ResumeCreditCardApplicationView extends StatelessWidget {
  final bool isSmallDevices;

  const ResumeCreditCardApplicationView({this.isSmallDevices: false, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
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
            child: Container(
              padding: EdgeInsetsDirectional.only(top: 22.0.h, bottom: 40.0.h, start: 24.0.w, end: 24.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppSvg.asset(AssetUtils.blinkWhite, height: 33.64.h, width: 72.0.w),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: AppSvg.asset(AssetUtils.cardCircle, height: 96.0.h),
                      ),
                      SizedBox(
                        height: 16.0.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          S.of(context).resumeCreditCardProcess,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.0.t,
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
                        Navigator.pushNamed(context, RoutePaths.CreditCardActivationStatus);
                      },
                      child: Container(
                        height: 48.0.h,
                        width: 232.0.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Theme.of(context).accentTextTheme.bodyText1!.color,
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).resumeCreditCardText,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).accentColor,
                                fontSize: 12.0.t,
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
