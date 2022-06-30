import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class RequestMoneyFailurePageView extends BasePageViewWidget<RequestMoneyFailureViewModel> {
  RequestMoneyFailurePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: EdgeInsets.only(top: 92),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line, color: Theme.of(context).accentColor),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Center(
                          child: AppSvg.asset(AssetUtils.cancel, color: Theme.of(context).accentColor)),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 51),
                child: Text(
                  S.of(context).tryAgainLater,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 262),
                child: AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  borderColor: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorDark,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text(
                    S.of(context).toDashboard,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
