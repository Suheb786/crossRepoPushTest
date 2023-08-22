import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CardPinUnBlockSuccessPageView extends BasePageViewWidget<CardPinUnBlockSuccessPageViewModel> {
  CardPinUnBlockSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CardPinUnBlockSuccessPageViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: model.manageCardPinArguments.cardType == CardType.CREDIT
            ? Theme.of(context).primaryColor
            : Theme.of(context).canvasColor,
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
                            color: model.manageCardPinArguments.cardType == CardType.DEBIT
                                ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                                : AppColor.softRed),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                  ? Theme.of(context).canvasColor
                                  : Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: AppSvg.asset(
                              AssetUtils.right,
                              color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                  ? Theme.of(context).primaryColorDark
                                  : Theme.of(context).colorScheme.secondary,
                            )),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                          child: Text(
                            getSuccessTitle(model.manageCardPinArguments.successPageRouteEnum, context),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 24.t,
                                color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).textTheme.bodyLarge?.color),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                          child: Text(
                            getSuccessSubTitle(model.manageCardPinArguments.successPageRouteEnum, context),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.t,
                                color: model.manageCardPinArguments.cardType == CardType.CREDIT
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).textTheme.bodyLarge?.color),
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
                model.manageCardPinArguments.cardType != CardType.CREDIT
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: AppPrimaryButton(
                          text: S.of(context).next,
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                            ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .getDashboardData();
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: AppSecondaryButton(
                          text: S.of(context).next,
                          onPressed: () {
                            Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                            ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .getDashboardData();
                          },
                        ),
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
                        color: model.manageCardPinArguments.cardType == CardType.CREDIT
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).textTheme.bodyLarge?.color,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.t,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  String getSuccessTitle(SuccessPageRouteEnum successPageRouteEnum, BuildContext context) {
    switch (successPageRouteEnum) {
      case SuccessPageRouteEnum.UNBLOCK_DC:
        return S.of(context).cardPinSucccesFullyUnblocked;
      case SuccessPageRouteEnum.PHYSICAL_DC:
        return S.of(context).yourCardReady;
      default:
        return S.of(context).cardPinSucccesFullyUnblocked;
    }
  }

  String getSuccessSubTitle(SuccessPageRouteEnum successPageRouteEnum, BuildContext context) {
    switch (successPageRouteEnum) {
      case SuccessPageRouteEnum.UNBLOCK_DC:
        return S.of(context).cardPinSucccesFullyUnblockedDesc;
      case SuccessPageRouteEnum.PHYSICAL_DC:
        return S.of(context).requestPhysicalCardSuccessDec;
      default:
        return S.of(context).cardPinSucccesFullyUnblockedDesc;
    }
  }
}
