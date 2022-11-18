import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjCardWidget extends StatelessWidget {
  final bool isSmallDevices;

  const RjCardWidget({Key? key, this.isSmallDevices: false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsetsDirectional.all(15),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          // color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetUtils.RjCardBg),
                    fit: BoxFit.cover,
                    scale: isSmallDevices ? 1.3 : 1,
                    matchTextDirection: true)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 32, end: 24, start: 0.0),
                    child: AppSvg.asset(AssetUtils.RjCardLogo,
                        height: isSmallDevices ? 26 : 33.64, width: isSmallDevices ? 52 : 72),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: isSmallDevices ? 20 : 58, start: 24),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: AppSvg.asset(
                      AssetUtils.GoRjLogo,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    top: isSmallDevices ? 20 : 30,
                  ),
                  child: Center(
                    child: Image.asset(
                      AssetUtils.RjCardDescriptionLogo,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: isSmallDevices ? 50 : 88,
                      // bottom: isSmallDevices ? 30 : 50,
                      start: isSmallDevices ? 34 : 24,
                      end: isSmallDevices ? 34 : 24),
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        /// opening Rj Flight Booking Dialog
                        RjFlightBookingDialog.show(context, onSelected: (value) {
                          Navigator.pop(context);
                        }, onDismissed: () {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
                        decoration: BoxDecoration(
                            color: Theme.of(context).accentTextTheme.bodyText1?.color,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            S.of(context).bookNow,
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
