import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../feature/rj/rj_book_flight/rj_book_flight_page.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/device_size_helper.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      blurRadius: 15.0,
                      offset: Offset(0.0, 0.75))
                ],
              ),
              padding: EdgeInsets.only(top: 12.h),
              alignment: Alignment.center,
              child: AppSvg.asset(
                AssetUtils.GoRj,
                height: 60.h,
              ),
            ),
          ),
          Flexible(
            flex: 20,
            child: Container(
              height: double.infinity,
              alignment: Alignment.bottomCenter,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              child: AppSvg.asset(
                AssetUtils.WalkingLady,
                fit: BoxFit.fitHeight,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Flexible(
            flex: 10,
            child: Container(
              color: AppColor.softRed1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSvg.asset(AssetUtils.BestDealsWithBlink,
                            width: DeviceSizeHelper.isSmallDevice ? 100 : 115),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.only(right: 4.0),
                    child: Image.asset(
                      AssetUtils.AirplaneTail,
                      height: 118.h,
                      width: 123.w,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
