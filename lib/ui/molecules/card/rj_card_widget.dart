import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../utils/asset_utils.dart';
import '../../../utils/string_utils.dart';

class RjCardWidget extends StatelessWidget {
  const RjCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      margin: EdgeInsets.zero,
      shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
      child: Center(
        child: Column(
          children: [
            Flexible(
              flex: 25,
              child: Container(),
            ),
            Flexible(
              flex: 50,
              child: Container(),
            ),
            Flexible(
              flex: 25,
              child: Container(),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 32.h,
                start: 24.w,
              ),
              child: InkWell(
                onTap: () {
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.pushNamed(context, RoutePaths.RjFlightBookingPage);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 3.4,
                  padding: EdgeInsetsDirectional.only(top: 11.h, bottom: 9.h),
                  decoration: BoxDecoration(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      borderRadius: BorderRadius.circular(100.w)),
                  child: Center(
                    child: Text(
                      S.of(context).bookNow,
                      textAlign: TextAlign.center,
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
            PositionedDirectional(
              bottom: 0.01,
              end: 15,
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Image.asset(
                  AssetUtils.AirplaneTail,
                  scale: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
