import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class SendMoneyFailurePageView
    extends BasePageViewWidget<SendMoneyFailureViewModel> {
  SendMoneyFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92),
        child: SingleChildScrollView(
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
                  padding: EdgeInsets.only(top: 47),
                  child: Text(
                    S.of(context).sendMoneyNotSuccessful,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).accentColor),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 51),
                child: Text(
                  S.of(context).tryAgainLater,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Theme.of(context).accentColor),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 262),
                child: AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  borderColor: Theme.of(context).accentColor,
                  textColor: Theme.of(context).accentColor,
                ),
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
      ),
    );
  }
}
