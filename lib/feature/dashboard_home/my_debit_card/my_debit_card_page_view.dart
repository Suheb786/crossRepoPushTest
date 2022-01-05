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

class MyDebitCardPageView extends BasePageViewWidget<MyDebitCardViewModel> {
  MyDebitCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Center(
      child: AppStreamBuilder<GetDashboardDataContent>(
        stream: ProviderScope.containerOf(context)
            .read(appHomeViewModelProvider)
            .getDashboardCardDataStream,
        initialData: GetDashboardDataContent(),
        dataBuilder: (context, cardData) {
          return FlipCard(
            key: model.cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            front: Container(
              color: Theme.of(context).accentColor,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: !(cardData!.isDebitDelivered != null &&
                                cardData.isDebitDelivered)
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
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 2,
                          color: Theme.of(context).canvasColor,
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
                                      left: 27.0, top: 30, bottom: 29),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            S.of(context).myDebitCard,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: 23.0),
                                            child: InkWell(
                                              onTap: () {
                                                model.cardKey.currentState!
                                                    .toggleCard();
                                              },
                                              child: Text(
                                                S.of(context).flipCard,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .accentTextTheme
                                                        .bodyText1!
                                                        .color!,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                              padding: EdgeInsets.only(top: 12),
                                              child: AppSvg.asset(
                                                  AssetUtils.blinkBlack),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 21),
                                              child: Text(
                                                cardData.debitCard!
                                                        .accountTitle ??
                                                    '',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 76),
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: AppSvg.asset(
                                                  AssetUtils.zigzagCircle),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 10),
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
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Theme.of(context)
                                                        .accentTextTheme
                                                        .bodyText1!
                                                        .color),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 17),
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
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RoutePaths
                                                        .DebitCardSettings);
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
                    visible: !(cardData.isDebitDelivered != null &&
                        cardData.isDebitDelivered),
                    child: Positioned(
                      top: 0,
                      child: Container(
                        height: 24,
                        width: 125,
                        decoration: BoxDecoration(
                            color: AppColor.darkGrey,
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
                ],
              ),
            ),
            back: Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: AspectRatio(
                aspectRatio: 0.62,
                child: GestureDetector(
                  onHorizontalDragEnd: (details) {
                    if (details.primaryVelocity!.isNegative) {
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
                    child: AppStreamBuilder<bool>(
                      stream: model.isGetCardNowClickedStream,
                      initialData: false,
                      dataBuilder: (context, isClicked) {
                        return SingleChildScrollView(
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
                                    Expanded(
                                      child: Text(
                                        cardData.debitCard!.accountTitle ?? '',
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                            fontSize: 12,
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 63),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          cardData.debitCard!.cardNumber ?? '',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            Clipboard.setData(ClipboardData(
                                                    text: cardData.debitCard!
                                                            .cardNumber ??
                                                        ''))
                                                .then((value) =>
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            'Card number Copied'));
                                          },
                                          child: AppSvg.asset(AssetUtils.copy))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    S.of(context).cardNumber,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
                                            cardData.debitCard!.expiryDate ??
                                                '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              S.of(context).expiryDate,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColor.green,
                                                  fontWeight: FontWeight.w600),
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
                                            cardData.debitCard!.cvv ?? '',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              S.of(context).cvv,
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: AppColor.green,
                                                  fontWeight: FontWeight.w600),
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
                                    height: 1,
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1!
                                        .color!
                                        .withOpacity(0.1),
                                  ),
                                ),
                                Text(
                                  cardData.debitCard!.linkedAccountNumber ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    S.of(context).linkedAccountNumber,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
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
          );
        },
      ),
    );
  }
}
