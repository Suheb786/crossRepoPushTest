import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/apple_pay/apple_pay_success/apple_pay_success_and_error_page.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/no_data_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class SelectedCardForApplePayPageView extends BasePageViewWidget<SelectedCardForApplePayPageViewModel> {
  SelectedCardForApplePayPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SelectedCardForApplePayPageViewModel model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 56.0.h, end: 24.w, start: 24.w),
      child: Column(
        children: [
          Text(
            S.of(context).addToApplePay.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: StringUtils.appFont,
                fontSize: 10.t,
                fontWeight: FontWeight.w600),
          ),
          Text(
            S.of(context).selectOneCardToAddApplePay,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: StringUtils.appFont,
                fontSize: 20.t,
                fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: 32.h,
              ),
              child: Card(
                margin: EdgeInsets.zero,
                child: Column(children: [
                  AppStreamBuilder<bool>(
                      stream: pushCardSuccessStream,
                      initialData: false,
                      onData: (value) {
                        if (value) {
                          pushCardSuccess.add(false);

                          ///Navigate to success screen
                          Navigator.pushNamed(context, RoutePaths.ApplePaySuccessAndErrorPage,
                              arguments: ApplePaySuccessAndErrorPageArguments(
                                  isSuccess: true,
                                  successOrErrorIcon: AssetUtils.right,
                                  title: S.of(context).yourCardAddedToApplePay,
                                  titleDescription:
                                      "${S.of(context).yourCardAddedToApplePayDesc1}\n\n${S.of(context).yourCardAddedToApplePayDesc2}"));
                        }
                      },
                      dataBuilder: (context, pushCardSuccess) {
                        return AppStreamBuilder<bool>(
                            stream: pushCardErrorStream,
                            initialData: false,
                            onData: (value) {
                              if (value) {
                                pushCardError.add(false);

                                ///Navigate to error screen
                                Navigator.pushNamed(context, RoutePaths.ApplePaySuccessAndErrorPage,
                                    arguments: ApplePaySuccessAndErrorPageArguments(
                                        isSuccess: false,
                                        successOrErrorIcon: AssetUtils.cancel,
                                        title: S.of(context).applePaySetFailed,
                                        titleDescription: S.of(context).errorSettingApplePay));
                              }
                            },
                            dataBuilder: (context, pushCardError) {
                              return AppStreamBuilder<CardTypeData>(
                                  stream: model.cardListStream,
                                  onData: (data) {},
                                  initialData: CardTypeData(),
                                  dataBuilder: (context, cardListData) {
                                    return AppStreamBuilder<bool>(
                                        stream: antelopStepCompletedStream,
                                        initialData: true,
                                        onData: (value) {
                                          if (!value) {
                                            List<GetAllCardData> antelopIssuerCardList =
                                                listOfCardFromAntelop.value;

                                            if ((model.arguments.creditCards).isNotEmpty) {
                                              for (int i = 0; i < (model.arguments.creditCards).length; i++) {
                                                for (int j = 0; j < antelopIssuerCardList.length; j++) {
                                                  if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                                                      model.arguments.creditCards[i].cardCode?.trim()) {
                                                    model.arguments.creditCards[i].isCardInApplePay =
                                                        antelopIssuerCardList[j].isCardInApplePay ?? false;
                                                    model.arguments.creditCards[i].getStatus =
                                                        antelopIssuerCardList[j].getStatus ?? false;
                                                  }
                                                  // model.creditCards.add(model.arguments.creditCards![i]);
                                                }
                                              }
                                            }

                                            ///debit card filtering
                                            if ((model.arguments.debitCards).isNotEmpty) {
                                              for (int i = 0; i < (model.arguments.debitCards).length; i++) {
                                                for (int j = 0; j < antelopIssuerCardList.length; j++) {
                                                  if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                                                      model.arguments.debitCards[i].code?.trim()) {
                                                    model.arguments.debitCards[i].isCardInApplePay =
                                                        antelopIssuerCardList[j].isCardInApplePay ?? false;
                                                    model.arguments.debitCards[i].getStatus =
                                                        antelopIssuerCardList[j].getStatus ?? false;
                                                  }
                                                  // model.debitCards.add(model.arguments.debitCards![i]);
                                                }
                                              }
                                            }

                                            ///add updated list to stream
                                            model.addCardList(CardTypeData(
                                                creditCards: model.arguments.creditCards,
                                                debitCards: model.arguments.debitCards));
                                          }
                                        },
                                        dataBuilder: (context, antelopStepCompleted) {
                                          return Expanded(
                                            child: Container(
                                                padding: EdgeInsetsDirectional.only(
                                                    top: 32.h, start: 24.w, end: 24.w),
                                                child: FadingEdgeScrollView.fromSingleChildScrollView(
                                                  gradientFractionOnStart: 0.2,
                                                  gradientFractionOnEnd: 0.2,
                                                  child: SingleChildScrollView(
                                                    physics: AlwaysScrollableScrollPhysics(),
                                                    controller: model.scrollController,
                                                    child:
                                                        ((cardListData?.creditCards ?? []).isEmpty &&
                                                                (cardListData?.debitCards ?? []).isEmpty)
                                                            ? Center(
                                                                child: NoDataWidget(
                                                                  errorMessage:
                                                                      S.of(context).noCardsToDisplay,
                                                                ),
                                                              )
                                                            : Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  (cardListData?.creditCards ?? []).isNotEmpty
                                                                      ? Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              S.of(context).creditCard,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 14.t,
                                                                                  fontWeight:
                                                                                      FontWeight.w600),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            ListView.separated(
                                                                                shrinkWrap: true,
                                                                                physics:
                                                                                    NeverScrollableScrollPhysics(),
                                                                                itemBuilder:
                                                                                    (context, index) {
                                                                                  return Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment
                                                                                            .spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 124.w,
                                                                                        height: 190.h,
                                                                                        child: Image.asset(
                                                                                          AssetUtils
                                                                                              .cardCreditPng,
                                                                                          height: 190.h,
                                                                                          width: 124.w,
                                                                                        ),
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                        children: [
                                                                                          Text(
                                                                                            S
                                                                                                .of(context)
                                                                                                .rebelliousRedCreditCard,
                                                                                            textAlign:
                                                                                                TextAlign
                                                                                                    .start,
                                                                                            style: TextStyle(
                                                                                                fontFamily:
                                                                                                    StringUtils
                                                                                                        .appFont,
                                                                                                fontSize:
                                                                                                    16.t,
                                                                                                fontWeight:
                                                                                                    FontWeight
                                                                                                        .w600),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 16.h,
                                                                                          ),
                                                                                          (Platform.isIOS)
                                                                                              ? (antelopStepCompleted ??
                                                                                                      true)
                                                                                                  ? Container()

                                                                                                  ///show add to apple wallet button
                                                                                                  : (!(cardListData!.creditCards![index].isCardInApplePay) &&
                                                                                                          cardListData.creditCards![index].getStatus)
                                                                                                      ? InkWell(
                                                                                                          onTap:
                                                                                                              () {
                                                                                                            model.pushCardToAntelop(cardCode: (cardListData.creditCards?[index].cardCode ?? '').trim());
                                                                                                          },
                                                                                                          child:
                                                                                                              Image.asset(
                                                                                                            AssetUtils.addAppleWalletIconPng,
                                                                                                            height: 32.h,
                                                                                                            width: 104.w,
                                                                                                          ),
                                                                                                        )

                                                                                                      ///show added to apple wallet button
                                                                                                      : (cardListData.creditCards![index].isCardInApplePay)
                                                                                                          ? Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  S.of(context).addedTo,
                                                                                                                  style: TextStyle(fontSize: 14.t, fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: 9.w,
                                                                                                                ),
                                                                                                                InkWell(
                                                                                                                  onTap: () {
                                                                                                                    ///Pay
                                                                                                                  },
                                                                                                                  child: AppSvg.asset(AssetUtils.applePayButton),
                                                                                                                ),
                                                                                                              ],
                                                                                                            )
                                                                                                          : Container()
                                                                                              : Container()
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  );
                                                                                },
                                                                                separatorBuilder:
                                                                                    (context, int) {
                                                                                  return SizedBox(
                                                                                    height: 32.h,
                                                                                  );
                                                                                },
                                                                                itemCount: (cardListData
                                                                                            ?.creditCards ??
                                                                                        [])
                                                                                    .length),
                                                                            SizedBox(
                                                                              height: 32.h,
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Container(),
                                                                  (cardListData?.debitCards ?? []).isNotEmpty
                                                                      ? Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              S.of(context).debitCards,
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(
                                                                                  fontFamily:
                                                                                      StringUtils.appFont,
                                                                                  fontSize: 14.t,
                                                                                  fontWeight:
                                                                                      FontWeight.w600),
                                                                            ),
                                                                            SizedBox(
                                                                              height: 10.h,
                                                                            ),
                                                                            ListView.separated(
                                                                                shrinkWrap: true,
                                                                                physics:
                                                                                    NeverScrollableScrollPhysics(),
                                                                                itemBuilder:
                                                                                    (context, index) {
                                                                                  return Row(
                                                                                    mainAxisAlignment:
                                                                                        MainAxisAlignment
                                                                                            .spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: 124.w,
                                                                                        height: 190.h,
                                                                                        child: Image.asset(
                                                                                          AssetUtils
                                                                                              .cardDebitPng,
                                                                                          height: 190.h,
                                                                                          width: 124.w,
                                                                                        ),
                                                                                      ),
                                                                                      Column(
                                                                                        crossAxisAlignment:
                                                                                            CrossAxisAlignment
                                                                                                .start,
                                                                                        children: [
                                                                                          Text(
                                                                                            S
                                                                                                .of(context)
                                                                                                .yellowSunDebitCard,
                                                                                            textAlign:
                                                                                                TextAlign
                                                                                                    .start,
                                                                                            style: TextStyle(
                                                                                                fontFamily:
                                                                                                    StringUtils
                                                                                                        .appFont,
                                                                                                fontSize:
                                                                                                    16.t,
                                                                                                fontWeight:
                                                                                                    FontWeight
                                                                                                        .w600),
                                                                                          ),
                                                                                          SizedBox(
                                                                                            height: 16.h,
                                                                                          ),
                                                                                          (Platform.isIOS)
                                                                                              ? (antelopStepCompleted ??
                                                                                                      true)
                                                                                                  ? Container()

                                                                                                  ///show add to apple wallet button
                                                                                                  : (!(cardListData!.debitCards![index].isCardInApplePay) &&
                                                                                                          cardListData.debitCards![index].getStatus)
                                                                                                      ? InkWell(
                                                                                                          onTap:
                                                                                                              () {
                                                                                                            ///Add to apple wallet
                                                                                                            model.pushCardToAntelop(cardCode: (cardListData.debitCards?[index].code ?? '').trim());
                                                                                                          },
                                                                                                          child:
                                                                                                              Image.asset(
                                                                                                            AssetUtils.addAppleWalletIconPng,
                                                                                                            height: 32.h,
                                                                                                            width: 104.w,
                                                                                                          ),
                                                                                                        )

                                                                                                      ///show added to apple wallet button
                                                                                                      : (cardListData.debitCards![index].isCardInApplePay)
                                                                                                          ? Row(
                                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                                              children: [
                                                                                                                Text(
                                                                                                                  S.of(context).addedTo,
                                                                                                                  style: TextStyle(fontSize: 14.t, fontFamily: StringUtils.appFont, fontWeight: FontWeight.w600),
                                                                                                                ),
                                                                                                                SizedBox(
                                                                                                                  width: 9.w,
                                                                                                                ),
                                                                                                                InkWell(
                                                                                                                  onTap: () {
                                                                                                                    ///Pay
                                                                                                                  },
                                                                                                                  child: AppSvg.asset(AssetUtils.applePayButton),
                                                                                                                ),
                                                                                                              ],
                                                                                                            )
                                                                                                          : Container()
                                                                                              : Container()
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  );
                                                                                },
                                                                                separatorBuilder:
                                                                                    (context, int) {
                                                                                  return SizedBox(
                                                                                    height: 32.h,
                                                                                  );
                                                                                },
                                                                                itemCount: (cardListData
                                                                                            ?.debitCards ??
                                                                                        [])
                                                                                    .length),
                                                                          ],
                                                                        )
                                                                      : Container(),
                                                                ],
                                                              ),
                                                  ),
                                                )),
                                          );
                                        });
                                  });
                            });
                      }),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      // Navigator.pushNamed(context, RoutePaths.ApplePaySuccessAndErrorPage,
                      //     arguments: ApplePaySuccessAndErrorPageArguments(
                      //         title: S.of(context).yourNowSetWithApplePay,
                      //         titleDescription: S.of(context).yourAddOtherCardFromCardSettings,
                      //         successOrErrorIcon: AssetUtils.right));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 32.0.h),
                      child: Text(
                        S.of(context).backToDashboard,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColor.brightBlue,
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.t,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
