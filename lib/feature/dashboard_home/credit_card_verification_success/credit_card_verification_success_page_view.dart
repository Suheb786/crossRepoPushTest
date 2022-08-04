import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardVerificationSuccessPageView
    extends BasePageViewWidget<CreditCardVerificationSuccessViewModel> {
  CreditCardVerificationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          print("swiped");
          if (details.primaryVelocity!.isNegative) {
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop();
            //Navigator.pushNamed(context, RoutePaths.AppHome);
            ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
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
                    Image.asset(AssetUtils.line),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 111.37,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.vividYellow,
                        ),
                        child: Center(
                            child: AppSvg.asset(AssetUtils.right, color: Theme.of(context).accentColor)),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 34.0),
                  child: Text(
                    S.of(context).creditCardVerified,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    S.of(context).physicalCardUse,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 285),
                  child: AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    borderColor: Theme.of(context).accentColor,
                    textColor: Theme.of(context).accentColor,
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
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).accentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
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
