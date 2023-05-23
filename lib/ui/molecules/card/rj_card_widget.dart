import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../utils/string_utils.dart';

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
              color: AppColor.rj_gray,
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage(AssetUtils.New_RJ_BG),
                fit: BoxFit.contain,
                scale: 0.92,
                matchTextDirection: true,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: EdgeInsetsDirectional.only(top: 24.h, start: 24.w),
                //   child: Align(
                //     alignment: AlignmentDirectional.topStart,
                //     child: AppSvg.asset(AssetUtils.GoRjLogo, width: 97.51.h, height: 42.w),
                //   ),
                // ),
                // Image.asset(
                //   AssetUtils.RjCardDescriptionLogo,
                //   height: 105.h,
                //   width: 190.w,
                // ),
                SizedBox(
                  height: 357,
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
                          Navigator.pushNamed(context, RoutePaths.RjFlightBookingPage);

                          // RjFlightBookingDialog.show(context, onSelected: (value) {
                          //   Navigator.pop(context);
                          // }, onDismissed: () {
                          //   Navigator.pop(context);
                          // });
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                        decoration: BoxDecoration(
                            color: Theme.of(context).textTheme.bodyLarge!.color!,
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
