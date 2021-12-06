import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/dashboard_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          return AppStreamBuilder<bool>(
            stream: model.showTimeLineStream,
            initialData: false,
            dataBuilder: (context, showTimeLine) {
              return GestureDetector(
                onVerticalDragEnd: (details) {
                  if (details.primaryVelocity!.isNegative) {
                    print("got current step ${currentStep}");
                    if (currentStep == 0) {
                      ProviderScope.containerOf(context)
                          .read(homeViewModelProvider)
                          .homeController
                          .jumpToPage(2);
                    } else if (currentStep == 1) {
                      print("in here");
                      if (showTimeLine!) {
                      } else {
                        ProviderScope.containerOf(context)
                            .read(homeViewModelProvider)
                            .homeController
                            .jumpToPage(3);
                      }
                    } else if (currentStep == 2) {
                      model.updateShowTimeLineStream(!showTimeLine!);
                    }
                  } else {
                    if (currentStep == 1 || currentStep == 2) {
                      print("swiped here");
                      print("show timeline $showTimeLine");
                      model.updateShowTimeLineStream(!showTimeLine!);
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("0.00",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).primaryColorDark)),
                          Padding(
                            padding: EdgeInsets.only(top: 5, left: 5.0),
                            child: Text("JOD",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppColor.verLightGray4)),
                          )
                        ],
                      ),
                    ),
                    showTimeLine == false
                        ? Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 18),
                                  child: AppSvg.asset(AssetUtils.swipeDown),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 4),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        DashboardSwiper(
                                          pages: pages,
                                          pageController: model.pageController,
                                          onIndexChanged: (index) {
                                            model.updatePage(index);
                                            model.updatePageControllerStream(
                                                index);
                                          },
                                          currentStep: currentStep,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SmoothPageIndicator(
                                    controller: model.controller,
                                    count: pages.length,
                                    effect: ScrollingDotsEffect(
                                      activeStrokeWidth: 2.6,
                                      activeDotScale: 1.3,
                                      activeDotColor:
                                          Theme.of(context).primaryColorDark,
                                      dotColor: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.6),
                                      maxVisibleDots: 5,
                                      radius: 8,
                                      spacing: 10,
                                      dotHeight: 10,
                                      dotWidth: 10,
                                    )),
                                // DotsIndicator(
                                //   dotsCount: pages.length,
                                //   position: currentStep!.toDouble(),
                                //   decorator: DotsDecorator(
                                //       color: Theme.of(context)
                                //           .primaryColorDark
                                //           .withOpacity(0.6),
                                //       activeColor:
                                //           Theme.of(context).primaryColorDark,
                                //       size: Size(8, 8),
                                //       activeSize: Size(10, 10)),
                                // )
                              ],
                            ),
                          )
                        : Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 24),
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .accentTextTheme
                                              .bodyText1!
                                              .color,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 17),
                                        child: Text(
                                          S.of(context).addMoney,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, right: 37),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 18),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    S.of(context).cardDelivered,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 5),
                                                    child: InkWell(
                                                      onTap: () {
                                                        if (currentStep == 1) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          CreditCardDeliveredPage()));
                                                        } else {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          DebitCardDeliveredPage()));
                                                        }
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 11,
                                                                vertical: 2),
                                                        decoration: BoxDecoration(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            border: Border.all(
                                                                color: Theme.of(
                                                                        context)
                                                                    .accentTextTheme
                                                                    .bodyText1!
                                                                    .color!)),
                                                        child: Text(
                                                          S.of(context).confirm,
                                                          style: TextStyle(
                                                              color: Theme.of(
                                                                      context)
                                                                  .accentTextTheme
                                                                  .bodyText1!
                                                                  .color,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 170),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      currentStep == 1
                                                          ? S
                                                              .of(context)
                                                              .debitCardDelivered
                                                          : S
                                                              .of(context)
                                                              .joinedBlink,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "4 Jan",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 56, top: 22),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // Image.asset(AssetUtils.progress1),
                                                // Image.asset(AssetUtils.progress2a),
                                                // Image.asset(AssetUtils.progress1),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15.0),
                                                      child: Image.asset(
                                                          AssetUtils.progress2),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: -10,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Stack(
                                                  children: [
                                                    Image.asset(
                                                        AssetUtils.progress1),
                                                    Positioned(
                                                      bottom: 0,
                                                      left: -10,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: -10,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Stack(
                                                  children: [
                                                    Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 15),
                                                        child: Image.asset(
                                                            AssetUtils
                                                                .progress2)),
                                                    Positioned(
                                                      top: 0,
                                                      left: -10,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: AppColor
                                                                    .darkGrey,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 19, left: 160),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    currentStep != 1
                                                        ? S
                                                            .of(context)
                                                            .debitCardActivated
                                                        : S
                                                            .of(context)
                                                            .creditCardActivated,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.only(top: 4),
                                                    child: Text(
                                                      "4 Jan",
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color,
                                                          fontSize: 12),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 180),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      S.of(context).blinkBorn,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 4),
                                                      child: Text(
                                                        "1 Jan",
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .inputDecorationTheme
                                                                .hintStyle!
                                                                .color,
                                                            fontSize: 12),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 48),
                                  child: Container(
                                    height: 93,
                                    width: 280,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 31,
                                          right: 26,
                                          bottom: 31,
                                          left: 19),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.asset(
                                            AssetUtils.blink,
                                            width: 60,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentTextTheme
                                                    .bodyText1!
                                                    .color,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 15),
                                              child: Text(
                                                S.of(context).getCardNow,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
