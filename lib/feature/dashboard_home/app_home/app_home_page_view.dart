import 'dart:io';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/add_other_card_to_apple_wallet_page_dialog/add_other_card_to_apple_wallet_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/apple_pay_landing_page_dialog/apple_pay_landing_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/efawateer_landing_page_dialog/efawateer_landing_page_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_dashbord_dialog/rj_dashboard_dialog.dart';
import 'package:neo_bank/ui/molecules/pager/dashboard_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUps(model, context);
    return Padding(
      padding: EdgeInsets.only(top: 70.0.h),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 1,
        dataBuilder: (context, currentStep) {
          return AppStreamBuilder<Resource<VerifyQrResponse>>(
              stream: model.verifyQRStream,
              onData: (data) {
                if (data.status == Status.SUCCESS) {
                  Navigator.pushNamed(context, RoutePaths.SendMoneyQrScanning,
                      arguments: SendMoneyQRScanningArguments(
                          source: 'Link',
                          requestId: data.data?.qrContent?.requestId ?? '',
                          amount: data.data?.qrContent?.amount ?? '',
                          accountHolderName: data.data?.qrContent?.accountHolderName ?? '',
                          accountNo: data.data?.qrContent?.toAccount ?? ''));
                }
              },
              initialData: Resource.none(),
              dataBuilder: (context, qrData) {
                return AppStreamBuilder<Resource<User>>(
                    stream: model.currentUser,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        if (!(data.data?.isRJPopUPClicked ?? false) &&
                            (model.dashboardDataContent.dashboardFeatures?.isRJFeatureEnabled ?? true)) {
                          RjDialog.show(context,
                              image: AssetUtils.flight,
                              title: S.of(context).bookFligtWithUs, onDismissed: () {
                            Navigator.pop(context);
                            data.data?.isRJPopUPClicked = true;
                            model.saveCurrentUserData(user: data.data!);
                          },
                              descriptionWidget: Text(
                                S.of(context).bookFligtWithUsDescrption,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.veryDarkGray2,
                                    fontSize: 14),
                              ));
                        }
                        if (!(data.data?.isEfawateerPopUPClicked ?? false) &&
                            (model.dashboardDataContent.dashboardFeatures?.blinkRetailAppBillPayment ??
                                true)) {
                          EfawateerLandingDialog.show(context,
                              title: S.current.payYourBillswithBlink,
                              descriptionWidget: Text(S.current.youCanPayAllYourBillsNow),
                              isSwipeToCancel: true,
                              onDismissed: () {
                                Navigator.pop(context);
                                data.data?.isEfawateerPopUPClicked = true;
                                model.saveCurrentUserData(user: data.data!);
                              },
                              image: AssetUtils.efawateerPopUpImage,
                              onSelected: () {
                                Navigator.pop(context);
                                data.data?.isEfawateerPopUPClicked = true;
                                model.saveCurrentUserData(user: data.data!);
                                // SettingsDialog.show(context);
                                Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                    arguments: NavigationType.PAYMENTS);
                              });
                        }
                      }
                    },
                    dataBuilder: (context, progress) {
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
                                      if (model.cardTypeList[currentStep!].cardType == CardType.ACCOUNT) {
                                        Navigator.pushNamed(context, RoutePaths.AccountTransaction);
                                      } else if (model.cardTypeList[currentStep].cardType ==
                                              CardType.CREDIT &&
                                          model.cardTypeList[currentStep].swipeUpEnum ==
                                              SwipeUpEnum.SWIPE_UP_YES) {
                                        Navigator.pushNamed(context, RoutePaths.CardTransaction,
                                            arguments: GetCreditCardTransactionArguments(
                                                cardId: model.timeLineListArguments[currentStep - 1].cardId));
                                      }
                                    } else {
                                      if (details.primaryVelocity! > 0.5) {
                                        if (!showTimeLine!) {
                                          Navigator.pushNamed(context, RoutePaths.TimeLinePage,
                                              arguments: TimeLinePageArguments(
                                                  cardType: model.cardTypeList[currentStep!].cardType,
                                                  timeLineArguments: model.timeLineArguments));
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
                                            fontFamily: StringUtils.appFont,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18.0.t,
                                            color: AppColor.black),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                '${cardData!.data!.dashboardDataContent!.account!.availableBalance!} ',
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontSize: 24.0.t,
                                                    fontWeight: FontWeight.w700,
                                                    color: Theme.of(context).primaryColorDark)),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5.0.h, left: 5.0.w),
                                              child: Text(S.of(context).JOD,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontWeight: FontWeight.w700,
                                                      fontSize: 14.0.t,
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
                                                      padding: EdgeInsets.only(top: 18.0.h),
                                                      child: LottieBuilder.asset(
                                                        'assets/animation/Swipe_Down.json',
                                                        width: 28.0.w,
                                                        height: 28.0.h,
                                                      )),
                                                  Expanded(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 4.0.h),
                                                      child: AppStreamBuilder<List>(
                                                          stream: model.pageStream,
                                                          initialData: [Container()],
                                                          dataBuilder: (context, pagesList) {
                                                            return AppStreamBuilder<GetDashboardDataContent>(
                                                                stream: ProviderScope.containerOf(context)
                                                                    .read(appHomeViewModelProvider)
                                                                    .getDashboardCardDataStream,
                                                                initialData: GetDashboardDataContent(),
                                                                dataBuilder: (context, cardData) {
                                                                  if (cardData!.account!.accountNo == null) {
                                                                    return SizedBox();
                                                                  }
                                                                  return DashboardSwiper(
                                                                    pages: pagesList,
                                                                    appSwiperController:
                                                                        model.appSwiperController,
                                                                    pageController: model.pageController,
                                                                    onIndexChanged: (index) {
                                                                      model.updatePage(index);
                                                                      model.updatePageControllerStream(index);
                                                                    },
                                                                    currentStep: currentStep,
                                                                  );
                                                                });
                                                          }),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 0.0),
                                                  SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.03,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: model.buildPageIndicator(
                                                          currentStep!,
                                                          cardData
                                                              .data!.dashboardDataContent!.debitCard!.length),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 35.0.h, bottom: 0.0.h),
                                                      child: ConvexAppBar(
                                                        elevation: 0,
                                                        style: TabStyle.fixedCircle,
                                                        backgroundColor: Theme.of(context).accentColor,
                                                        items: [
                                                          TabItem(
                                                              icon: AppSvg.asset(AssetUtils.house),
                                                              title: " "),
                                                          TabItem(
                                                            icon: Container(
                                                              height: 80.0.h,
                                                              width: 80.0.w,
                                                              decoration: BoxDecoration(
                                                                  color: Theme.of(context).primaryColorDark,
                                                                  shape: BoxShape.circle),
                                                              child: Center(
                                                                child: AppSvg.asset(AssetUtils.logoWhite),
                                                              ),
                                                            ),
                                                          ),
                                                          TabItem(
                                                              icon: Container(
                                                                  child: AppSvg.asset(
                                                                      AssetUtils.headphoneBlack)),
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
                                                              EngagementTeamDialog.show(context,
                                                                  onDismissed: () {
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
                                                              context, RoutePaths.AddMoneyOptionSelector);
                                                        },
                                                        child: Container(
                                                          height: 40,
                                                          width: 104,
                                                          decoration: BoxDecoration(
                                                              color: Theme.of(context)
                                                                  .accentTextTheme
                                                                  .bodyText1!
                                                                  .color,
                                                              borderRadius: BorderRadius.circular(20)),
                                                          child: Center(
                                                            child: Text(
                                                              S.of(context).addMoney,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 14,
                                                                  color: Theme.of(context).accentColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 10, right: 37),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 18),
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
                                                                  child: (cardData.data!.dashboardDataContent!
                                                                                  .creditCard!.length >
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
                                                                      ? Column(
                                                                          children: [
                                                                            Text(
                                                                              S
                                                                                  .of(context)
                                                                                  .creditCardDelivered,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12),
                                                                            ),
                                                                            Padding(
                                                                              padding:
                                                                                  EdgeInsets.only(top: 5),
                                                                              child: Text(
                                                                                (cardData
                                                                                                .data!
                                                                                                .dashboardDataContent!
                                                                                                .creditCard!
                                                                                                .length >
                                                                                            0
                                                                                        ? cardData
                                                                                                .data!
                                                                                                .dashboardDataContent!
                                                                                                .creditCard!
                                                                                                .first
                                                                                                .creditDeliveredDatetime !=
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
                                                                                style: TextStyle(
                                                                                    fontFamily:
                                                                                        StringUtils.appFont,
                                                                                    fontSize: 12,
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
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12),
                                                                            ),
                                                                            Padding(
                                                                              padding:
                                                                                  EdgeInsets.only(top: 5),
                                                                              child: InkWell(
                                                                                onTap: () async {
                                                                                  var result =
                                                                                      await Navigator.push(
                                                                                          context,
                                                                                          MaterialPageRoute(
                                                                                              builder:
                                                                                                  (context) =>
                                                                                                      CreditCardDeliveredPage(
                                                                                                        creditCard:
                                                                                                            TimeLineListArguments(),
                                                                                                        //creditCard: cardData.data!.dashboardDataContent!.creditCard!.first,
                                                                                                      )));
                                                                                  if (result != null) {
                                                                                    print('$result');
                                                                                    model.getDashboardData();
                                                                                  }
                                                                                },
                                                                                child: Container(
                                                                                  padding:
                                                                                      EdgeInsets.symmetric(
                                                                                          horizontal: 11,
                                                                                          vertical: 2),
                                                                                  decoration: BoxDecoration(
                                                                                      color: Theme.of(context)
                                                                                          .accentColor,
                                                                                      borderRadius:
                                                                                          BorderRadius
                                                                                              .circular(14),
                                                                                      border: Border.all(
                                                                                          color: Theme.of(
                                                                                                  context)
                                                                                              .accentTextTheme
                                                                                              .bodyText1!
                                                                                              .color!)),
                                                                                  child: Text(
                                                                                    S.of(context).confirm,
                                                                                    style: TextStyle(
                                                                                        fontFamily:
                                                                                            StringUtils
                                                                                                .appFont,
                                                                                        color: Theme.of(
                                                                                                context)
                                                                                            .accentTextTheme
                                                                                            .bodyText1!
                                                                                            .color,
                                                                                        fontSize: 14,
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
                                                                  child: (cardData.data!.dashboardDataContent!
                                                                              .debitCard!.isNotEmpty &&
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
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12),
                                                                            ),
                                                                            Padding(
                                                                              padding:
                                                                                  EdgeInsets.only(top: 5),
                                                                              child: Text(
                                                                                (cardData
                                                                                                .data!
                                                                                                .dashboardDataContent!
                                                                                                .debitCard!
                                                                                                .length >
                                                                                            0 &&
                                                                                        cardData
                                                                                                .data!
                                                                                                .dashboardDataContent!
                                                                                                .debitCard![0]
                                                                                                .debitDeliveredDatetime !=
                                                                                            null &&
                                                                                        cardData
                                                                                            .data!
                                                                                            .dashboardDataContent!
                                                                                            .debitCard![0]
                                                                                            .debitDeliveredDatetime
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
                                                                                    fontFamily:
                                                                                        StringUtils.appFont,
                                                                                    fontSize: 12,
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
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  fontSize: 12),
                                                                            ),
                                                                            Padding(
                                                                              padding:
                                                                                  EdgeInsets.only(top: 5),
                                                                              child: cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .debitCard!
                                                                                          .length >
                                                                                      0
                                                                                  ? InkWell(
                                                                                      onTap: () async {
                                                                                        var result = await Navigator
                                                                                            .push(
                                                                                                context,
                                                                                                MaterialPageRoute(
                                                                                                    builder: (context) => DebitCardDeliveredPage(
                                                                                                        debitCard:
                                                                                                            TimeLineListArguments() //cardData.data!.dashboardDataContent!.debitCard!.first,
                                                                                                        )));
                                                                                        if (result != null) {
                                                                                          print('$result');
                                                                                          model
                                                                                              .getDashboardData();
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        padding: EdgeInsets
                                                                                            .symmetric(
                                                                                                horizontal:
                                                                                                    11,
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
                                                                                          S
                                                                                              .of(context)
                                                                                              .confirm,
                                                                                          style: TextStyle(
                                                                                              fontFamily:
                                                                                                  StringUtils
                                                                                                      .appFont,
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
                                                                                    )
                                                                                  : Text('-'),
                                                                            )
                                                                          ],
                                                                        ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsets.only(left: 180),
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        S.of(context).joinedBlink,
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(top: 5),
                                                                        child: Text(
                                                                          cardData.data!.dashboardDataContent!
                                                                                      .youJoinedBlink !=
                                                                                  null
                                                                              ? TimeUtils
                                                                                  .getFormattedDateForTransaction(
                                                                                      cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .youJoinedBlink!
                                                                                          .toString())
                                                                              : '-',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              fontSize: 12,
                                                                              color: Theme.of(context)
                                                                                  .inputDecorationTheme
                                                                                  .hintStyle!
                                                                                  .color,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(left: 56, top: 22),
                                                            child: IntrinsicHeight(
                                                              child: Row(
                                                                mainAxisSize: MainAxisSize.min,
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
                                                                    child: Stack(
                                                                      children: [
                                                                        Padding(
                                                                          padding:
                                                                              EdgeInsets.only(left: 15.0),
                                                                          child: Image.asset(
                                                                              AssetUtils.progress2),
                                                                        ),
                                                                        Positioned(
                                                                          bottom: 0,
                                                                          right: -10,
                                                                          child: Container(
                                                                            height: 20,
                                                                            width: 20,
                                                                            decoration: BoxDecoration(
                                                                                color: AppColor.vividYellow,
                                                                                shape: BoxShape.circle),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top: 0,
                                                                          left: 0,
                                                                          child: Container(
                                                                            height: 20,
                                                                            width: 20,
                                                                            decoration: BoxDecoration(
                                                                                color: AppColor.vivid_red,
                                                                                shape: BoxShape.circle),
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
                                                                        Image.asset(AssetUtils.progress1),
                                                                        Positioned(
                                                                          bottom: 0,
                                                                          left: -10,
                                                                          child: Container(
                                                                            height: 20,
                                                                            width: 20,
                                                                            decoration: BoxDecoration(
                                                                                color: AppColor.vividYellow,
                                                                                shape: BoxShape.circle),
                                                                          ),
                                                                        ),
                                                                        Positioned(
                                                                          top: 0,
                                                                          right: -10,
                                                                          child: Container(
                                                                            height: 20,
                                                                            width: 20,
                                                                            decoration: BoxDecoration(
                                                                                color: AppColor.vividYellow,
                                                                                shape: BoxShape.circle),
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
                                                                                ? 0
                                                                                : 10),
                                                                        child:
                                                                            Image.asset(AssetUtils.progress2),
                                                                      ),
                                                                      Positioned(
                                                                        bottom: 0,
                                                                        right: -10,
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
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
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Stack(
                                                                    children: [
                                                                      Image.asset(AssetUtils.progress1),
                                                                      Positioned(
                                                                        bottom: 0,
                                                                        left: -10,
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        top: 0,
                                                                        right: -10,
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  Stack(
                                                                    children: [
                                                                      Padding(
                                                                          padding: EdgeInsets.only(right: 15),
                                                                          child: Image.asset(
                                                                              AssetUtils.progress2)),
                                                                      Positioned(
                                                                        top: 0,
                                                                        left: -10,
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        bottom: 0,
                                                                        right: 5,
                                                                        child: Container(
                                                                          height: 20,
                                                                          width: 20,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColor.vividYellow,
                                                                              shape: BoxShape.circle),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets.only(top: 19, left: 160),
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
                                                                        S.of(context).creditCardActivated,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(top: 4),
                                                                        child: Text(
                                                                          (cardData.data!.dashboardDataContent!
                                                                                          .creditCard!.length >
                                                                                      0
                                                                                  ? cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .creditCard!
                                                                                          .first
                                                                                          .creditCardActivatedDate !=
                                                                                      null
                                                                                  : false)
                                                                              ? TimeUtils
                                                                                  .getFormattedDateForTransaction(
                                                                                      cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .creditCard!
                                                                                          .first
                                                                                          .creditCardActivatedDate!
                                                                                          .toString())
                                                                              : '-',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              color: Theme.of(context)
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
                                                                        S.of(context).debitCardActivated,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(top: 4),
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
                                                                              ? TimeUtils
                                                                                  .getFormattedDateForTransaction(
                                                                                      cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .debitCard!
                                                                                          .first
                                                                                          .debitCardActivated!
                                                                                          .toString())
                                                                              : '-',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              color: Theme.of(context)
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
                                                                  padding: EdgeInsets.only(left: 180),
                                                                  child: Column(
                                                                    children: [
                                                                      Text(
                                                                        S.of(context).blinkBorn,
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily: StringUtils.appFont,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 12),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(top: 4),
                                                                        child: Text(
                                                                          cardData.data!.dashboardDataContent!
                                                                                      .blinkWasBorn !=
                                                                                  null
                                                                              ? TimeUtils
                                                                                  .getFormattedDateForTransaction(
                                                                                      cardData
                                                                                          .data!
                                                                                          .dashboardDataContent!
                                                                                          .blinkWasBorn!
                                                                                          .toString())
                                                                              : '-',
                                                                          style: TextStyle(
                                                                              fontFamily: StringUtils.appFont,
                                                                              color: Theme.of(context)
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
                                                  Visibility(
                                                    visible: false,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(top: 48),
                                                      child: Container(
                                                        height: 150,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                            // color: Theme.of(context)
                                                            //     .primaryColor,
                                                            image: DecorationImage(
                                                                image: AssetImage(AssetUtils.credit),
                                                                fit: BoxFit.contain),
                                                            borderRadius: BorderRadius.circular(16)),
                                                      ),
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
                                                              color: currentStep == 1 || currentStep == 3
                                                                  ? Theme.of(context).primaryColor
                                                                  : currentStep == 2
                                                                      ? Theme.of(context).canvasColor
                                                                      : Theme.of(context).primaryColorDark,
                                                              borderRadius: BorderRadius.only(
                                                                  topLeft: Radius.circular(16),
                                                                  topRight: Radius.circular(16))),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(top: 22, left: 27),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                currentStep == 1 || currentStep == 0
                                                                    ? AppSvg.asset(
                                                                        AssetUtils.blink_updated_logo,
                                                                        height: 34,
                                                                        width: 72)
                                                                    : AppSvg.asset(AssetUtils.blinkBlack,
                                                                        height: 34, width: 72),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Center(child: AppSvg.asset(AssetUtils.swipeUp)),
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
                    });
              });
        },
      ),
    );
  }

  void listenPopUps(AppHomeViewModel model, BuildContext context) {
    ///talabat placeholder
    // model.getSentMoneyPopUpDataStream.listen((data) {
    //   if (data) {
    //     showDialog(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (context) => popUpWidget(context, AssetUtils.sentOffer));
    //   }
    // });

    model.getRequestMoneyPopUpDataStream.listen((data) {
      if (data) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => popUpWidget(context, model.requestMoneyPlaceholderData.image));
      }
    });

    // model.showSubSubscriptionPopUpStream.listen((data) {
    //   if (data) {
    //     showDialog(
    //         context: context,
    //         barrierDismissible: false,
    //         builder: (context) => subscriptionPopUpWidget(context, model));
    //   }
    // });
  }

  Widget popUpWidget(BuildContext context, dynamic image) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Container(
              // height: 530,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Image.memory(
                image,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
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
