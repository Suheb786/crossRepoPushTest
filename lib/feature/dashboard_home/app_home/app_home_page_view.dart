import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/ui/molecules/pager/dashboard_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUps(model, context);
    return Padding(
      padding: EdgeInsets.only(
          top: model.deviceSize.height <
                      ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
                  model.deviceSize.height <
                      ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT
              ? 48
              : 70),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 1,
        dataBuilder: (context, currentStep) {
          return AppStreamBuilder<Resource<GetDashboardDataResponse>>(
              stream: model.getDashboardDataStream,
              initialData: Resource.none(),
              dataBuilder: (context, cardData) {
                return AppStreamBuilder<bool>(
                  stream: model.showTimeLineStream,
                  initialData: false,
                  dataBuilder: (context, showTimeLine) {
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onHorizontalDragEnd: (details) {},
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity!.isNegative) {
                          if (model.cardTypeList[currentStep!].cardType ==
                              CardType.ACCOUNT) {
                            Navigator.pushNamed(
                                context, RoutePaths.AccountTransaction);
                          } else if (model.cardTypeList[currentStep].cardType ==
                                  CardType.CREDIT &&
                              model.cardTypeList[currentStep].swipeUpEnum ==
                                  SwipeUpEnum.SWIPE_UP_YES) {
                            Navigator.pushNamed(
                                context, RoutePaths.CardTransaction,
                                arguments: GetCreditCardTransactionArguments(
                                    cardId: model
                                        .timeLineListArguments[currentStep - 1]
                                        .cardId));
                          }
                          // print("SWIPE UP");
                          // if (currentStep == 1) {
                          //   if (showTimeLine!) {
                          //     print("dragged here");
                          //     Navigator.pushNamed(
                          //         context, RoutePaths.TimeLinePage,
                          //         arguments: TimeLinePageArguments(
                          //             timeLineArguments:
                          //                 model.timeLineArguments));
                          //     //model.updateShowTimeLineStream(!showTimeLine);
                          //     return;
                          //   } else {
                          //     cardData!.data!.dashboardDataContent!.creditCard!
                          //                 .length >
                          //             0
                          //         ? Navigator.pushNamed(
                          //             context, RoutePaths.CardTransaction,
                          //             arguments:
                          //                 GetCreditCardTransactionArguments(
                          //                     cardId: cardData
                          //                         .data!
                          //                         .dashboardDataContent!
                          //                         .creditCard!
                          //                         .first
                          //                         .cardId))
                          //         : () {};
                          //   }
                          // } else if (currentStep == 0) {
                          //   if (showTimeLine!) {
                          //     print("dragged here");
                          //     Navigator.pushNamed(
                          //         context, RoutePaths.TimeLinePage,
                          //         arguments: TimeLinePageArguments(
                          //             timeLineArguments:
                          //                 model.timeLineArguments));
                          //     //model.updateShowTimeLineStream(!showTimeLine);
                          //     return;
                          //   } else {
                          //     Navigator.pushNamed(
                          //         context, RoutePaths.AccountTransaction);
                          //   }
                          // } else if (currentStep == 1) {
                          //   if (showTimeLine!) {
                          //     Navigator.pushNamed(
                          //         context, RoutePaths.TimeLinePage,
                          //         arguments: TimeLinePageArguments(
                          //             timeLineArguments:
                          //                 model.timeLineArguments));
                          //     //model.updateShowTimeLineStream(!showTimeLine);
                          //   }
                          // } else if (currentStep == 2) {
                          //   Navigator.pushNamed(
                          //       context, RoutePaths.TimeLinePage,
                          //       arguments: TimeLinePageArguments(
                          //           timeLineArguments:
                          //               model.timeLineArguments));
                          //   //model.updateShowTimeLineStream(!showTimeLine!);
                          // }
                          // // model.updateAppSwipeControllerStream(currentStep!);
                        } else {
                          if (details.primaryVelocity! > 0.5) {
                            if (!showTimeLine!) {
                              Navigator.pushNamed(
                                  context, RoutePaths.TimeLinePage,
                                  arguments: TimeLinePageArguments(
                                      cardType: model
                                          .cardTypeList[currentStep!].cardType,
                                      timeLineArguments:
                                          model.timeLineArguments));
                              //model.updateShowTimeLineStream(!showTimeLine);
                            }
                          }
                        }
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                                Text(
                                    cardData!.data!.dashboardDataContent!
                                        .account!.availableBalance!,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: Theme.of(context)
                                            .primaryColorDark)),
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
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(top: 18),
                                          child: LottieBuilder.asset(
                                            'assets/animation/Swipe_Down.json',
                                            width: 28.0,
                                            height: 28.0,
                                          )

                                          // child:
                                          //     AppSvg.asset(AssetUtils.swipeDown),
                                          ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 4),
                                          child: AppStreamBuilder<List>(
                                              stream: model.pageStream,
                                              initialData: [Container()],
                                              dataBuilder:
                                                  (context, pagesList) {
                                                return AppStreamBuilder<
                                                        GetDashboardDataContent>(
                                                    stream: ProviderScope
                                                            .containerOf(
                                                                context)
                                                        .read(
                                                            appHomeViewModelProvider)
                                                        .getDashboardCardDataStream,
                                                    initialData:
                                                        GetDashboardDataContent(),
                                                    dataBuilder:
                                                        (context, cardData) {
                                                      if (cardData!.account!
                                                              .accountNo ==
                                                          null) {
                                                        return SizedBox();
                                                      }
                                                      return DashboardSwiper(
                                                        pages: pagesList,
                                                        appSwiperController: model
                                                            .appSwiperController,
                                                        pageController: model
                                                            .pageController,
                                                        onIndexChanged:
                                                            (index) {
                                                          // _currentPage = index;
                                                          model.updatePage(
                                                              index);
                                                          model
                                                              .updatePageControllerStream(
                                                                  index);
                                                          model
                                                              .updateAppSwipeControllerStream(
                                                                  index);
                                                        },
                                                        currentStep:
                                                            currentStep,
                                                      );
                                                    });
                                              }),
                                        ),
                                      ),
                                      const SizedBox(height: 0.0),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.03,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: model.buildPageIndicator(
                                              currentStep!,
                                              cardData
                                                          .data!
                                                          .dashboardDataContent!
                                                          .debitCard!
                                                          .length >
                                                      0
                                                  ? 3
                                                  : 2),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 35, bottom: 24),
                                          child: ConvexAppBar(
                                            elevation: 0,
                                            style: TabStyle.fixedCircle,
                                            backgroundColor:
                                                Theme.of(context).accentColor,
                                            items: [
                                              TabItem(
                                                  icon: AppSvg.asset(
                                                      AssetUtils.house),
                                                  title: " "),
                                              TabItem(
                                                icon: Container(
                                                  height: 120,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                      shape: BoxShape.circle),
                                                  child: Center(
                                                    child: AppSvg.asset(
                                                        AssetUtils.logoWhite),
                                                  ),
                                                ),
                                              ),
                                              TabItem(
                                                  icon: Container(
                                                      child: AppSvg.asset(
                                                          AssetUtils
                                                              .headphoneBlack)),
                                                  title: " "),
                                            ],
                                            initialActiveIndex: 1,
                                            onTap: (i) {
                                              switch (i) {
                                                case 0:
                                                  model.moveToPage(0);
                                                  break;
                                                case 1:
                                                  SettingsDialog.show(
                                                    context,
                                                  );
                                                  break;
                                                case 2:
                                                  EngagementTeamDialog.show(
                                                      context, onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                  });
                                                  break;
                                              }
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: 24),
                                        child: Center(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutePaths
                                                      .AddMoneyOptionSelector);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 104,
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .accentTextTheme
                                                      .bodyText1!
                                                      .color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Center(
                                                child: Text(
                                                  S.of(context).addMoney,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .accentColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, right: 37),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 18),
                                                child: Row(
                                                  children: [
                                                    Visibility(
                                                      visible: cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .creditCard!
                                                                  .length >
                                                              0 &&
                                                          (cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .creditCard!
                                                                  .first
                                                                  .isCompleted ??
                                                              false),
                                                      child: (cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .creditCard!
                                                                      .length >
                                                                  0
                                                              ? (cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .creditCard!
                                                                          .first
                                                                          .isCreditDelivered !=
                                                                      null &&
                                                                  cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .creditCard!
                                                                      .first
                                                                      .isCreditDelivered!)
                                                              : false)
                                                          // : (cardData
                                                          //         .data!
                                                          //         .dashboardDataContent!
                                                          //         .debitCard!
                                                          //         .isNotEmpty &&
                                                          //     cardData
                                                          //             .data!
                                                          //             .dashboardDataContent!
                                                          //             .debitCard!
                                                          //             .first
                                                          //             .isDebitDelivered !=
                                                          //         null &&
                                                          //     cardData
                                                          //         .data!
                                                          //         .dashboardDataContent!
                                                          //         .debitCard!
                                                          //         .first
                                                          //         .isDebitDelivered!)
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .creditCardDelivered,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: Text(
                                                                    (cardData.data!.dashboardDataContent!.creditCard!.length >
                                                                                0
                                                                            ? cardData.data!.dashboardDataContent!.creditCard!.first.creditDeliveredDatetime !=
                                                                                null
                                                                            : false)
                                                                        ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                            .data!
                                                                            .dashboardDataContent!
                                                                            .creditCard!
                                                                            .first
                                                                            .creditDeliveredDatetime!
                                                                            .toString())
                                                                        : '-',
                                                                    // : (cardData.data!.dashboardDataContent!.debitCard!.length > 0 &&
                                                                    //         cardData.data!.dashboardDataContent!.debitCard![0].debitDeliveredDatetime !=
                                                                    //             null &&
                                                                    //         cardData.data!.dashboardDataContent!.debitCard![0].debitDeliveredDatetime
                                                                    //             .toString()
                                                                    //             .isNotEmpty)
                                                                    //     ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                    //         .data!
                                                                    //         .dashboardDataContent!
                                                                    //         .debitCard![0]
                                                                    //         .debitDeliveredDatetime!
                                                                    //         .toString())
                                                                    //     : '-',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Theme.of(context)
                                                                            .inputDecorationTheme
                                                                            .hintStyle!
                                                                            .color,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : Column(
                                                              children: [
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .creditCardDelivered,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child:
                                                                      InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      // if (currentStep ==
                                                                      //     1) {
                                                                      //   var result = await Navigator.push(
                                                                      //       context,
                                                                      //       MaterialPageRoute(
                                                                      //           builder: (context) => CreditCardDeliveredPage(
                                                                      //                 creditCard: cardData.data!.dashboardDataContent!.creditCard!,
                                                                      //               )));
                                                                      //   if (result !=
                                                                      //       null) {
                                                                      //     print(
                                                                      //         '$result');
                                                                      //     model
                                                                      //         .getDashboardData();
                                                                      //   }
                                                                      // } else {
                                                                      //   var result = await Navigator.push(
                                                                      //       context,
                                                                      //       MaterialPageRoute(
                                                                      //           builder: (context) => DebitCardDeliveredPage(
                                                                      //                 debitCard: cardData.data!.dashboardDataContent!.debitCard!.first,
                                                                      //               )));
                                                                      //   if (result !=
                                                                      //       null) {
                                                                      //     print(
                                                                      //         '$result');
                                                                      //     model
                                                                      //         .getDashboardData();
                                                                      //   }
                                                                      // }
                                                                      var result = await Navigator.push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                              builder: (context) => CreditCardDeliveredPage(
                                                                                    creditCard: TimeLineListArguments(),
                                                                                    //creditCard: cardData.data!.dashboardDataContent!.creditCard!.first,
                                                                                  )));
                                                                      if (result !=
                                                                          null) {
                                                                        print(
                                                                            '$result');
                                                                        model
                                                                            .getDashboardData();
                                                                      }
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              11,
                                                                          vertical:
                                                                              2),
                                                                      decoration: BoxDecoration(
                                                                          color: Theme.of(context)
                                                                              .accentColor,
                                                                          borderRadius: BorderRadius.circular(
                                                                              14),
                                                                          border:
                                                                              Border.all(color: Theme.of(context).accentTextTheme.bodyText1!.color!)),
                                                                      child:
                                                                          Text(
                                                                        S
                                                                            .of(context)
                                                                            .confirm,
                                                                        style: TextStyle(
                                                                            color: Theme.of(context)
                                                                                .accentTextTheme
                                                                                .bodyText1!
                                                                                .color,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: (cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .creditCard!
                                                                          .length >
                                                                      0 &&
                                                                  (cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .creditCard!
                                                                          .first
                                                                          .isCompleted ??
                                                                      false))
                                                              ? 170
                                                              : 0),
                                                      child: (cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .debitCard!
                                                                  .isNotEmpty &&
                                                              cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .debitCard!
                                                                      .first
                                                                      .isDebitDelivered !=
                                                                  null &&
                                                              cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .debitCard!
                                                                  .first
                                                                  .isDebitDelivered!)
                                                          ? Column(
                                                              children: [
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .debitCardDelivered,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: Text(
                                                                    // (cardData.data!.dashboardDataContent!.creditCard!.length > 0
                                                                    //     ? cardData.data!.dashboardDataContent!.creditCard!.first.creditDeliveredDatetime !=
                                                                    //     null
                                                                    //     : false)
                                                                    //     ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                    //     .data!
                                                                    //     .dashboardDataContent!
                                                                    //     .creditCard!
                                                                    //     .first
                                                                    //     .creditDeliveredDatetime!
                                                                    //     .toString())
                                                                    //     : '-',
                                                                    //:
                                                                    (cardData.data!.dashboardDataContent!.debitCard!.length > 0 &&
                                                                            cardData.data!.dashboardDataContent!.debitCard![0].debitDeliveredDatetime !=
                                                                                null &&
                                                                            cardData.data!.dashboardDataContent!.debitCard![0].debitDeliveredDatetime
                                                                                .toString()
                                                                                .isNotEmpty)
                                                                        ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                            .data!
                                                                            .dashboardDataContent!
                                                                            .debitCard![0]
                                                                            .debitDeliveredDatetime!
                                                                            .toString())
                                                                        : '-',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12,
                                                                        color: Theme.of(context)
                                                                            .inputDecorationTheme
                                                                            .hintStyle!
                                                                            .color,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          : Column(
                                                              children: [
                                                                Text(
                                                                  S
                                                                      .of(context)
                                                                      .debitCardDelivered,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: cardData
                                                                              .data!
                                                                              .dashboardDataContent!
                                                                              .debitCard!
                                                                              .length >
                                                                          0
                                                                      ? InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            // if (currentStep ==
                                                                            //     1) {
                                                                            //   var result = await Navigator.push(
                                                                            //       context,
                                                                            //       MaterialPageRoute(
                                                                            //           builder: (context) => CreditCardDeliveredPage(
                                                                            //                 creditCard: cardData.data!.dashboardDataContent!.creditCard!,
                                                                            //               )));
                                                                            //   if (result !=
                                                                            //       null) {
                                                                            //     print(
                                                                            //         '$result');
                                                                            //     model
                                                                            //         .getDashboardData();
                                                                            //   }
                                                                            // } else {
                                                                            //   var result = await Navigator.push(
                                                                            //       context,
                                                                            //       MaterialPageRoute(
                                                                            //           builder: (context) => DebitCardDeliveredPage(
                                                                            //                 debitCard: cardData.data!.dashboardDataContent!.debitCard!.first,
                                                                            //               )));
                                                                            //   if (result !=
                                                                            //       null) {
                                                                            //     print(
                                                                            //         '$result');
                                                                            //     model
                                                                            //         .getDashboardData();
                                                                            //   }
                                                                            // }
                                                                            var result = await Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                    builder: (context) => DebitCardDeliveredPage(debitCard: TimeLineListArguments() //cardData.data!.dashboardDataContent!.debitCard!.first,
                                                                                        )));
                                                                            if (result !=
                                                                                null) {
                                                                              print('$result');
                                                                              model.getDashboardData();
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 11, vertical: 2),
                                                                            decoration: BoxDecoration(
                                                                                color: Theme.of(context).accentColor,
                                                                                borderRadius: BorderRadius.circular(14),
                                                                                border: Border.all(color: Theme.of(context).accentTextTheme.bodyText1!.color!)),
                                                                            child:
                                                                                Text(
                                                                              S.of(context).confirm,
                                                                              style: TextStyle(color: Theme.of(context).accentTextTheme.bodyText1!.color, fontSize: 14, fontWeight: FontWeight.w600),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Text(
                                                                          '-'),
                                                                )
                                                              ],
                                                            ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 180),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            // currentStep == 1
                                                            //     ? S
                                                            //         .of(context)
                                                            //         .debitCardDelivered
                                                            //     :
                                                            S
                                                                .of(context)
                                                                .joinedBlink,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Text(
                                                              cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .youJoinedBlink !=
                                                                      null
                                                                  ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .youJoinedBlink!
                                                                      .toString())
                                                                  : '-',
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
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      // Image.asset(AssetUtils.progress1),
                                                      // Image.asset(AssetUtils.progress2a),
                                                      // Image.asset(AssetUtils.progress1),
                                                      Visibility(
                                                        visible: cardData
                                                                    .data!
                                                                    .dashboardDataContent!
                                                                    .creditCard!
                                                                    .length >
                                                                0 &&
                                                            (cardData
                                                                    .data!
                                                                    .dashboardDataContent!
                                                                    .creditCard!
                                                                    .first
                                                                    .isCompleted ??
                                                                false),
                                                        child: Stack(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left:
                                                                          15.0),
                                                              child: Image.asset(
                                                                  AssetUtils
                                                                      .progress2),
                                                            ),
                                                            Positioned(
                                                              bottom: 0,
                                                              right: -10,
                                                              child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .vividYellow,
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
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .vivid_red,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Visibility(
                                                        visible: cardData
                                                                    .data!
                                                                    .dashboardDataContent!
                                                                    .creditCard!
                                                                    .length >
                                                                0 &&
                                                            (cardData
                                                                    .data!
                                                                    .dashboardDataContent!
                                                                    .creditCard!
                                                                    .first
                                                                    .isCompleted ??
                                                                false),
                                                        child: Stack(
                                                          children: [
                                                            Image.asset(
                                                                AssetUtils
                                                                    .progress1),
                                                            Positioned(
                                                              bottom: 0,
                                                              left: -10,
                                                              child: Container(
                                                                height: 20,
                                                                width: 20,
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .vividYellow,
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
                                                                decoration: BoxDecoration(
                                                                    color: AppColor
                                                                        .vividYellow,
                                                                    shape: BoxShape
                                                                        .circle),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(
                                                                right: 0.0,
                                                                left: (cardData.data!.dashboardDataContent!.creditCard!.length >
                                                                            0 &&
                                                                        (cardData.data!.dashboardDataContent!.creditCard!.first.isCompleted ??
                                                                            false))
                                                                    ? 0
                                                                    : 10),
                                                            child: Image.asset(
                                                                AssetUtils
                                                                    .progress2),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            right: -10,
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: 0,
                                                            left: (cardData
                                                                            .data!
                                                                            .dashboardDataContent!
                                                                            .creditCard!
                                                                            .length >
                                                                        0 &&
                                                                    (cardData
                                                                            .data!
                                                                            .dashboardDataContent!
                                                                            .creditCard!
                                                                            .first
                                                                            .isCompleted ??
                                                                        false))
                                                                ? -10
                                                                : 0,
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Image.asset(AssetUtils
                                                              .progress1),
                                                          Positioned(
                                                            bottom: 0,
                                                            left: -10,
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
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
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          15),
                                                              child: Image.asset(
                                                                  AssetUtils
                                                                      .progress2)),
                                                          Positioned(
                                                            top: 0,
                                                            left: -10,
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
                                                                  shape: BoxShape
                                                                      .circle),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            bottom: 0,
                                                            right: 5,
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration: BoxDecoration(
                                                                  color: AppColor
                                                                      .vividYellow,
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
                                                    Visibility(
                                                      visible: (cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .creditCard!
                                                                  .length >
                                                              0 &&
                                                          (cardData
                                                                  .data!
                                                                  .dashboardDataContent!
                                                                  .creditCard!
                                                                  .first
                                                                  .isCompleted ??
                                                              false)),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .creditCardActivated,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Text(
                                                              // currentStep != 1 ?
                                                              // cardData
                                                              //                 .data!
                                                              //                 .dashboardDataContent!
                                                              //                 .debitCard!
                                                              //                 .first
                                                              //                 .debitCardActivated !=
                                                              //             null
                                                              //         ? TimeUtils.getFormattedDateForTransaction(cardData
                                                              //             .data!
                                                              //             .dashboardDataContent!
                                                              //             .debitCard!
                                                              //             .first
                                                              //             .debitCardActivated!
                                                              //             .toString())
                                                              //         : '-'
                                                              //     :
                                                              (cardData.data!.dashboardDataContent!.creditCard!
                                                                              .length >
                                                                          0
                                                                      ? cardData
                                                                              .data!
                                                                              .dashboardDataContent!
                                                                              .creditCard!
                                                                              .first
                                                                              .creditCardActivatedDate !=
                                                                          null
                                                                      : false)
                                                                  ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .creditCard!
                                                                      .first
                                                                      .creditCardActivatedDate!
                                                                      .toString())
                                                                  : '-',
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
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: (cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .creditCard!
                                                                          .length >
                                                                      0 &&
                                                                  (cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .creditCard!
                                                                          .first
                                                                          .isCompleted ??
                                                                      false))
                                                              ? 180
                                                              : 0),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .debitCardActivated,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Text(
                                                              // currentStep != 1 ?
                                                              (cardData.data!.dashboardDataContent!
                                                                              .debitCard !=
                                                                          null &&
                                                                      cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .debitCard!
                                                                          .isNotEmpty &&
                                                                      cardData
                                                                              .data!
                                                                              .dashboardDataContent!
                                                                              .debitCard!
                                                                              .first
                                                                              .debitCardActivated !=
                                                                          null)
                                                                  ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .debitCard!
                                                                      .first
                                                                      .debitCardActivated!
                                                                      .toString())
                                                                  : '-',
                                                              //     :
                                                              // (cardData.data!.dashboardDataContent!.creditCard!.length >
                                                              //     0
                                                              //     ? cardData.data!.dashboardDataContent!.creditCard!.first.creditCardActivatedDate !=
                                                              //     null
                                                              //     : false)
                                                              //     ? TimeUtils.getFormattedDateForTransaction(cardData
                                                              //     .data!
                                                              //     .dashboardDataContent!
                                                              //     .creditCard!
                                                              //     .first
                                                              //     .creditCardActivatedDate!
                                                              //     .toString())
                                                              //     : '-',
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
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 180),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            S
                                                                .of(context)
                                                                .blinkBorn,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 12),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Text(
                                                              cardData
                                                                          .data!
                                                                          .dashboardDataContent!
                                                                          .blinkWasBorn !=
                                                                      null
                                                                  ? TimeUtils.getFormattedDateForTransaction(cardData
                                                                      .data!
                                                                      .dashboardDataContent!
                                                                      .blinkWasBorn!
                                                                      .toString())
                                                                  : '-',
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
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              // color: Theme.of(context)
                                              //     .primaryColor,
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      AssetUtils.credit),
                                                  fit: BoxFit.contain),
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          // child: Padding(
                                          //   padding: EdgeInsets.only(
                                          //       top: 31,
                                          //       right: 26,
                                          //       bottom: 31,
                                          //       left: 19),
                                          //   child: Row(
                                          //     children: [
                                          //       Image.asset(
                                          //         AssetUtils.blink,
                                          //         width: 50,
                                          //       ),
                                          //       Expanded(child: Container()),
                                          //       InkWell(
                                          //         onTap: () {
                                          //           Navigator.pushNamed(
                                          //               context,
                                          //               RoutePaths
                                          //                   .BlinkCreditCard);
                                          //         },
                                          //         child: Container(
                                          //           decoration: BoxDecoration(
                                          //               color: Theme.of(context)
                                          //                   .accentTextTheme
                                          //                   .bodyText1!
                                          //                   .color,
                                          //               borderRadius:
                                          //               BorderRadius
                                          //                   .circular(20)),
                                          //           child: Padding(
                                          //             padding:
                                          //             EdgeInsets.symmetric(
                                          //                 vertical: 8,
                                          //                 horizontal: 15),
                                          //             child: Text(
                                          //               S
                                          //                   .of(context)
                                          //                   .getCardNow,
                                          //               style: TextStyle(
                                          //                   fontWeight:
                                          //                   FontWeight.w600,
                                          //                   fontSize: 14,
                                          //                   color: Theme.of(
                                          //                       context)
                                          //                       .accentColor),
                                          //             ),
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     ],
                                          //   ),
                                          // ),
                                        ),
                                      ),
                                      Spacer(),
                                      Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 281,
                                              height: 100,
                                              margin: EdgeInsets.only(top: 8),
                                              decoration: BoxDecoration(
                                                  color: currentStep == 1 ||
                                                          currentStep == 3
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : currentStep == 2
                                                          ? Theme.of(context)
                                                              .canvasColor
                                                          : Theme.of(context)
                                                              .primaryColorDark,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  16),
                                                          topRight:
                                                              Radius.circular(
                                                                  16))),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 22, left: 27),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    currentStep == 1 ||
                                                            currentStep == 0
                                                        ? AppSvg.asset(
                                                            AssetUtils
                                                                .blink_updated_logo,
                                                            height: 34,
                                                            width: 72)
                                                        : AppSvg.asset(
                                                            AssetUtils
                                                                .blinkBlack,
                                                            height: 34,
                                                            width: 72),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                              child: AppSvg.asset(
                                                  AssetUtils.swipeUp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }

  void listenPopUps(AppHomeViewModel model, BuildContext context) {
    model.getSentMoneyPopUpDataStream.listen((data) {
      if (data) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => popUpWidget(context, AssetUtils.sentOffer));
      }
    });

    model.getRequestMoneyPopUpDataStream.listen((data) {
      if (data) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                popUpWidget(context, AssetUtils.requestedOffer));
      }
    });
  }

  Widget popUpWidget(BuildContext context, String image) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              height: 530,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white,
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColor.brightBlue,
                  )),
            )
          ],
        ));
  }
}
