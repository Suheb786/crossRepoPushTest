import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_complete/credit_card_videocall_complete_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CreditCardVideoCallCompletePageView
    extends BasePageViewWidget<CreditCardVideoCallCompletePageViewModel> {
  CreditCardVideoCallCompletePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .getDashboardData();
        } else {
          //Navigator.pop(context);
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 56.0, left: 24, right: 24, bottom: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              S.of(context).applyForCreditCard,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              S.of(context).verificationCallEnded,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).accentColor),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
                child: Card(
              elevation: 10,
              shadowColor: Theme.of(context).primaryColorDark,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0, bottom: 24),
                        child: Container(
                          // height: 78,
                          // width: 78,
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColor.vividYellow,
                            shape: BoxShape.circle,
                          ),
                          child: AppSvg.asset(AssetUtils.ccAgent,
                              width: 32,
                              height: 32,
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      Text(
                        S.of(context).verificationCallEndedDesc,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Theme.of(context).primaryColorDark),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Center(
                      child: AnimatedButton(
                        buttonText: S.of(context).swipeToProceed,
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
