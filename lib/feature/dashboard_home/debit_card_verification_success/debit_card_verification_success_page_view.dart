import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class DebitCardVerificationSuccessPageView
    extends BasePageViewWidget<DebitCardVerificationSuccessViewModel> {
  DebitCardVerificationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
            Navigator.of(context)
              ..pop()
              ..pop(true);
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 92),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      AssetUtils.line,
                      color: Theme.of(context).accentColor,
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
                            child: AppSvg.asset(
                          AssetUtils.right,
                        )),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 34.0),
                  child: Text(
                    S.of(context).debitCardVerified,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    S.of(context).physicalCardUse,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 285),
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorDark,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 9),
                    child: Text(
                      S.of(context).toDashboard,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
