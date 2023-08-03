import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/constants/enum/card_type.dart';
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
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dashboard/bottom_bar_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/add_other_card_to_apple_wallet_page_dialog/add_other_card_to_apple_wallet_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/apple_pay_landing_page_dialog/apple_pay_landing_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/efawateer_landing_page_dialog/efawateer_landing_page_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/evoucher_landing_page_dialog/evoucher_landing_dialog.dart';
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

class AppHomePageView extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUps(model, context);
    return Padding(
      padding: EdgeInsets.only(top: 70.0.h),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return AppStreamBuilder<Resource<VerifyQrResponse>>(
              stream: model.verifyQRStream,
              onData: (data) async {
                if (data.status == Status.SUCCESS) {
                  model.showPopUps();
                  await Future.delayed(Duration(milliseconds: 500));
                  Navigator.pushNamed(context, RoutePaths.SendMoneyQrScanning,
                      arguments: SendMoneyQRScanningArguments(
                          source: 'Link',
                          requestId: data.data?.qrContent?.requestId ?? '',
                          amount: data.data?.qrContent?.amount ?? '',
                          accountHolderName: data.data?.qrContent?.accountHolderName ?? '',
                          accountNo: data.data?.qrContent?.toAccount ?? ''));
                } else if (data.status == Status.ERROR) {
                  model.showPopUps();
                }
              },
              initialData: Resource.none(),
              dataBuilder: (context, qrData) {
                return AppStreamBuilder<Resource<User>>(
                    stream: model.currentUser,
                    initialData: Resource.none(),
                    onData: (data) {
                      if (data.status == Status.SUCCESS) {
                        ///RJ Pop up
                        if (!(data.data?.isRJPopUPClicked ?? false) && (model.dashboardDataContent.dashboardFeatures?.isRJFeatureEnabled ?? true)) {
                          RjDialog.show(
                            context,
                            image: AssetUtils.flight,
                            title: S.of(context).bookFligtWithUs,
                            onSelected: () {},
                            onDismissed: () {
                              Navigator.pop(context);
                              data.data?.isRJPopUPClicked = true;
                              model.saveCurrentUserData(user: data.data!);
                            },
                            descriptionWidget: Text(
                              S.of(context).bookFligtWithUsDescrption,
                              textAlign: TextAlign.start,
                              style: TextStyle(fontFamily: StringUtils.appFont, color: Theme.of(context).colorScheme.surfaceVariant, fontSize: 14),
                            ),
                          );
                        }

                        ///Efawateer pop up
                        if (!(data.data?.isEfawateerPopUPClicked ?? false) && (model.dashboardDataContent.dashboardFeatures?.blinkRetailAppBillPayment ?? true)) {
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
                                Navigator.pushNamed(context, RoutePaths.PaymentHome, arguments: NavigationType.REQUEST_MONEY);
                              });
                        }

                        ///e-voucher pop up
                        if (!(data.data?.isEVoucherPopUPClicked ?? false) && (model.dashboardDataContent.dashboardFeatures?.eVouchers ?? true)) {
                          EvoucherDialog.show(context, isSwipeToCancel: true, onDismissed: () {
                            Navigator.pop(context);
                            data.data?.isEVoucherPopUPClicked = true;
                            model.saveCurrentUserData(user: data.data!);
                          }, onSelected: () {
                            Navigator.pop(context);
                            data.data?.isEVoucherPopUPClicked = true;
                            model.saveCurrentUserData(user: data.data!);
                            Navigator.pushNamed(context, RoutePaths.Evoucher);
                          });
                        }

                        ///Show account status pop up
                        if (model.dashboardDataContent.account?.accountStatusEnum == AccountStatusEnum.DORMANT) {
                          model.showAccountDormantPopUp(true);
                        }
                      }
                    },
                    dataBuilder: (context, progress) {
                      return AppStreamBuilder<Resource<GetDashboardDataResponse>>(
                          stream: model.getDashboardDataStream,
                          initialData: Resource.none(),
                          dataBuilder: (context, cardData) {
                            return AppStreamBuilder<bool>(
                                stream: model.accountDormantStatusPopUpStream,
                                initialData: false,
                                onData: (value) {
                                  if (value) {
                                    InformationDialog.show(context,
                                        image: AssetUtils.disclaimer,
                                        title: S.of(context).accountDormantTitle,
                                        doneImage: AssetUtils.contactUs,
                                        descriptionWidget: Text(
                                          S.of(context).accountDormantStatusDesc,
                                          style: TextStyle(color: Theme.of(context).colorScheme.surface, fontFamily: StringUtils.appFont, fontSize: 14.0.t, height: 1.7),
                                        ), onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: () {
                                      Navigator.pop(context);
                                      EngagementTeamDialog.show(context, onDismissed: () {
                                        Navigator.pop(context);
                                      }, onSelected: (value) {
                                        Navigator.pop(context);
                                      });
                                    });
                                  }
                                },
                                dataBuilder: (context, accountStatus) {
                                  return AppStreamBuilder<bool>(
                                      stream: model.applePayPopUpStream,
                                      initialData: false,
                                      onData: (value) {
                                        if (value && Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled && isAllCardsInApplePay && (model.debitCards.isNotEmpty || model.creditCards.isNotEmpty)) {
                                          ApplePayDialog.show(context, image: AssetUtils.applePayLogo, title: S.of(context).blinkWithApplePay, onSelected: () {
                                            Navigator.pop(context);
                                            Navigator.pushNamed(context, RoutePaths.SelectedCardForApplePayPage,
                                                arguments: SelectedCardsForApplePayPageArguments(debitCards: model.debitCards, creditCards: model.creditCards));
                                          }, onDismissed: () {
                                            Navigator.pop(context);
                                          },
                                              descriptionWidget: Text(
                                                S.of(context).blinkWithApplePayLandingDialogDescription,
                                                style: TextStyle(color: AppColor.veryDarkGray2, fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w400),
                                              ));
                                        }
                                      },
                                      dataBuilder: (context, value) {
                                        return AppStreamBuilder<bool>(
                                            stream: model.showAddAnotherCardToApplePayPopUpStream,
                                            initialData: false,
                                            onData: (value) {
                                              if (value && Platform.isIOS && AppConstantsUtils.isApplePayFeatureEnabled && isAllCardsInApplePay) {
                                                AddOtherCardToAppleWalletDialog.show(context,
                                                    title: S.of(context).addOtherCardToAppleWallet,
                                                    image: AssetUtils.applePayButton,
                                                    descriptionWidget: Text(
                                                      S.of(context).addOtherCardToAppleWalletDialogDescription,
                                                      style: TextStyle(color: AppColor.veryDarkGray1, fontFamily: StringUtils.appFont, fontSize: 14.t, fontWeight: FontWeight.w400),
                                                    ), onSelected: () {
                                                  Navigator.pop(context);
                                                  Navigator.pushNamed(context, RoutePaths.SelectedCardForApplePayPage,
                                                      arguments: SelectedCardsForApplePayPageArguments(debitCards: model.debitCards, creditCards: model.creditCards));
                                                }, onDismissed: () {
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            dataBuilder: (context, addAnotherCardToAppleWallet) {
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
                                                        } else if (model.cardTypeList[currentStep].cardType == CardType.CREDIT && model.cardTypeList[currentStep].swipeUpEnum == SwipeUpEnum.SWIPE_UP_YES) {
                                                          Navigator.pushNamed(context, RoutePaths.CardTransaction,
                                                              arguments: GetCreditCardTransactionArguments(cardId: model.timeLineListArguments[currentStep - 1].cardId));
                                                        }
                                                      } else {
                                                        if (details.primaryVelocity! > 0.5) {
                                                          if (!showTimeLine!) {
                                                            Navigator.pushNamed(context, RoutePaths.TimeLinePage,
                                                                arguments: TimeLinePageArguments(cardType: model.cardTypeList[currentStep!].cardType, timeLineArguments: model.timeLineArguments));
                                                          }
                                                        }
                                                      }
                                                    },
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          S.of(context).totalBalance,
                                                          style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w400, fontSize: 18.0.t, color: AppColor.black),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 5.0.h),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text('${cardData!.data!.dashboardDataContent!.account!.availableBalance!} ',
                                                                  style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 24.0.t, fontWeight: FontWeight.w700, color: Theme.of(context).primaryColorDark)),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 5.0.h, left: 5.0.w),
                                                                child: Text(S.of(context).JOD,
                                                                    style: TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w700, fontSize: 14.0.t, color: AppColor.verLightGray4)),
                                                              )
                                                            ],
                                                          ),
                                                        ),
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
                                                                      stream: ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardCardDataStream,
                                                                      initialData: GetDashboardDataContent(),
                                                                      dataBuilder: (context, cardData) {
                                                                        if (cardData!.account!.accountNo == null) {
                                                                          return SizedBox();
                                                                        }

                                                                        // return getPageController(model);
                                                                        return DashboardSwiper(
                                                                          pages: pagesList,
                                                                          appSwiperController: model.appSwiperController,
                                                                          pageController: model.pageController,
                                                                          onIndexChanged: (index) {
                                                                            model.updatePage(index);
                                                                            model.updatePageControllerStream(index);
                                                                          },
                                                                          currentStep: currentStep,
                                                                          translateSidewaysController: model.translateSidewaysController,
                                                                          model : model,
                                                                        );
                                                                      });
                                                                }),
                                                          ),
                                                        ),
                                                        // const SizedBox(height: 0.0),
                                                        SizedBox(
                                                          height: MediaQuery.of(context).size.height * 0.03,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: model.buildPageIndicator(currentStep!, cardData.data!.dashboardDataContent!.debitCard!.length),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 24.0.h, bottom: 0.0.h),
                                                          child: BottomBarWidget(
                                                            onHomeTap: () {
                                                              model.moveToPage(0);
                                                            },
                                                            onMoreTap: () {
                                                              SettingsDialog.show(
                                                                context,
                                                              );
                                                            },
                                                            onContactUsTap: () {
                                                              EngagementTeamDialog.show(context, onDismissed: () {
                                                                Navigator.pop(context);
                                                              }, onSelected: (value) {
                                                                Navigator.pop(context);
                                                              });
                                                            },
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
        showDialog(context: context, barrierDismissible: false, builder: (context) => popUpWidget(context, model.requestMoneyPlaceholderData.image));
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
