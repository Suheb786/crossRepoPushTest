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
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/app_home_page_widgets.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/custom_svg_image.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
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

import '../../credit_card_pay_back/credit_card_pay_back_page.dart';

class AppHomePageViewNew extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageViewNew(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUps(model, context);
    return Padding(
      padding: EdgeInsets.only(top: 0.0.h),
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
                                                  return AppStreamBuilder<List>(
                                                      stream: model.pageStream,
                                                      initialData: [Container()],
                                                      dataBuilder: (context, pagesList) {
                                                        return Stack(
                                                          children: [
                                                            ///Settings page
                                                            ///Timeline page
                                                            AnimatedSwitcher(
                                                              duration: const Duration(milliseconds: 500),
                                                              reverseDuration: const Duration(milliseconds: 400),
                                                              switchInCurve: Curves.easeInOut,
                                                              switchOutCurve: Curves.linearToEaseOut,
                                                              child: model.settings
                                                                  ? DebitCardSettingsPage(DebitCardSettingsArguments(
                                                                      accountStatusEnum: cardData?.data?.dashboardDataContent?.account?.accountStatusEnum ?? AccountStatusEnum.NONE,
                                                                      isPrimaryDebitCard: model.isPrimaryDebitCard,
                                                                      debitCard: model.selectedDebitCard,
                                                                      debitCardRequestPhysicalCardEnabled: cardData?.data?.dashboardDataContent?.dashboardFeatures?.isDebitCardRequestPhysicalCardEnabled ?? false))
                                                                  : showTimeLine!
                                                                      ? const SizedBox()
                                                                      : model.timelinePage
                                                                          ? DebitCardTimeLinePage(TimeLinePageArguments(cardType: model.cardTypeList[currentStep!].cardType, timeLineArguments: model.timeLineArguments))
                                                                          : model.showPayBackView
                                                                              ? CreditCardPayBackPage(
                                                                                  CreditCardPayBackArguments(
                                                                                      accountHolderName: model.selectedCreditCard.name!,
                                                                                      secureCode: model.selectedCreditCard.cardCode!,
                                                                                      accountBalance: cardData!.data!.dashboardDataContent!.account!.availableBalance!,
                                                                                      minDuePayBackAmount: model.selectedCreditCard.paymentDueAmount.toString(),
                                                                                      totalMinDueAmount: model.selectedCreditCard.usedBalance!),
                                                                                )
                                                                              : const SizedBox(),
                                                            ),
                                                            AnimatedBuilder(
                                                              animation: model.translateTimelineDownController,
                                                              child: AnimatedBuilder(
                                                                  animation: model.translateSettingsUpController,
                                                                  child: SafeArea(
                                                                    child: Container(
                                                                      color: model.settings ? Colors.white : Colors.transparent,
                                                                      margin: EdgeInsets.only(bottom: model.timelinePage ? 0 : model.constBottomBarHeight),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                        children: [
                                                                          AnimatedOpacity(
                                                                            duration: const Duration(milliseconds: 500),
                                                                            opacity: model.timelinePage ? 0 : 1,
                                                                            child: AppHomePageWidgets.totalBalance(cardData!.data!.dashboardDataContent!.account!.availableBalance!),
                                                                          ),
                                                                          Expanded(
                                                                            child: Stack(
                                                                              alignment: Alignment.topCenter,
                                                                              children: [
                                                                                Positioned.fill(
                                                                                  child: DashboardSwiper(
                                                                                    pages: pagesList,
                                                                                    appSwiperController: model.appSwiperController,
                                                                                    pageController: model.pageController,
                                                                                    onIndexChanged: (index) {
                                                                                      model.pageViewIndex = index;
                                                                                      model.updatePage(index);
                                                                                      model.updatePageControllerStream(index);
                                                                                    },
                                                                                    currentStep: currentStep,
                                                                                    translateSidewaysController: model.translateSidewaysController,
                                                                                    model: model,
                                                                                  ),
                                                                                ),

                                                                                ///Transactions button
                                                                                ///For My Account and My credit card
                                                                                Positioned(
                                                                                  bottom: 20,
                                                                                  child: model.myDebitCard

                                                                                      ///No transaction button for debit card
                                                                                      ? const SizedBox()
                                                                                      : InkWell(
                                                                                          splashColor: Colors.transparent,
                                                                                          highlightColor: Colors.transparent,
                                                                                          onTap: () {
                                                                                            /*if (model.myCreditCard) {
                                                                                              if (model.settings) {
                                                                                                model.showSettingPage(false);
                                                                                                return;
                                                                                              }

                                                                                              if (model.showPayBackView) {
                                                                                                model.goToPayBackView(false);
                                                                                                return;
                                                                                              }

                                                                                              if (context.read<LayoutViewModel>().showButtonsInCreditCard) {
                                                                                                model.goToTransactionPage(context);
                                                                                                return;
                                                                                              }
                                                                                            }
                                                                                            if (myAccount) {
                                                                                              ///TODO:
                                                                                            }*/
                                                                                          },
                                                                                          child: AnimatedOpacity(
                                                                                            ///For credit card
                                                                                            duration: const Duration(milliseconds: 500),
                                                                                            opacity: model.myCreditCard ? 0 : 1,
                                                                                            child: AnimatedBuilder(
                                                                                              animation: model.appSwiperController,
                                                                                              builder: (BuildContext context, Widget? child) {
                                                                                                double translateYOffset = 0;
                                                                                                double opacity = 0;
                                                                                                if (model.appSwiperController.hasClients) if (model.appSwiperController.position.hasContentDimensions) {
                                                                                                  opacity = model.pageViewIndex - (model.appSwiperController.page ?? 0);
                                                                                                  translateYOffset = model.pageViewIndex - (model.appSwiperController.page ?? 0);
                                                                                                }
                                                                                                return Transform.translate(
                                                                                                  offset: Offset(0, translateYOffset.abs() * 40),
                                                                                                  child: Opacity(
                                                                                                    opacity: (opacity.abs() - 1).abs(),
                                                                                                    child: child!,
                                                                                                  ),
                                                                                                );
                                                                                              },

                                                                                              ///For credit card
                                                                                              child: AnimatedContainer(
                                                                                                duration: const Duration(milliseconds: 500),
                                                                                                curve: Curves.easeInOut,
                                                                                                width: model.settings || model.showPayBackView ? 48 : 150,
                                                                                                height: model.settings || model.showPayBackView ? 48 : 44,
                                                                                                alignment: Alignment.center,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Colors.white,
                                                                                                  border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                                                                                                  borderRadius: BorderRadius.circular(100),
                                                                                                  boxShadow: [
                                                                                                    BoxShadow(color: Theme.of(context).colorScheme.inverseSurface, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 4))
                                                                                                  ],
                                                                                                ),
                                                                                                child: AnimatedCrossFade(
                                                                                                  duration: const Duration(milliseconds: 500),
                                                                                                  reverseDuration: const Duration(milliseconds: 500),
                                                                                                  firstCurve: Curves.easeIn,
                                                                                                  secondCurve: Curves.easeIn,
                                                                                                  alignment: Alignment.center,
                                                                                                  crossFadeState: model.settings || model.showPayBackView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                                                                  firstChild: const SVGImage(assetPath: "assets/icons/down.svg"),
                                                                                                  secondChild: const Text(
                                                                                                    "Transactions",
                                                                                                    style: TextStyle(color: AppColor.skyblue, fontSize: 12, fontWeight: FontWeight.w600),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                ),

                                                                                ///Timeline Button
                                                                                ///For My Account and My credit card
                                                                                Positioned(
                                                                                  top: 20,
                                                                                  child: InkWell(
                                                                                    splashColor: Colors.transparent,
                                                                                    highlightColor: Colors.transparent,
                                                                                    onTap: () {
                                                                                      /*if (model.myCreditCard) {
                                                                                        if (!context.read<LayoutViewModel>().showButtonsInCreditCard) return;
                                                                                        context
                                                                                            .read<DashboardViewModel>()
                                                                                            .showTimeline(!context.read<DashboardViewModel>().timelinePage);
                                                                                      }*/
                                                                                      /*if (myAccount) {
                                                                                        //TODO:
                                                                                      }*/
                                                                                    },
                                                                                    child: AnimatedOpacity(
                                                                                      ///For Credit Card
                                                                                      duration: const Duration(milliseconds: 500),
                                                                                      opacity: (/*!context.watch<LayoutViewModel>().showButtonsInCreditCard && */ model.myCreditCard) ||
                                                                                              (/*!context.watch<LayoutViewModel>().showButtonsInDebitCard && */ model.myDebitCard)
                                                                                          ? 0
                                                                                          : 1,
                                                                                      child: AnimatedBuilder(
                                                                                        animation: model.appSwiperController,
                                                                                        builder: (BuildContext context, Widget? child) {
                                                                                          double translateYOffset = 0;
                                                                                          double opacity = 0;
                                                                                          if (model.appSwiperController.positions.isNotEmpty) {
                                                                                            opacity = model.pageViewIndex - (model.appSwiperController.page ?? 0);
                                                                                            translateYOffset = model.pageViewIndex - (model.appSwiperController.page ?? 0);
                                                                                          }
                                                                                          return Transform.translate(
                                                                                            offset: Offset(0, translateYOffset.abs() * -40),
                                                                                            child: Opacity(
                                                                                              opacity: (opacity.abs() - 1).abs(),
                                                                                              child: child!,
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                        child: Container(
                                                                                          height: 48,
                                                                                          width: 48,
                                                                                          padding: const EdgeInsets.all(10),
                                                                                          decoration: BoxDecoration(
                                                                                              shape: BoxShape.circle,
                                                                                              color: Colors.white,
                                                                                              border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1)),
                                                                                          //child: const SVGImage(assetPath: "assets/icons/audioWave.svg"),
                                                                                          ///For Credit Card
                                                                                          child: AnimatedSwitcher(
                                                                                            duration: const Duration(milliseconds: 500),
                                                                                            child: !model.timelinePage
                                                                                                ? const SVGImage(assetPath: "assets/icons/audioWave.svg")
                                                                                                : const SVGImage(assetPath: "assets/icons/up.svg"),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height: MediaQuery.of(context).size.height * 0.03,
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: model.buildPageIndicator(currentStep!, cardData.data!.dashboardDataContent!.debitCard!.length),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  builder: (context, child) {
                                                                    return Transform.translate(
                                                                      //offset: Offset(0, model.animation.value* (-MediaQuery.of(context).size.height*0.65)),
                                                                      offset: Offset(0, model.animation.value * (-MediaQuery.of(context).size.height * 0.7)),
                                                                      child: Transform.scale(
                                                                        scale: model.scaleAnimationController.value,
                                                                        child: child,
                                                                      ),
                                                                    );
                                                                  }),
                                                              builder: (context, child) {
                                                                ///Timeline animation
                                                                return Transform.translate(
                                                                  offset: Offset(0, model.translateTimelineDownController.value * (MediaQuery.of(context).size.height * 0.65)),
                                                                  child: child,
                                                                );
                                                              },
                                                            ),

                                                            Positioned(
                                                              bottom: 0,
                                                              child: Center(
                                                                child: Container(
                                                                  padding: EdgeInsets.only(top: 24.0.h),
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
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
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
