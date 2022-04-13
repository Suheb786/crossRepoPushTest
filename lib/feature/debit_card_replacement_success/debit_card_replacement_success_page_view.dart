import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class DebitCardReplacementSuccessPageView
    extends BasePageViewWidget<DebitCardReplacementSuccessPageViewModel> {
  DebitCardReplacementSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(
      BuildContext context, DebitCardReplacementSuccessPageViewModel model) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta!.isNegative) {
          Navigator.of(context)..pop();
          ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .getDashboardData();
        }
      },
      child: Container(
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
                      padding: EdgeInsets.only(top: 92),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            AssetUtils.line,
                            color:
                                Theme.of(context).accentColor.withOpacity(0.4),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Center(
                                  child: AppSvg.asset(AssetUtils.right,
                                      color: Theme.of(context).accentColor)),
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
                          Text(
                            S.of(context).yourCardReady,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 48.0),
                            child: Text(
                              S.of(context).yourCardReadyDesc,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColorDark),
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
                    textColor:
                        Theme.of(context).accentTextTheme.bodyText1!.color,
                    borderColor:
                        Theme.of(context).accentTextTheme.bodyText1!.color,
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
                          color: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color,
                          fontWeight: FontWeight.w500,
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
