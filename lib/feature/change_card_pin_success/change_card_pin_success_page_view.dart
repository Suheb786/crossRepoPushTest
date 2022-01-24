import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ChangeCardPinSuccessPageView
    extends BasePageViewWidget<ChangeCardPinSuccessPageViewModel> {
  ChangeCardPinSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ChangeCardPinSuccessPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .getDashboardData();
        }
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: model.arguments.cardType == CardType.DEBIT
              ? Theme.of(context).canvasColor
              : Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 92),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AssetUtils.line,
                            color: model.arguments.cardType == CardType.DEBIT
                                ? Theme.of(context).accentColor.withOpacity(0.4)
                                : AppColor.softRed,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    model.arguments.cardType == CardType.DEBIT
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).canvasColor,
                              ),
                              child: Center(
                                  child: AppSvg.asset(AssetUtils.right,
                                      color: model.arguments.cardType ==
                                              CardType.DEBIT
                                          ? Theme.of(context).accentColor
                                          : Theme.of(context)
                                              .primaryColorDark)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34.7,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Text(
                              S.of(context).cardPinChangedSuccessfully,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24,
                                  color:
                                      model.arguments.cardType == CardType.DEBIT
                                          ? Theme.of(context).primaryColorDark
                                          : Theme.of(context).accentColor),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Text(
                              S.of(context).cardPinChangedDesc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color:
                                      model.arguments.cardType == CardType.DEBIT
                                          ? Theme.of(context).primaryColorDark
                                          : Theme.of(context).accentColor),
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
                  AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    textColor: model.arguments.cardType == CardType.DEBIT
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).accentColor,
                    borderColor: model.arguments.cardType == CardType.DEBIT
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 32,
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).toDashboard,
                        style: TextStyle(
                          color: model.arguments.cardType == CardType.DEBIT
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).accentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
