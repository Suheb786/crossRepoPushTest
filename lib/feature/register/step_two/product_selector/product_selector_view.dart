import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_two/product_selector/product_selector_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';

class ProductSelectorView extends BasePageViewWidget<ProductSelectorViewModel> {
  ProductSelectorView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ProductSelectorViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).openAccount,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Text(
              S.of(context).productSelectorHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {
                  print("Hello");
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.very_soft_violet,
                          gradient: LinearGradient(
                              colors: [
                                AppColor.dark_violet,
                                AppColor.dark_moderate_blue
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 24, right: 24, bottom: 32),
                            child: Column(
                              children: [
                                SizedBox(height: 254),
                                InformationText(
                                    image: AssetUtils.world,
                                    title: S.of(context).acceptedWorldWide),
                                SizedBox(height: 16),
                                InformationText(
                                    image: AssetUtils.gift,
                                    title: S.of(context).loyaltyRewards),
                                SizedBox(height: 16),
                                InformationText(
                                    image: AssetUtils.earphone,
                                    title: S.of(context).customerService),
                                SizedBox(height: 17),
                                InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    height: 57,
                                    width: 57,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColor.dark_violet_4),
                                    child: AppSvg.asset(AssetUtils.tick),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 87.38,
                      top: -20,
                      right: 87.62,
                      child: Image.asset(AssetUtils.card),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
