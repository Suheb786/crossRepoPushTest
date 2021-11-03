import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/information_text.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class DashboardPageView extends BasePageViewWidget<DashboardPageViewModel> {
  DashboardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(TextSpan(
                  text: S.of(context).hello,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    color: AppColor.mostly_desaturated_dark_violet,
                  ),
                  children: [
                    TextSpan(
                      text: ' Abdul Salam',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        color: AppColor.dark_violet_4,
                      ),
                    )
                  ])),
              InkWell(
                onTap: () {},
                child: AppSvg.asset(AssetUtils.menuIcon),
              )
            ],
          ),
          SizedBox(
            height: 29,
          ),
          Expanded(
            child: ShakeAnimatedWidget(
              enabled: false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) {},
                child: Card(
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
                            AppColor.strong_violet_1,
                            AppColor.strong_magenta
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 24, right: 24, bottom: 32, top: 32),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                AppSvg.asset(AssetUtils.loader),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  S.of(context).welcome,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.light_grayish_violet_1),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 48,
                            ),
                            Text(
                              S.of(context).successfullyCreatedLoginAccount,
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.white),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            InformationText(
                                image: AssetUtils.shield,
                                title: S.of(context).saveEarningsDigitally),
                            SizedBox(
                              height: 24,
                            ),
                            InformationText(
                                image: AssetUtils.sendMoney,
                                title:
                                    S.of(context).sendMoneyToFriendAndFamily),
                            SizedBox(
                              height: 81,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, RoutePaths.Registration);
                              },
                              child: Container(
                                padding: EdgeInsets.all(18),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              AppColor.black.withOpacity(0.16),
                                          blurRadius: 12,
                                          spreadRadius: -4,
                                          offset: Offset(0, 12)),
                                    ],
                                    gradient: LinearGradient(
                                        colors: [
                                          AppColor.light_blue1,
                                          AppColor.soft_red
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft)),
                                child: Center(
                                  child: Text(S.of(context).openAccountNow,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    RoutePaths.OnBoarding,
                    ModalRoute.withName(RoutePaths.Splash));
              },
              child: Text(
                S.of(context).logoutAndContinueLater,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColor.vivid_orange),
              ),
            ),
          )
        ],
      ),
    );
  }
}
