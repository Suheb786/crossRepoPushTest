import 'package:data/di/local_module.dart';
import 'package:data/network/api_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../utils/app_constants.dart';

class CreditCardApplicationFailurePageView extends BasePageViewWidget<CreditCardApplicationFailureViewModel> {
  CreditCardApplicationFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardApplicationFailureViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 72.0.h, bottom: 24.h),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(AssetUtils.line, color: Theme.of(context).colorScheme.secondary.withOpacity(0.4)),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 111.37.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).canvasColor,
                  ),
                  child: Center(
                      child: AppSvg.asset(
                          model.creditCardApplicationFailureArguments.creditFailureState ==
                                  CreditFailureState.FATCA
                              ? AssetUtils.exclamationMark
                              : AssetUtils.cancel,
                          color: Theme.of(context).primaryColorDark)),
                ),
              ),
            ],
          ),
          Padding(
            padding:
                model.creditCardApplicationFailureArguments.creditFailureState == CreditFailureState.FATCA
                    ? EdgeInsets.only(top: 56.h, left: 40.w, right: 40.w)
                    : EdgeInsets.only(top: 46.h, left: 40.w, right: 40.w),
            child: Text(
              getTitle(context, model.creditCardApplicationFailureArguments.creditFailureState),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.t,
                  color: Theme.of(context).colorScheme.secondary),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 16.h,
              start: 40.w,
              end: 40.w,
            ),
            child: Text(getSubTitle(context, model.creditCardApplicationFailureArguments.creditFailureState),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600)),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: AppSecondaryButton(
              text: S.of(context).backToDashboard,
              onPressed: () {
                if (model.creditCardApplicationFailureArguments.creditFailureState ==
                        CreditFailureState.InEligible ||
                    model.creditCardApplicationFailureArguments.creditFailureState ==
                        CreditFailureState.ZERO_BALANCE ||
                    model.creditCardApplicationFailureArguments.creditFailureState ==
                        CreditFailureState.AccountDormant) {
                  Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                  ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                } else if (model.creditCardApplicationFailureArguments.creditFailureState ==
                    CreditFailureState.EngagementTeamRejection) {
                  Navigator.pushNamed(context, RoutePaths.AppHome);
                } else if (model.creditCardApplicationFailureArguments.creditFailureState ==
                    CreditFailureState.FATCA) {
                  authToken = '';
                  ProviderScope.containerOf(appLevelKey.currentState!.context)
                      .read(localSessionService)
                      .stopTimer();
                  AppConstantsUtils.resetCacheLists();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RoutePaths.OnBoarding, ModalRoute.withName(RoutePaths.Splash));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  String getTitle(BuildContext context, CreditFailureState creditFailureState) {
    switch (creditFailureState) {
      case CreditFailureState.InEligible:
        return S.of(context).applicationNotSuccessful;
      case CreditFailureState.AccountDormant:
        return S.of(context).dormantAccountCCFailedTitle;
      case CreditFailureState.EngagementTeamRejection:
        return S.of(context).applicationNotSuccessful;
      case CreditFailureState.ZERO_BALANCE:
        return S.of(context).creditZeroBalanceRejtitle;
      case CreditFailureState.FATCA:
        return S.of(context).fatcaEligible;
    }
  }

  String getSubTitle(BuildContext context, CreditFailureState creditFailureState) {
    switch (creditFailureState) {
      case CreditFailureState.InEligible:
        return S.of(context).applicationFailureMsg;
      case CreditFailureState.EngagementTeamRejection:
        return S.of(context).applicationRejectedByEngagementTeam;
      case CreditFailureState.AccountDormant:
        return S.of(context).accountDormantDesc;
      case CreditFailureState.ZERO_BALANCE:
        return S.of(context).creditZeroBalanceRejDesc;
      case CreditFailureState.FATCA:
        return "";
    }
  }
}
