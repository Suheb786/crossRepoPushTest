import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjCardWidget extends StatelessWidget {
  const RjCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetUtils.RjCardBg),
                    fit: BoxFit.cover,
                    scale: 1,
                    matchTextDirection: true)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 32.h, end: 24.w, start: 0.0),
                    child: AppSvg.asset(AssetUtils.RjCardLogo, height: 63.64.h, width: 121.w),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 24.h, start: 24.w),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: AppSvg.asset(AssetUtils.GoRjLogo, width: 97.51.h, height: 42.w),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: 65.h,
                  ),
                  child: Center(
                    child: Image.asset(
                      AssetUtils.RjCardDescriptionLogo,
                      height: 105.h,
                      width: 190.w,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: 32.h,
                      // bottom: isSmallDevices ? 30 : 50,
                      start: 24.w,
                      end: 24.w),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        /// opening Rj Flight Booking Dialog
                        Future.delayed(Duration(milliseconds: 200), () {
                          RjFlightBookingDialog.show(context, onSelected: (value) {
                            Navigator.pop(context);
                          }, onDismissed: () {
                            Navigator.pop(context);
                          });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.bodyMedium!.color!,
                            borderRadius: BorderRadius.circular(100.w)),
                        child: Center(
                          child: Text(
                            S.of(context).bookNow,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontSize: 14.t,
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
