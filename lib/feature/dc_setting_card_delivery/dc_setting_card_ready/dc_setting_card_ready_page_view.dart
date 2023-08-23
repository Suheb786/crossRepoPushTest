import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dc_setting_card_delivery/dc_setting_card_ready/dc_setting_card_ready_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DcSettingCardReadyPageView extends BasePageViewWidget<DcSettingCardReadyViewModel> {
  DcSettingCardReadyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, DcSettingCardReadyViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).canvasColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 92.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(AssetUtils.line,
                            color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: AppSvg.asset(AssetUtils.right,
                                    color: Theme.of(context).colorScheme.secondary)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.7.h,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).yourCardReady,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 24.t,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                          child: Text(
                            S.of(context).youCanAddMoney,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.t,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppPrimaryButton(text: S.of(context).next, onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                  }),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 32.h,
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).toDashboard,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.t,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
