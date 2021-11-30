import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  List pages = [
    MyAccountPage(),
    GetCreditCardPage(),
    MyDebitCardPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 85, bottom: 47),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 1,
        dataBuilder: (context, currentStep) {
          return GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.primaryVelocity!.isNegative) {
                if (currentStep == 0) {
                  ProviderScope.containerOf(context)
                      .read(homeViewModelProvider)
                      .homeController
                      .nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                } else if (currentStep == 1) {
                  ProviderScope.containerOf(context)
                      .read(homeViewModelProvider)
                      .homeController
                      .animateTo(2,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                }
              } else {
                print("hello world");
                if (currentStep == 2) {
                  print("2");
                  ProviderScope.containerOf(context)
                      .read(homeViewModelProvider)
                      .homeController
                      .jumpToPage(0);
                } else if (currentStep == 1) {
                  print("1");
                  ProviderScope.containerOf(context)
                      .read(homeViewModelProvider)
                      .homeController
                      .jumpToPage(1);
                }
              }
            },
            child: Column(
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
                  child: AppSwiper(
                    pages: pages,
                    pageController: model.pageController,
                    onIndexChanged: (index) {
                      model.updatePage(index);
                    },
                    currentStep: currentStep,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: 47),
                //   child: DotsIndicator(
                //     dotsCount: pages.length,
                //     position: currentStep!.toDouble(),
                //     decorator: DotsDecorator(
                //       color: Theme.of(context).primaryColorDark,
                //       activeColor: Theme.of(context).canvasColor
                //     ),
                //   ),
                // )
              ],
            ),
          );
        },
      ),
    );
  }
}
