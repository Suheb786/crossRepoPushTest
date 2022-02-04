import 'package:backdrop/backdrop.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class GetCreditCardPageView extends BasePageViewWidget<GetCreditCardViewModel> {
  // GetCreditCardPageView(ProviderBase model) : super(model);
  final GetDashboardDataContent cardData;

  GetCreditCardPageView(ProviderBase model, this.cardData) : super(model);
  bool isGetCardClicked = false;

  @override
  Widget build(BuildContext context, model) {
    return !(cardData.creditCard!.length > 0)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: AspectRatio(
                aspectRatio: 0.62,
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
                      ProviderScope.containerOf(context)
                          .read(appHomeViewModelProvider)
                          .pageController
                          .next();
                    } else {
                      ProviderScope.containerOf(context)
                          .read(appHomeViewModelProvider)
                          .pageController
                          .previous();
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 2,
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.zero,
                    shadowColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.32),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AssetUtils.zigzagBackground))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                print("toggle button");
                                BackdropToggleButton();
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 23, right: 23, left: 23),
                                child: Image.asset(AssetUtils.blink,
                                    height: 33.64, width: 72),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 78),
                              child: Align(
                                alignment: Alignment.center,
                                child: AppSvg.asset(AssetUtils.cardCircle),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: 12, left: 10, right: 10),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    S.of(context).blinkCreditCard,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 88, bottom: 29, left: 24, right: 24),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    // model.updateIsGetCardNowClicked(
                                    //     !isValid!);
                                    Navigator.pushNamed(
                                        context, RoutePaths.BlinkCreditCard);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 17),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .accentTextTheme
                                            .bodyText1
                                            ?.color,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                      child: Text(
                                        S.of(context).getCardNow,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).accentColor),
                                      ),
                                    ),
                                  ),
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
          )
        : FlipCard(
            key: model.cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            front: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: !(cardData.creditCard!.first.isCreditDelivered !=
                                    null &&
                                cardData.creditCard!.first.isCreditDelivered!)
                            ? 8.0
                            : 0.0,
                        bottom: 15),
                    child: AspectRatio(
                      aspectRatio: 0.62,
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .pageController
                                .next();
                          } else {
                            ProviderScope.containerOf(context)
                                .read(appHomeViewModelProvider)
                                .pageController
                                .previous();
                          }
                        },
                        child: Container(
                            key: ValueKey(true),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              margin: EdgeInsets.zero,
                              shadowColor: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 23, right: 23, left: 23),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(AssetUtils.blink,
                                            height: 33.64, width: 72),
                                        InkWell(
                                          onTap: () {
                                            model.cardKey.currentState!
                                                .toggleCard();
                                          },
                                          child: Text(
                                            S.of(context).flipCard,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Theme.of(context)
                                                    .accentTextTheme
                                                    .bodyText1!
                                                    .color),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 61),
                                    child: Image.asset(
                                        AssetUtils.line_black_white),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 24, top: 53, right: 11),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  cardData
                                                      .creditCard!.first.minDue
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    "JOD",
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.lightRed,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),

                                              ///TODO: minDueDAte
                                              child: Row(
                                                children: [
                                                  Text(
                                                    S.of(context).minDueBy,
                                                    style: TextStyle(
                                                        color: AppColor
                                                            .veryLightRed,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    StringUtils.getMinDueDate(),
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                RoutePaths.CreditCardPayBack,
                                                arguments: CreditCardPayBackArguments(
                                                    secureCode: cardData
                                                        .creditCard!
                                                        .first
                                                        .cardCode!,
                                                    accountBalance: cardData
                                                        .account!
                                                        .availableBalance!,
                                                    minDuePayBackAmount:
                                                        cardData.creditCard!
                                                            .first.minDue
                                                            .toString(),
                                                    totalMinDueAmount: cardData
                                                        .creditCard!
                                                        .first
                                                        .paymentDueAmount!));
                                          },
                                          child: Container(
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 25),
                                              child: Text(
                                                S.of(context).payBack,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 19, left: 24, right: 23),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  cardData.creditCard!.first
                                                      .availableBalance
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 20),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    "JOD",
                                                    style: TextStyle(
                                                        color:
                                                            AppColor.lightRed,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 5),
                                              child: Text(
                                                S.of(context).availableAmount,
                                                style: TextStyle(
                                                    color:
                                                        AppColor.veryLightRed,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {
                                              // model.updateIsGetCardNowClicked(
                                              //     !isValid!);
                                              Navigator.pushNamed(
                                                  context,
                                                  RoutePaths
                                                      .CreditCardSettings);
                                            },
                                            child: AppSvg.asset(
                                                AssetUtils.settingsRed,
                                                color: Theme.of(context)
                                                    .accentColor))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !(cardData.creditCard!.first.isCreditDelivered !=
                            null &&
                        cardData.creditCard!.first.isCreditDelivered!),
                    child: Positioned(
                      top: 0,
                      child: Container(
                        height: 24,
                        width: 125,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorDark,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Text(
                            S.of(context).cardDelivered,
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Column(
                      children: [
                        AppSvg.asset(AssetUtils.swipeUp),
                        Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            S.of(context).swipeUpToViewTransaction,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: AppColor.dark_gray_1),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            back: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.0),
                child: AspectRatio(
                  aspectRatio: 0.62,
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .next();
                      } else {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .previous();
                      }
                    },
                    child: Container(
                      key: ValueKey(false),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        color: Theme.of(context).primaryColor,
                        margin: EdgeInsets.zero,
                        shadowColor: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.32),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: 29.0, top: 38, right: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      cardData.creditCard!.first.name ?? '',
                                      style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        model.cardKey.currentState!
                                            .toggleCard();
                                      },
                                      child: Text(
                                        S.of(context).flipBack,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .accentTextTheme
                                                .bodyText1!
                                                .color,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 63),
                                  child: Row(
                                    children: [
                                      Text(
                                        cardData.creditCard!.first.cardNumber!
                                                .isNotEmpty
                                            ? StringUtils
                                                .getFormattedCreditCardNumber(
                                                    cardData.creditCard!.first
                                                        .cardNumber)
                                            : '-',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Theme.of(context).accentColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(
                                                  text: cardData.creditCard!
                                                          .first.cardNumber ??
                                                      ''))
                                              .then((value) =>
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          'Card Number Copied'));
                                        },
                                        child: AppSvg.asset(AssetUtils.copy),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    S.of(context).cardNumber,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context)
                                            .accentColor
                                            .withOpacity(0.6),
                                        fontSize: 10),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 19),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 21),
                                    child: Text(
                                      "140591314151414",
                                      style: TextStyle(
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: false,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child:
                                        Text(S.of(context).linkedAccountNumber,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Theme.of(context)
                                                  .accentColor
                                                  .withOpacity(0.6),
                                            )),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 24, bottom: 24),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cardData.creditCard!.first
                                                    .expiryDate ??
                                                '-',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text(
                                              S.of(context).expiryDate,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Theme.of(context)
                                                      .accentColor
                                                      .withOpacity(0.6),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 59.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cardData.creditCard!.first.cvv!
                                                      .isNotEmpty
                                                  ? StringUtils.getCvv(cardData
                                                      .creditCard!.first.cvv)
                                                  : '-',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(
                                                S.of(context).cvv,
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Theme.of(context)
                                                        .accentColor
                                                        .withOpacity(0.6),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          cardData.creditCard!.first
                                                  .usedBalance ??
                                              '-',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'JOD',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Text(
                                        S.of(context).totalUsedAmount,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.6),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          cardData.creditCard!.first
                                                  .creditLimit ??
                                              '-',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'JOD',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: 4, bottom: 112),
                                      child: Text(
                                        S.of(context).yourCardLimit,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context)
                                                .accentColor
                                                .withOpacity(0.6),
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
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
            ));
    //     : AppStreamBuilder<bool>(
    //   stream: model.flipCardStream,
    //   initialData: false,
    //   dataBuilder: (context, isFlipped) {
    //           Widget _transitionBuilder(
    //               Widget widget, Animation<double> animation) {
    //             final rotateAnim =
    //                 Tween(begin: pi, end: 0.0).animate(animation);
    //             return AnimatedBuilder(
    //               animation: rotateAnim,
    //               child: widget,
    //               builder: (context, widget) {
    //                 final isUnder = (ValueKey(isFlipped) != widget!.key);
    //                 var tilt =
    //                     ((animation.value - 0.5).abs() - 0.5) * 0.003;
    //                 tilt *= isUnder ? -1.0 : 1.0;
    //                 final value = isUnder
    //                     ? min(rotateAnim.value, pi / 2)
    //                     : rotateAnim.value;
    //                 return Transform(
    //                   transform: Matrix4.rotationY(value)
    //                     ..setEntry(3, 0, tilt),
    //                   child: widget,
    //                   alignment: Alignment.center,
    //                 );
    //               },
    //             );
    //           }
    //
    //           return Center(
    //             child: AspectRatio(
    //               aspectRatio: 0.62,
    //               child: GestureDetector(
    //                 onHorizontalDragEnd: (details) {
    //                   if (details.primaryVelocity!.isNegative) {
    //                     ProviderScope.containerOf(context)
    //                         .read(appHomeViewModelProvider)
    //                         .pageController
    //                         .next();
    //                   } else {
    //                     ProviderScope.containerOf(context)
    //                         .read(appHomeViewModelProvider)
    //                         .pageController
    //                         .previous();
    //                   }
    //                 },
    //                 child: AnimatedSwitcher(
    //                   transitionBuilder: _transitionBuilder,
    //                   duration: Duration(milliseconds: 800),
    //                   switchInCurve: Curves.easeInBack,
    //                   switchOutCurve: Curves.easeInBack.flipped,
    //                   child: isFlipped == false
    //                       ? Container(
    //                           key: ValueKey(true),
    //                           child: Card(
    //                               shape: RoundedRectangleBorder(
    //                                   borderRadius:
    //                                       BorderRadius.circular(16)),
    //                               clipBehavior:
    //                                   Clip.antiAliasWithSaveLayer,
    //                               elevation: 2,
    //                               color: Theme.of(context).primaryColor,
    //                               margin: EdgeInsets.zero,
    //                               shadowColor: Theme.of(context)
    //                                   .primaryColorDark
    //                                   .withOpacity(0.32),
    //                               child: Column(
    //                                 crossAxisAlignment:
    //                                     CrossAxisAlignment.start,
    //                                 children: [
    //                                   Padding(
    //                                     padding: const EdgeInsets.only(
    //                                         top: 23, right: 23, left: 23),
    //                                     child: Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment
    //                                               .spaceBetween,
    //                                       children: [
    //                                         Image.asset(AssetUtils.blink,
    //                                             height: 33.64, width: 72),
    //                                         InkWell(
    //                                           onTap: () {
    //                                             print("clicked");
    //                                             model
    //                                                 .updateFlipCardStream(
    //                                                     !isFlipped!);
    //                                           },
    //                                           child: Text(
    //                                             S.of(context).flipCard,
    //                                 textAlign: TextAlign.right,
    //                                 style: TextStyle(
    //                                     fontWeight: FontWeight.w600,
    //                                     fontSize: 14,
    //                                     color: Theme.of(context)
    //                                         .accentColor
    //                                         .withOpacity(0.4)),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: EdgeInsets.only(top: 61),
    //                         child: Image.asset(
    //                             AssetUtils.line_black_white),
    //                       ),
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             left: 24, top: 53, right: 11),
    //                         child: Row(
    //                           mainAxisAlignment:
    //                                           MainAxisAlignment
    //                                               .spaceBetween,
    //                                       children: [
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment
    //                                                   .start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   "0.00",
    //                                                   style: TextStyle(
    //                                                       color: Theme.of(
    //                                                               context)
    //                                                           .accentColor,
    //                                                       fontWeight:
    //                                                           FontWeight
    //                                                               .w700,
    //                                                       fontSize: 20),
    //                                     ),
    //                                     Padding(
    //                                       padding: EdgeInsets.only(
    //                                           left: 5.0),
    //                                       child: Text(
    //                                         "JOD",
    //                                                     style: TextStyle(
    //                                                         color: AppColor
    //                                                             .lightRed,
    //                                                         fontSize: 14,
    //                                                         fontWeight:
    //                                                             FontWeight
    //                                                                 .w700),
    //                                                   ),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                                   EdgeInsets.only(
    //                                                       top: 5),
    //                                               child: Text(
    //                                                 S
    //                                                     .of(context)
    //                                                     .totalUsedLimit,
    //                                                 style: TextStyle(
    //                                                     color: AppColor
    //                                                         .veryLightRed,
    //                                                     fontWeight:
    //                                                         FontWeight
    //                                                             .w600,
    //                                                     fontSize: 10),
    //                                               ),
    //                                 )
    //                               ],
    //                             ),
    //                             Container(
    //                               height: 36,
    //                               decoration: BoxDecoration(
    //                                 color: Theme.of(context)
    //                                                 .accentTextTheme
    //                                                 .bodyText1!
    //                                                 .color,
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     20),
    //                                           ),
    //                               child: Padding(
    //                                 padding: EdgeInsets.symmetric(
    //                                     vertical: 8,
    //                                     horizontal: 25),
    //                                 child: Text(
    //                                   S.of(context).payBack,
    //                                   style: TextStyle(
    //                                     color: Theme.of(context)
    //                                         .accentColor,
    //                                     fontSize: 14,
    //                                     fontWeight: FontWeight.w600,
    //                                   ),
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                       Padding(
    //                         padding: EdgeInsets.only(
    //                             top: 19, left: 24, right: 23),
    //                         child: Row(
    //                           mainAxisAlignment:
    //                                           MainAxisAlignment
    //                                               .spaceBetween,
    //                                       crossAxisAlignment:
    //                                           CrossAxisAlignment.end,
    //                                       children: [
    //                                         Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment
    //                                                   .start,
    //                                           children: [
    //                                             Row(
    //                                               children: [
    //                                                 Text(
    //                                                   "15000.00",
    //                                                   style: TextStyle(
    //                                                       color: Theme.of(
    //                                                               context)
    //                                                           .accentColor,
    //                                                       fontWeight:
    //                                                           FontWeight
    //                                                               .w700,
    //                                                       fontSize: 16),
    //                                     ),
    //                                     Padding(
    //                                       padding: EdgeInsets.only(
    //                                           left: 5.0),
    //                                       child: Text(
    //                                         "JOD",
    //                                                     style: TextStyle(
    //                                                         color: AppColor
    //                                                             .lightRed,
    //                                                         fontSize: 14,
    //                                                         fontWeight:
    //                                                             FontWeight
    //                                                                 .w700),
    //                                                   ),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Padding(
    //                                   padding:
    //                                                   EdgeInsets.only(
    //                                                       top: 5),
    //                                               child: Text(
    //                                                 S
    //                                                     .of(context)
    //                                                     .availableAmount,
    //                                                 style: TextStyle(
    //                                                     color: AppColor
    //                                                         .veryLightRed,
    //                                                     fontWeight:
    //                                                         FontWeight
    //                                                             .w600,
    //                                                     fontSize: 10),
    //                                               ),
    //                                 ),
    //                               ],
    //                             ),
    //                             InkWell(
    //                                 onTap: () {
    //                                   model
    //                                                   .updateIsGetCardNowClicked(
    //                                                       !isValid!);
    //                                             },
    //                                 child: AppSvg.asset(
    //                                     AssetUtils.settingsRed,
    //                                     color: Theme
    //                                         .of(context)
    //                                         .accentColor))
    //                           ],
    //                         ),
    //                       )
    //                     ],
    //                   )
    //               ),
    //             ) :
    //                         Container(
    //               key: ValueKey(false),
    //               child: Card(
    //                 shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(16)),
    //                 clipBehavior: Clip.antiAliasWithSaveLayer,
    //                 elevation: 2,
    //                 color: Theme
    //                     .of(context)
    //                     .primaryColor,
    //                 margin: EdgeInsets.zero,
    //                 shadowColor: Theme
    //                     .of(context)
    //                     .primaryColorDark
    //                     .withOpacity(0.32),
    //                 child: SingleChildScrollView(
    //                   child: Padding(
    //                     padding: EdgeInsets.only(
    //                         left: 29.0, top: 38, right: 25),
    //                     child: Column(
    //                       crossAxisAlignment:
    //                       CrossAxisAlignment.start,
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Row(
    //                           crossAxisAlignment:
    //                           CrossAxisAlignment.start,
    //                           mainAxisAlignment:
    //                           MainAxisAlignment.spaceBetween,
    //                           children: [
    //                             Text(
    //                               "Zein Malhas",
    //                               style: TextStyle(
    //                                   color: Theme
    //                                       .of(context)
    //                                       .accentColor,
    //                                   fontSize: 16,
    //                                   fontWeight:
    //                                   FontWeight.w600),
    //                             ),
    //                             InkWell(
    //                               onTap: () {
    //                                 model.updateFlipCardStream(
    //                                     !isFlipped!);
    //                               },
    //                               child: Text(
    //                                 S
    //                                     .of(context)
    //                                     .flipBack,
    //                                 style: TextStyle(
    //                                     color: Theme
    //                                         .of(context)
    //                                         .accentColor
    //                                         .withOpacity(0.6),
    //                                     fontSize: 14,
    //                                     fontWeight:
    //                                     FontWeight.w600),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 63),
    //                           child: Text(
    //                             "8451 1353 1245 3421",
    //                             style: TextStyle(
    //                               fontWeight: FontWeight.w600,
    //                               color: Theme
    //                                   .of(context)
    //                                   .accentColor,
    //                               fontSize: 16,
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 8),
    //                           child: Text(
    //                             S
    //                                 .of(context)
    //                                 .cardNumber,
    //                             style: TextStyle(
    //                                 fontWeight: FontWeight.w600,
    //                                 color: Theme
    //                                     .of(context)
    //                                     .accentColor
    //                                     .withOpacity(0.6),
    //                                 fontSize: 10),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 19),
    //                           child: Divider(
    //                             height: 1,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 21),
    //                           child: Text(
    //                             "140591314151414",
    //                             style: TextStyle(
    //                               color: Theme
    //                                   .of(context)
    //                                   .accentColor,
    //                               fontWeight: FontWeight.w600,
    //                               fontSize: 16,
    //                             ),
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 8),
    //                           child: Text(
    //                               S
    //                                   .of(context)
    //                                   .linkedAccountNumber,
    //                               style: TextStyle(
    //                                 fontWeight: FontWeight.w600,
    //                                 fontSize: 10,
    //                                 color: Theme
    //                                     .of(context)
    //                                     .accentColor
    //                                     .withOpacity(0.6),
    //                               )),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(top: 19),
    //                           child: Divider(
    //                             height: 1,
    //                           ),
    //                         ),
    //                         Padding(
    //                           padding: EdgeInsets.only(
    //                               top: 21, bottom: 128),
    //                           child: Row(
    //                             children: [
    //                               Column(
    //                                 crossAxisAlignment:
    //                                 CrossAxisAlignment.start,
    //                                 children: [
    //                                   Text(
    //                                     "08/23",
    //                                     style: TextStyle(
    //                                       fontWeight:
    //                                       FontWeight.w600,
    //                                       fontSize: 16,
    //                                       color: Theme
    //                                           .of(context)
    //                                           .accentColor,
    //                                     ),
    //                                   ),
    //                                   Padding(
    //                                     padding: EdgeInsets.only(
    //                                         top: 8),
    //                                     child: Text(
    //                                       S
    //                                           .of(context)
    //                                           .expiryDate,
    //                                       style: TextStyle(
    //                                           fontSize: 10,
    //                                           color: Theme
    //                                               .of(
    //                                               context)
    //                                               .accentColor
    //                                               .withOpacity(
    //                                               0.6),
    //                                           fontWeight:
    //                                           FontWeight
    //                                               .w600),
    //                                     ),
    //                                   )
    //                                 ],
    //                               ),
    //                               Padding(
    //                                 padding: EdgeInsets.only(
    //                                     left: 59.0),
    //                                 child: Column(
    //                                   crossAxisAlignment:
    //                                   CrossAxisAlignment
    //                                       .start,
    //                                   children: [
    //                                     Text(
    //                                       "688",
    //                                       style: TextStyle(
    //                                         fontWeight:
    //                                         FontWeight.w600,
    //                                         color:
    //                                         Theme
    //                                             .of(context)
    //                                             .accentColor,
    //                                         fontSize: 16,
    //                                       ),
    //                                     ),
    //                                     Padding(
    //                                       padding:
    //                                       EdgeInsets.only(
    //                                           top: 8),
    //                                       child: Text(
    //                                         S
    //                                             .of(context)
    //                                             .cvv,
    //                                         style: TextStyle(
    //                                             fontSize: 10,
    //                                             color: Theme
    //                                                 .of(
    //                                                 context)
    //                                                 .accentColor
    //                                                 .withOpacity(
    //                                                 0.6),
    //                                             fontWeight:
    //                                             FontWeight
    //                                                 .w600),
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
