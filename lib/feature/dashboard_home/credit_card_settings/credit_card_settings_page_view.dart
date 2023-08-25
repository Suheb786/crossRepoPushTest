import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/enum/freeze_card_status_enum.dart';
import 'package:domain/constants/enum/primary_secondary_card_enum.dart';
import 'package:domain/model/apple_pay/get_all_card_data.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/apple_pay/apple_pay_success/apple_pay_success_and_error_page.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/card/settings_tile.dart';
import 'package:neo_bank/ui/molecules/custom_bullet_with_title_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditCardSettingsPageView extends BasePageViewWidget<CreditCardSettingsViewModel> {
  CreditCardSettingsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.035, vertical: 22.h),
      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.14) - 22.h),
      child: Column(
        children: [
          Platform.isIOS
              ? AppStreamBuilder<bool>(
                  stream: antelopStepCompletedStream,
                  initialData: true,
                  onData: (value) {
                    if (!value) {
                      List<GetAllCardData> antelopIssuerCardList = listOfCardFromAntelop.value;

                      for (int j = 0; j < antelopIssuerCardList.length; j++) {
                        if (antelopIssuerCardList[j].getIssuerCardId?.trim() ==
                            model.creditCardSettingsArguments.creditCard.cardCode?.trim()) {
                          // model.creditCardSettingsArguments.creditCard.isCardInApplePay = true;
                          model.creditCardSettingsArguments.creditCard.isCardInApplePay =
                              antelopIssuerCardList[j].isCardInApplePay ?? false;
                          model.creditCardSettingsArguments.creditCard.getStatus =
                              antelopIssuerCardList[j].getStatus ?? false;
                        }
                      }
                    }
                  },
                  dataBuilder: (context, antelopStepCompleted) {
                    return Padding(
                      padding: EdgeInsetsDirectional.only(top: 24.h, bottom: 6.h),
                      child: (antelopStepCompleted ?? true)
                          ? const SizedBox()
                          : (!(model.creditCardSettingsArguments.creditCard.isCardInApplePay) &&
                                  model.creditCardSettingsArguments.creditCard.getStatus)
                              ? InkWell(
                                  onTap: () {
                                    debugPrint('Adding to apple wallet---------');
                                    model.pushCardToAntelop(
                                        cardCode:
                                            (model.creditCardSettingsArguments.creditCard.cardCode ?? '')
                                                .trim());
                                  },
                                  child: Image.asset(
                                    AssetUtils.addAppleWalletIconPng,
                                    height: 32.h,
                                    width: 104.w,
                                  ),
                                )
                              : (model.creditCardSettingsArguments.creditCard.isCardInApplePay)
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          S.of(context).addedTo,
                                          style: TextStyle(
                                              fontSize: 14.t,
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w600),
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
                                  : const SizedBox(),
                    );
                  })
              : const SizedBox(),
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
                      return const SizedBox();
                    });
              }),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: FadingEdgeScrollView.fromSingleChildScrollView(
              shouldDisposeScrollController: true,
              gradientFractionOnStart: 0.35,
              gradientFractionOnEnd: 0.2,
              child: SingleChildScrollView(
                controller: model.controller,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    AppStreamBuilder<bool>(
                        stream: model.showDialogStream,
                        initialData: false,
                        onData: (showDialog) {
                          if (showDialog) {
                            InformationDialog.show(context,
                                image: AssetUtils.cardFreeze,
                                title: S.of(context).freezeTheCard,
                                descriptionWidget: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(start: 8.0.w, bottom: 10.h),
                                      child: Text(S.of(context).acknowledgeBeforeFreezingCard,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont, fontSize: 14.t, height: 1.7)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                                      child: CustomBulletWithTitle(
                                        title: S.of(context).cardcantBeUsedForTransactions,
                                        fontSize: 14.t,
                                        lineHeight: 1.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                                      child: CustomBulletWithTitle(
                                        title: S.of(context).directDebitsWontBeMade,
                                        fontSize: 14.t,
                                        lineHeight: 1.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                                      child: CustomBulletWithTitle(
                                        title: S.of(context).freezeAndActiveAtAnyTime,
                                        fontSize: 14.t,
                                        lineHeight: 1.7,
                                      ),
                                    ),
                                  ],
                                ), onSelected: () {
                              Navigator.pop(context);
                              model.freezeCard(model.creditCardSettingsArguments.creditCard.cardId ?? '');
                            }, onDismissed: () {
                              Navigator.pop(context);
                              model.freezeCardStatus(false);
                            });
                          }
                        },
                        dataBuilder: (context, snapshot) {
                          return AppStreamBuilder<bool>(
                            stream: model.freezeCardStream,
                            initialData: model.creditCardSettingsArguments.creditCard.cardStatus ==
                                    FreezeCardStatusEnum.F
                                ? true
                                : false,
                            onData: (value) {},
                            dataBuilder: (context, data) {
                              return SettingTile(
                                onTap: () {
                                  model.toggleFreezeCardStatus(!data!);
                                },
                                title: S.of(context).freezeThisCard,
                                tileIcon: AssetUtils.freeze,
                                isCardActivated:
                                    model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                                trailing: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: FlutterSwitch(
                                    value: model.creditCardSettingsArguments.creditCard.isCreditDelivered ??
                                            false
                                        ? data!
                                        : false,
                                    onToggle: model
                                                .creditCardSettingsArguments.creditCard.isCreditDelivered ??
                                            false
                                        ? (value) {
                                            if (value) {
                                              model.updateShowDialog(true);
                                            }
                                            model.toggleFreezeCardStatus(value);
                                            if (!value) {
                                              model.unFreezeCard(
                                                  model.creditCardSettingsArguments.creditCard.cardId ?? '');
                                            }
                                          }
                                        : (v) {},
                                    width: 60.w,
                                    height: 35.h,
                                    padding: 4,
                                    activeText: S.of(context).yes.toUpperCase(),
                                    activeTextColor: AppColor.white,
                                    inactiveTextColor: AppColor.darkGray,
                                    activeTextFontWeight: FontWeight.w500,
                                    showOnOff: true,
                                    valueFontSize: 10.t,
                                    activeToggleColor: AppColor.white,
                                    inactiveText: S.of(context).no.toUpperCase(),
                                    inactiveToggleColor: AppColor.lightGrayishMagenta,
                                    inactiveTextFontWeight: FontWeight.w500,
                                    inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
                                    activeColor: Theme.of(context).textTheme.bodyLarge!.color!,
                                    inactiveColor: Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                    SettingTile(
                      isCardActivated:
                          model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                      isEnabled: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.PRIMARY,
                      isNotify: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.SECONDARY,
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.ManageCreditCardLimits,
                            arguments: ManageCreditCardLimitsArguments(
                                secureCode: model.creditCardSettingsArguments.creditCard.cardCode ?? '',
                                creditDeliveredDatetime:
                                    model.creditCardSettingsArguments.creditCard.creditDeliveredDatetime));
                      },
                      title: S.of(context).manageCardLimits,
                      tileIcon: AssetUtils.settingBars,
                    ),
                    SettingTile(
                      isCardActivated:
                          model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                      onTap: () {
                        Navigator.of(context).push(CustomRoute.swipeUpRoute(ManageCreditSettlementPage(
                            manageCreditSettlementArguments: ManageCreditSettlementArguments(
                                creditCard: model.creditCardSettingsArguments.creditCard))));
                      },
                      title: S.of(context).manageSettlement,
                      tileIcon: AssetUtils.linked,
                      isEnabled: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.PRIMARY,
                      isNotify: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.SECONDARY,
                    ),
                    SettingTile(
                      isNotify: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.SECONDARY,
                      isCardActivated:
                          model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                      isEnabled: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                          PrimarySecondaryCardEnum.PRIMARY,
                      onTap: () {
                        Navigator.pushNamed(context, RoutePaths.ManageCardPin,
                            arguments: ManageCardPinArguments(
                                isChangePinEnabled: model.creditCardSettingsArguments.isChangePinEnabled,
                                cardType: CardType.CREDIT,
                                tokenizedPan: model.creditCardSettingsArguments.creditCard.cardCode ?? '',
                                freezeCardStatusEnum:
                                    model.creditCardSettingsArguments.creditCard.cardStatus ??
                                        FreezeCardStatusEnum.NONE,
                                cardNumber: model.creditCardSettingsArguments.creditCard.cardNumber ?? ''));
                      },
                      title: S.of(context).manageCardPin,
                      tileIcon: AssetUtils.cardShield,
                    ),

                    ///Commented the below flow as service is not available
                    // IgnorePointer(
                    //   child: SettingTile(
                    //     isCardActivated:
                    //         model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //     onTap: () {
                    //       Navigator.pushNamed(context, RoutePaths.ViewDebitCardSubscription,
                    //           arguments: ViewDebitCardSubscriptionArguments(cardType: CardType.CREDIT));
                    //     },
                    //     title: S.of(context).viewCardSubscription,
                    //     tileIcon: AssetUtils.cardSubscription,
                    //     isEnabled: false,
                    //     isNotify: true,
                    //   ),
                    // ),
                    // AppStreamBuilder<bool>(
                    //     stream: model.routeSupplementaryStream,
                    //     initialData: false,
                    //     onData: (route) {
                    //       if (route) {
                    //         Navigator.pushReplacementNamed(
                    //             context, RoutePaths.SupplementaryCreditCardActivationStatus,
                    //             arguments: SupplementaryCreditCardActivationArguments(
                    //                 primaryCardId:
                    //                     model.creditCardSettingsArguments.creditCard.cardId ?? ''));
                    //       } else {
                    //         ProviderScope.containerOf(context)
                    //             .read(appHomeViewModelProvider)
                    //             .currentCreditCard = model.creditCardSettingsArguments.creditCard;
                    //         Navigator.pushNamed(context, RoutePaths.SupplementaryCreditCard);
                    //       }
                    //     },
                    //     dataBuilder: (context, snapshot) {
                    //       return AppStreamBuilder<Resource<SupplementaryCreditCardApplicationResponse>>(
                    //           stream: model.getSupplementaryCreditCardApplicationStream,
                    //           initialData: Resource.none(),
                    //           onData: (data) {},
                    //           dataBuilder: (context, supplementaryCreditCardApplication) {
                    //             return SettingTile(
                    //               onTap: () {
                    //                 model.getSupplementaryCreditCardApplication();
                    //               },
                    //               isEnabled: false,
                    //               isNotify: true,
                    //               // isEnabled:
                    //               //     model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //               //         PrimarySecondaryCardEnum.PRIMARY,
                    //               // isNotify:
                    //               //     model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //               //         PrimarySecondaryCardEnum.SECONDARY,
                    //               title: S.of(context).requestSupplementarycard,
                    //               tileIcon: AssetUtils.cardIcon,
                    //               isCardActivated:
                    //                   model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //             );
                    //           });
                    //     }),
                    // IgnorePointer(
                    //   child: SettingTile(
                    //     isCardActivated:
                    //         model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //     onTap: () {
                    //       Navigator.pushNamed(context, RoutePaths.ChangeCreditLimit);
                    //     },
                    //     title: S.of(context).changeCreditLimit,
                    //     tileIcon: AssetUtils.add,
                    //     isEnabled: false,
                    //     isNotify: true,
                    //   ),
                    // ),
                    // IgnorePointer(
                    //   child: SettingTile(
                    //     isCardActivated:
                    //         model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //     onTap: () {
                    //       Navigator.pushNamed(context, RoutePaths.ConvertPurchaseToInstallments);
                    //     },
                    //     title: S.of(context).convertPurchaseToInstallments,
                    //     tileIcon: AssetUtils.chart,
                    //     isEnabled: false,
                    //     isNotify: true,
                    //   ),
                    // ),
                    // IgnorePointer(
                    //   child: SettingTile(
                    //     isCardActivated:
                    //         model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //     onTap: () {
                    //       Navigator.pushNamed(context, RoutePaths.DcChangeLinkedMobileNumber,
                    //           arguments: DCChangeLinkedMobileNumberArguments(
                    //               cardType: CardType.CREDIT,
                    //               tokenizedPan: model.creditCardSettingsArguments.creditCard.cardCode));
                    //     },
                    //     title: S.of(context).changeLinkedMobileNumber,
                    //     tileIcon: AssetUtils.mobile,
                    //     isEnabled: false,
                    //     isNotify: true,
                    //   ),
                    // ),
                    // IgnorePointer(
                    //   child: SettingTile(
                    //     isCardActivated:
                    //         model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //     onTap: () {
                    //       Navigator.pushNamed(context, RoutePaths.ChangeCountryRestriction);
                    //     },
                    //     title: S.of(context).changeCountryRestriction,
                    //     tileIcon: AssetUtils.globe,
                    //     isEnabled: false,
                    //     isNotify: true,
                    //   ),
                    // ),
                    // AppStreamBuilder<Resource<bool>>(
                    //     stream: model.reportLostStolenCCStream,
                    //     initialData: Resource.none(),
                    //     onData: (data) {
                    //       if (data.status == Status.SUCCESS) {
                    //         Navigator.pushNamed(context, RoutePaths.CreditCardApplySuccess,
                    //             arguments: CreditCardApplySuccessArguments(
                    //                 creditSuccessState: CreditSuccessState.Applied_Success));
                    //       }
                    //     },
                    //     dataBuilder: (context, snapshot) {
                    //       return SettingTile(
                    //         isCardActivated:
                    //             model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //         onTap: () {
                    //           InformationDialog.show(context,
                    //               image: AssetUtils.cardCancelIcon,
                    //               title: S.of(context).reportCardIssue,
                    //               descriptionWidget: Text(
                    //                 S.of(context).reportStolenLostCardDesc,
                    //                 style: TextStyle(
                    //                     fontFamily: StringUtils.appFont,
                    //                     fontSize: 14.t,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: AppColor.dark_brown),
                    //               ), onSelected: () {
                    //             Navigator.pop(context);
                    //             // Navigator.pushNamed(
                    //             //     context, RoutePaths.RenewCreditCard);
                    //             model.reportLostStolenCC();
                    //           }, onDismissed: () {
                    //             Navigator.pop(context);
                    //           });
                    //         },
                    //         title: S.of(context).reportCardIssue,
                    //         tileIcon: AssetUtils.report,
                    //         // isEnabled:
                    //         //     model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //         //         PrimarySecondaryCardEnum.PRIMARY,
                    //         // isNotify: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //         //     PrimarySecondaryCardEnum.SECONDARY,
                    //         isEnabled: false,
                    //         isNotify: true,
                    //       );
                    //     }),
                    // AppStreamBuilder<Resource<bool>>(
                    //     stream: model.reportDamagedCCStream,
                    //     initialData: Resource.none(),
                    //     onData: (data) {
                    //       if (data.status == Status.SUCCESS) {
                    //         Navigator.pushNamed(context, RoutePaths.CreditCardApplySuccess,
                    //             arguments: CreditCardApplySuccessArguments(
                    //                 creditSuccessState: CreditSuccessState.Applied_Success));
                    //       }
                    //     },
                    //     dataBuilder: (context, snapshot) {
                    //       return SettingTile(
                    //         isCardActivated:
                    //             model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //         onTap: () {
                    //           InformationDialog.show(context,
                    //               image: AssetUtils.cardCancelIcon,
                    //               title: S.of(context).replaceDamageCard,
                    //               descriptionWidget: Text(
                    //                 S.of(context).reportStolenLostCardDesc,
                    //                 style: TextStyle(
                    //                     fontFamily: StringUtils.appFont,
                    //                     fontSize: 14.t,
                    //                     fontWeight: FontWeight.w400,
                    //                     color: AppColor.dark_brown),
                    //               ), onSelected: () {
                    //             Navigator.pop(context);
                    //             model.reportDamagedCC();
                    //           }, onDismissed: () {
                    //             Navigator.pop(context);
                    //           });
                    //         },
                    //         title: S.of(context).replaceDamageCard,
                    //         tileIcon: AssetUtils.damageCard,
                    //         // isEnabled:
                    //         //     model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //         //         PrimarySecondaryCardEnum.PRIMARY,
                    //         // isNotify: model.creditCardSettingsArguments.creditCard.primarySecondaryCard ==
                    //         //     PrimarySecondaryCardEnum.SECONDARY,
                    //         isEnabled: false,
                    //         isNotify: true,
                    //       );
                    //     }),
                    // IgnorePointer(
                    //   child: AppStreamBuilder<Resource<bool>>(
                    //     initialData: Resource.none(),
                    //     stream: model.cancelCreditCardStream,
                    //     onData: (data) {},
                    //     dataBuilder: (context, data) {
                    //       return SettingTile(
                    //         isCardActivated:
                    //             model.creditCardSettingsArguments.creditCard.isCreditDelivered ?? false,
                    //         isNotify: true,
                    //         isEnabled: false,
                    //         onTap: () {
                    //           CardCancelDialog.show(context, onSelected: (reasonValue, needsReplacement) {
                    //             Navigator.pop(context);
                    //             model.cancelCard(reasonValue);
                    //           }, onDismissed: () {
                    //             Navigator.pop(context);
                    //           }, onError: (AppError error) {
                    //             model.showToastWithError(error);
                    //           },
                    //               reasons: StringUtils.isDirectionRTL(context)
                    //                   ? model.creditCardCancellationReasonAr
                    //                   : model.creditCardCancellationReasonEn);
                    //         },
                    //         title: S.of(context).cancelThisCard,
                    //         tileIcon: AssetUtils.cancelCard,
                    //       );
                    //     },
                    //   ),
                    // ),
                    // SizedBox(height: 15.h),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 63.0.w),
                    //   child: Text(
                    //     S.of(context).actionComeToYouSoon,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       fontFamily: StringUtils.appFont,
                    //       color: AppColor.gray_1,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 11.t,
                    //     ),
                    //   ),
                    // ),

                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
