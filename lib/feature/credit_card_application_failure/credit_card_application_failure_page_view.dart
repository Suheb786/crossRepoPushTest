import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class CreditCardApplicationFailurePageView
    extends BasePageViewWidget<CreditCardApplicationFailureViewModel> {
  CreditCardApplicationFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(
      BuildContext context, CreditCardApplicationFailureViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          if (model.creditCardApplicationFailureArguments.creditFailureState ==
              CreditFailureState.InEligible) {
            Navigator.popUntil(
                context, ModalRoute.withName(RoutePaths.AppHome));
            ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .getDashboardData();
          } else if (model
                  .creditCardApplicationFailureArguments.creditFailureState ==
              CreditFailureState.EngagementTeamRejection) {
            Navigator.pushNamed(context, RoutePaths.AppHome);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 72.0, bottom: 24),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(AssetUtils.line,
                    color: Theme.of(context).accentColor.withOpacity(0.4)),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).canvasColor,
                    ),
                    child: Center(
                        child: AppSvg.asset(AssetUtils.cancel,
                            color: Theme.of(context).primaryColorDark)),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 46),
              child: Text(
                S.of(context).applicationNotSuccessful,
                textAlign: TextAlign.center,
                maxLines: 3,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Theme.of(context).accentColor),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                top: 16,
                start: 40,
                end: 40,
              ),
              child: Text(
                  model.creditCardApplicationFailureArguments
                              .creditFailureState ==
                          CreditFailureState.InEligible
                      ? S.of(context).applicationFailureMsg
                      : S.of(context).applicationRejectedByEngagementTeam,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
            Spacer(),
            AnimatedButton(
              buttonText: S.of(context).swipeToProceed,
              borderColor: Theme.of(context).accentColor,
              textColor: Theme.of(context).accentColor,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(top: 9),
                child: Text(
                  S.of(context).toDashboard,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
