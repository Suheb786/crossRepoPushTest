import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_linked_mobile_number_page.dart';
import 'package:neo_bank/feature/dc_change_linked_mobile_number/dc_change_mobile_number_success/dc_change_mobile_number_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DcChangeMobileNumberSuccessPageView extends BasePageViewWidget<DcChangeMobileNumberSuccessViewModel> {
  final DCChangeLinkedMobileNumberArguments _arguments;

  DcChangeMobileNumberSuccessPageView(ProviderBase model, this._arguments) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 92, bottom: 24.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line,
                      color: _arguments.cardType == CardType.DEBIT
                          ? Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                          : AppColor.softRed),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _arguments.cardType == CardType.DEBIT
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).canvasColor,
                      ),
                      child: Center(
                          child: AppSvg.asset(AssetUtils.right,
                              color: _arguments.cardType == CardType.DEBIT
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).primaryColorDark)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 56.0),
                child: Text(
                  S.of(context).cardDetailUpdated,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: _arguments.cardType == CardType.DEBIT
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).colorScheme.secondary),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 24.0, start: 40, end: 40),
                child: Text(
                  S.of(context).dcMobileNumberUpdated,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _arguments.cardType == CardType.DEBIT
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
          Column(
            children: [
              /*AnimatedButton(
                buttonText: S.of(context).swipeToProceed,
                borderColor: _arguments.cardType == CardType.DEBIT
                    ? Theme.of(context).textTheme.bodyLarge!.color!
                    : Theme.of(context).colorScheme.secondary,
                textColor: _arguments.cardType == CardType.DEBIT
                    ? Theme.of(context).textTheme.bodyLarge!.color!
                    : Theme.of(context).colorScheme.secondary,
              ),*/
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: AppPrimaryButton(
                    text: S.of(context).backToDashboard,
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                      ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
