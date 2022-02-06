import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/extension/string_casing_extension.dart';
import 'package:neo_bank/utils/screen_size_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class MyDebitCardPageView extends BasePageViewWidget<MyDebitCardViewModel> {
  // MyDebitCardPageView(ProviderBase model) : super(model);
  final GetDashboardDataContent cardData;

  MyDebitCardPageView(ProviderBase model, this.cardData) : super(model);

  @override
  Widget build(BuildContext context, model) {
    bool isSmallDevices = model.deviceSize.height <
            ScreenSizeBreakPoints.SMALL_DEVICE_HEIGHT ||
        model.deviceSize.height < ScreenSizeBreakPoints.MEDIUM_DEVICE_HEIGHT;
    return !(cardData.debitCard!.length > 0)
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: AspectRatio(
                aspectRatio: isSmallDevices ? 0.68 : 0.62,
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
                    color: Theme.of(context).canvasColor,
                    margin: EdgeInsets.zero,
                    shadowColor:
                        Theme.of(context).primaryColorDark.withOpacity(0.32),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(AssetUtils.zigzagDebit))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 23, right: 23, left: 23),
                              child: Image.asset(AssetUtils.blink,
                                  height: isSmallDevices ? 26 : 33.64,
                                  width: isSmallDevices ? 52 : 72),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: isSmallDevices ? 50 : 78),
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
                                    S.of(context).toEnjoyCardLessPaymentDebit,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: isSmallDevices ? 10 : 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).accentColor),
                                  ),
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: isSmallDevices ? 50 : 88,
                                  bottom: 29,
                                  left: isSmallDevices ? 34 : 24,
                                  right: isSmallDevices ? 34 : 24),
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        RoutePaths.DebitCardReplacement);
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
                                        S.of(context).requestNewDebitcard,
                                        style: TextStyle(
                                            fontSize: isSmallDevices ? 10 : 12,
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
        : Center(
            child: FlipCard(
              key: model.cardKey,
              flipOnTouch: false,
              // cardData.debitCard!.first.cardStatus == FreezeCardStatusEnum.F
              //     ? false
              //     : true,
              direction: FlipDirection.HORIZONTAL,
              front: Container(
                color: Theme.of(context).accentColor,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: !(cardData.debitCard!.first.isDebitDelivered !=
                                      null &&
                                  cardData.debitCard!.first.isDebitDelivered!)
                              ? 8.0
                              : 0.0,
                          bottom: 15),
                      child: AspectRatio(
                        aspectRatio: isSmallDevices ? 0.68 : 0.62,
                        child: GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (details.primaryVelocity!.isNegative) {
                              ProviderScope.containerOf(context)
                                  .read(appHomeViewModelProvider)
                                  .pageController
                                  .next();
                              if (!model.cardKey.currentState!.isFront) {
                                model.cardKey.currentState!.toggleCard();
                              }
                            } else {
                              ProviderScope.containerOf(context)
                                  .read(appHomeViewModelProvider)
                                  .pageController
                                  .previous();
                              if (!model.cardKey.currentState!.isFront) {
                                model.cardKey.currentState!.toggleCard();
                              }
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 2,
                            color: cardData.debitCard!.first.cardStatus ==
                                    FreezeCardStatusEnum.F
                                ? AppColor.paleYellow
                                : Theme.of(context).canvasColor,
                            margin: EdgeInsets.zero,
                            shadowColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.32),
                            child: AppStreamBuilder<bool>(
                              stream: model.isGetCardNowClickedStream,
                              initialData: false,
                              dataBuilder: (context, isClicked) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 27.0,
                                        top: 30,
                                        bottom: isSmallDevices ? 10 : 29),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              S.of(context).myDebitCard,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                  fontSize:
                                                      isSmallDevices ? 10 : 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            cardData.debitCard!.first
                                                        .cardStatus ==
                                                    FreezeCardStatusEnum.F
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 23.0),
                                                    child: Text(
                                                      S.of(context).cardFrozen,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .color!
                                                              .withOpacity(0.5),
                                                          fontSize:
                                                              isSmallDevices
                                                                  ? 12
                                                                  : 14,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () {
                                                      model
                                                          .cardKey.currentState!
                                                          .toggleCard();
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 23.0),
                                                      child: Text(
                                                        S.of(context).flipCard,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .accentTextTheme
                                                                .bodyText1!
                                                                .color!,
                                                            fontSize:
                                                                isSmallDevices
                                                                    ? 12
                                                                    : 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 12),
                                                child: AppSvg.asset(
                                                    AssetUtils.blinkBlack),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 21),
                                                child: Text(
                                                  cardData.debitCard!.first
                                                          .accountTitle ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: isSmallDevices
                                                        ? 10
                                                        : 12,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: isSmallDevices ? 10 : 70),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: AppSvg.asset(
                                                AssetUtils.zigzagCircle),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: isSmallDevices ? 10 : 24),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      RoutePaths
                                                          .AddMoneyOptionSelector);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width:
                                                      isSmallDevices ? 95 : 104,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .color),
                                                  child: Center(
                                                    child: Text(
                                                      S.of(context).addMoney,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize:
                                                              isSmallDevices
                                                                  ? 12
                                                                  : 14,
                                                          color:
                                                              Theme.of(context)
                                                                  .accentColor),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  var result =
                                                      await Navigator.pushNamed(
                                                          context,
                                                          RoutePaths
                                                              .DebitCardSettings);
                                                  if (result != null) {
                                                    bool value = result as bool;
                                                    if (value) {
                                                      ProviderScope.containerOf(
                                                              context)
                                                          .read(
                                                              appHomeViewModelProvider)
                                                          .getDashboardData();
                                                    }
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 33.0),
                                                  child: AppSvg.asset(
                                                      AssetUtils.settingsRed,
                                                      color: Theme.of(context)
                                                          .accentTextTheme
                                                          .bodyText1!
                                                          .color!),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),

                    ///delivered button
                    Visibility(
                      visible: !(cardData.debitCard!.first.isDebitDelivered !=
                              null &&
                          cardData.debitCard!.first.isDebitDelivered!),
                      child: Positioned(
                        top: 0,
                        child: Container(
                          height: 24,
                          width: isSmallDevices ? 100 : 125,
                          decoration: BoxDecoration(
                              color: AppColor.darkGrey,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              S.of(context).cardDelivered,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: isSmallDevices ? 10 : 12),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              back: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: AspectRatio(
                  aspectRatio: isSmallDevices ? 0.68 : 0.62,
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .next();
                        Future.delayed(Duration(milliseconds: 300))
                            .then((value) {
                          if (!model.cardKey.currentState!.isFront) {
                            model.cardKey.currentState!.toggleCard();
                          }
                        });
                      } else {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .pageController
                            .previous();
                        Future.delayed(Duration(milliseconds: 600))
                            .then((value) {
                          if (!model.cardKey.currentState!.isFront) {
                            model.cardKey.currentState!.toggleCard();
                          }
                        });
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 2,
                      color: Theme.of(context).canvasColor,
                      margin: EdgeInsets.zero,
                      shadowColor:
                          Theme.of(context).primaryColorDark.withOpacity(0.32),
                      child: AppStreamBuilder<bool>(
                        stream: model.isGetCardNowClickedStream,
                        initialData: false,
                        dataBuilder: (context, isClicked) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 29.0, top: 38, right: 25, bottom: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cardData.debitCard!.first
                                                      .accountTitle !=
                                                  null
                                              ? cardData.debitCard!.first
                                                  .accountTitle!
                                                  .toTitleCase()
                                              : '',
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontSize:
                                                  isSmallDevices ? 10 : 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
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
                                              fontSize:
                                                  isSmallDevices ? 12 : 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: isSmallDevices ? 50 : 63),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cardData.debitCard!.first.cardNumber!
                                                  .isNotEmpty
                                              ? StringUtils
                                                  .getFormattedCreditCardNumber(
                                                      cardData.debitCard!.first
                                                          .cardNumber)
                                              : '-',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: isSmallDevices ? 12 : 14,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: InkWell(
                                              onTap: () {
                                                Clipboard.setData(ClipboardData(
                                                        text: cardData
                                                                .debitCard!
                                                                .first
                                                                .cardNumber ??
                                                            ''))
                                                    .then((value) =>
                                                        Fluttertoast.showToast(
                                                            msg:
                                                                'Card number Copied'));
                                              },
                                              child: AppSvg.asset(
                                                  AssetUtils.copy)),
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
                                          fontSize: isSmallDevices ? 8 : 10,
                                          color: AppColor.green),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 21),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cardData.debitCard!.first
                                                      .expiryDate ??
                                                  '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    isSmallDevices ? 10 : 12,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(
                                                S.of(context).expiryDate,
                                                style: TextStyle(
                                                    fontSize:
                                                        isSmallDevices ? 8 : 10,
                                                    color: AppColor.green,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cardData.debitCard!.first.cvv ??
                                                  '',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    isSmallDevices ? 10 : 12,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 4),
                                              child: Text(
                                                S.of(context).cvv,
                                                style: TextStyle(
                                                    fontSize:
                                                        isSmallDevices ? 8 : 10,
                                                    color: AppColor.green,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 32),
                                    child: Divider(
                                      height: 2,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1!
                                          .color!
                                          .withOpacity(0.1),
                                    ),
                                  ),
                                  Text(
                                    cardData.debitCard!.first
                                            .linkedAccountNumber!.isNotEmpty
                                        ? StringUtils
                                            .getFormattedCreditCardNumber(
                                                cardData.debitCard!.first
                                                    .linkedAccountNumber)
                                        : '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: isSmallDevices ? 12 : 14,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      S.of(context).linkedAccountNumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: isSmallDevices ? 8 : 10,
                                          color: AppColor.green),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
