import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/product_selector/product_selector_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:riverpod/src/framework.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ProductSelectorView extends BasePageViewWidget<ProductSelectorViewModel> {
  ProductSelectorView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ProductSelectorViewModel model) {
    return AppKeyBoardHide(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutePaths.OnBoarding,
                      ModalRoute.withName(RoutePaths.Splash));
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 30, top: 40),
                  child: Container(
                      height: 24,
                      width: 24,
                      child: AppSvg.asset(AssetUtils.logout)),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              S.of(context).openAccount,
              style: TextStyle(
                  color: AppColor.dark_gray,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 8.0, bottom: 32, left: 24, right: 24),
              child: ShowUpAnimation(
                key: ValueKey(0),
                delayStart: Duration(milliseconds: 500),
                animationDuration: Duration(milliseconds: 750),
                curve: Curves.bounceIn,
                direction: Direction.vertical,
                offset: 0.5,
                child: Text(
                  S.of(context).productSelectorHeader,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: ShakeAnimatedWidget(
                enabled: false,
                duration: Duration(milliseconds: 100),
                shakeAngle: Rotation.deg(z: 1),
                curve: Curves.easeInOutSine,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {},
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColor.black.withOpacity(0.32),
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
                                  SizedBox(height: 228),
                                  InformationText(
                                      image: AssetUtils.world,
                                      title: S.of(context).acceptedWorldWide),
                                  SizedBox(height: 32),
                                  InformationText(
                                      image: AssetUtils.gift,
                                      title: S.of(context).loyaltyRewards),
                                  SizedBox(height: 32),
                                  InformationText(
                                      image: AssetUtils.earphone,
                                      title: S.of(context).customerService),
                                  SizedBox(height: 25),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushReplacementNamed(
                                          context, RoutePaths.Registration);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      height: 57,
                                      width: 57,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: AppColor.white_gray),
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
      ),
    );
  }
}
