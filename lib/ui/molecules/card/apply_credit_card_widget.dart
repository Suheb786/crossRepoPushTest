import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ApplyCreditCardWidget extends StatelessWidget {
  final bool isSmallDevices;

  const ApplyCreditCardWidget({Key? key, this.isSmallDevices: false}) : super(key: key);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 23.0.h, end: 23.0.w, start: 23.0.w),
                  child: AppSvg.asset(AssetUtils.blink_updated_logo, height: 33.64.h, width: 72.0.w),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 58.0.h),
                  child: Align(
                    alignment: Alignment.center,
                    child: AppSvg.asset(AssetUtils.cardCircle, height: 96.0.h),
                  ),
                ),
                Padding(
                    padding: EdgeInsetsDirectional.only(top: 10.0.h, start: 23.0.w, end: 23.0.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        S.of(context).blinkCreditCard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.0.t,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    )),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: 88.0.h,
                      // bottom: isSmallDevices ? 30 : 50,
                      start: 24.0.w,
                      end: 24.0.w),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.BlinkCreditCard);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.bodyMedium!.color!,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            S.of(context).applyNow,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.0.t,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.secondary),
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
