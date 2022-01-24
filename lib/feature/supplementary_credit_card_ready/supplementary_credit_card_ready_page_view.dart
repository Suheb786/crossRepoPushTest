import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SupplementaryCreditCardReadyPageView
    extends BasePageViewWidget<SupplementaryCreditCardReadyPageViewModel> {
  SupplementaryCreditCardReadyPageView(ProviderBase model) : super(model);

  @override
  Widget build(
      BuildContext context, SupplementaryCreditCardReadyPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
        }
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
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
                            color: AppColor.softRed,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).canvasColor,
                              ),
                              child: Center(
                                  child: AppSvg.asset(AssetUtils.right,
                                      color:
                                          Theme.of(context).primaryColorDark)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 46.7,
                    ),
                    Text(
                      S.of(context).yourCardIsReady,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                          color: Theme.of(context).accentColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        children: [
                          AppSvg.asset(AssetUtils.tick,
                              color: Theme.of(context).accentColor),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).aramaxWillConnectYouSoon,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Row(
                        children: [
                          AppSvg.asset(AssetUtils.tick,
                              color: Theme.of(context).accentColor),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Text(
                              S.of(context).youWillReceiveCardPinViaSms,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Theme.of(context).accentColor),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    textColor: Theme.of(context).accentColor,
                    borderColor: Theme.of(context).accentColor,
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
                          color: Theme.of(context).accentColor,
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
