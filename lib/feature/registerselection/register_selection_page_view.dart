import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/registerselection/register_selection_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/button/app_icon_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class RegisterSelectionPageView
    extends BasePageViewWidget<RegisterSelectionViewModel> {
  RegisterSelectionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 73.0),
          child: Text(
            S.of(context).letsCreateYourAccount,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 32,
                fontWeight: FontWeight.w600),
          ),
        ),
        GestureDetector(
          onVerticalDragUpdate: (details) {
            if (!details.primaryDelta!.isNegative &&
                details.primaryDelta != 0) {
              ProviderScope.containerOf(context)
                  .read(onBoardingViewModelProvider)
                  .onBoardingPageController
                  .previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 15, bottom: 16, right: 24, left: 24),
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.only(top: 270.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage(AssetUtils.loginCard),
                    alignment: Alignment.topCenter),
                boxShadow: [
                  BoxShadow(
                      color: AppColor.black.withOpacity(0.32),
                      blurRadius: 24,
                      offset: Offset(0, 8)),
                ]),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, RoutePaths.Registration);
                  },
                  child: Container(
                    padding: EdgeInsets.all(18),
                    width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.black.withOpacity(0.16),
                              blurRadius: 12,
                              spreadRadius: -4,
                              offset: Offset(0, 12)),
                        ],
                        gradient: LinearGradient(
                            colors: [AppColor.light_blue1, AppColor.soft_red],
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft)),
                    child: Center(
                      child: Text(S.of(context).registerViaEmail,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AppDivider(
                        color: AppColor.white.withOpacity(0.3),
                        indent: 24,
                        endIndent: 12,
                      ),
                      Text(
                        S.of(context).orContinueWith,
                        style: TextStyle(
                            color: AppColor.dark_grayish_violet1, fontSize: 12),
                      ),
                      AppDivider(
                        color: AppColor.white.withOpacity(0.3),
                        endIndent: 24,
                        indent: 12,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 36, left: 24, right: 24),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: AppIconButton(
                          icon: AssetUtils.apple,
                          iconSize: 28,
                        ),
                      ),
                      Container(width: 16),
                      Expanded(
                        child: AppIconButton(
                          icon: AssetUtils.google,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 2,
                  margin: EdgeInsets.only(bottom: 8, left: 96, right: 96),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.white),
                      borderRadius: BorderRadius.circular(1),
                      color: AppColor.white),
                )
              ],
            ),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 32),
            child: Text(
              S.of(context).swipeDownToLogin,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColor.dark_grayish_violet1,
                  fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}
