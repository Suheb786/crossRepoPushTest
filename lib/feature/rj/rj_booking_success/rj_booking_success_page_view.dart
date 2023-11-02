import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/rj/rj_booking_success/rj_booking_success_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../base/base_page.dart';
import '../../../generated/l10n.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/string_utils.dart';

class RJBookingSuccessPageView extends BasePageViewWidget<RJBookingSuccessPageViewModel> {
  RJBookingSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, RJBookingSuccessPageViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
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
                        Image.asset(
                          AssetUtils.line,
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                          color: Theme.of(context).colorScheme.outlineVariant,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).canvasColor,
                            ),
                            child: Center(
                                child: AppSvg.asset(AssetUtils.right,
                                    color: Theme.of(context).primaryColorDark)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                  Text(
                    S.current.bookingConfirmed,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.t,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      S.current.bookingConfirmedDescription,
                      // model.description(context, model.rjBookingSuccessPageArguments.rjBookingSuccessState),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.t,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24..w, end: 24.w),
                  child: AppPrimaryButton(
                    text: S.of(context).backToDashboard,
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                      model.animateBackToDashboard(context);
                      ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                    },
                    activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                SizedBox(
                  height: 56.h,
                ),
              ],
            )
          ],
        ));
  }
}
