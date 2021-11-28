import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_detail/card_detail_page.dart';
import 'package:neo_bank/feature/dashboard_home/get_card/get_card_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  List pages = [
    MyAccountPage(),
    CardDetailPage(),
    GetCardPage(),
    MyDebitCardPage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 85),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 1,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).totalBalance,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: AppColor.black),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("0.00",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColorDark)),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Text("JOD",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: AppColor.verLightGray4)),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 18.0),
                child: AppSvg.asset(AssetUtils.swipeDown),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppSwiper(
                      pages: pages,
                      pageController: model.pageController,
                      onIndexChanged: (index) {
                        model.updatePage(index);
                      },
                      currentStep: currentStep,
                    ),
                    Visibility(
                      visible: currentStep == 0,
                      child: Positioned(
                        top: 445,
                        child: Column(
                          children: [
                            AppSvg.asset(AssetUtils.swipeUp),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                "Swipe up to view transactions",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.whiteGray),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
