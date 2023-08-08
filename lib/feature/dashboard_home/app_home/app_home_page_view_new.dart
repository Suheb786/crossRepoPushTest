import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/app_home_page_widgets.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/custom_svg_image.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/add_other_card_to_apple_wallet_page_dialog/add_other_card_to_apple_wallet_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/apple_pay_landing_page_dialog/apple_pay_landing_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
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

import '../../../ui/molecules/app_svg.dart';
import '../../credit_card_pay_back/credit_card_pay_back_page.dart';
import '../credit_card_settings/credit_card_settings_page.dart';

class AppHomePageViewNew extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageViewNew(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    listenPopUps(model, context);
    return AppStreamBuilder<int>(
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
                                                      return Column(
                                                        children: [
                                                          Expanded(
                                                            child: Stack(
                                                              alignment: Alignment.bottomCenter,
                                                              children: [
                                                                ///Settings page
                                                                ///Timeline page
                                                                AnimatedSwitcher(
                                                                  duration: const Duration(milliseconds: 500),
                                                                  reverseDuration: const Duration(milliseconds: 400),
                                                                  switchInCurve: Curves.easeInOut,
                                                                  switchOutCurve: Curves.linearToEaseOut,
                                                                  child: model.settings
                                                                      ? model.selectedDebitCard != null
                                                                          ? DebitCardSettingsPage(DebitCardSettingsArguments(
                                                                              accountStatusEnum: cardData?.data?.dashboardDataContent?.account?.accountStatusEnum ?? AccountStatusEnum.NONE,
                                                                              isPrimaryDebitCard: model.isPrimaryDebitCard,
                                                                              debitCard: model.selectedDebitCard!,
                                                                              debitCardRequestPhysicalCardEnabled: cardData?.data?.dashboardDataContent?.dashboardFeatures?.isDebitCardRequestPhysicalCardEnabled ?? false))
                                                                          : CreditCardSettingsPage(CreditCardSettingsArguments(
                                                                              creditCard: model.selectedCreditCard!,
                                                                              isChangePinEnabled: cardData?.data?.dashboardDataContent?.dashboardFeatures?.isPinChangeEnabled ?? true))
                                                                      : model.timelinePage
                                                                          ? DebitCardTimeLinePage(TimeLinePageArguments(cardType: model.cardTypeList[currentStep!].cardType, timeLineArguments: model.timeLineArguments))
                                                                          : model.showPayBackView
                                                                              ? CreditCardPayBackPage(
                                                                                  CreditCardPayBackArguments(
                                                                                      accountHolderName: model.selectedCreditCard!.name!,
                                                                                      secureCode: model.selectedCreditCard!.cardCode!,
                                                                                      accountBalance: cardData!.data!.dashboardDataContent!.account!.availableBalance!,
                                                                                      minDuePayBackAmount: model.selectedCreditCard!.paymentDueAmount.toString(),
                                                                                      totalMinDueAmount: model.selectedCreditCard!.usedBalance!),
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
                                                                                child: AppHomePageWidgets.totalBalance(cardData!.data!.dashboardDataContent!.account!.availableBalance ?? "0.000"),
                                                                              ),
                                                                              Expanded(
                                                                                child: Stack(
                                                                                  alignment: Alignment.topCenter,
                                                                                  fit: StackFit.expand,
                                                                                  children: [
                                                                                    DashboardSwiper(
                                                                                      pages: pagesList,
                                                                                      appSwiperController: model.appSwiperController,
                                                                                      // pageController: model.pageController,
                                                                                      onIndexChanged: (index) {
                                                                                        model.updatePage(index);
                                                                                      },
                                                                                      currentStep: currentStep,
                                                                                      translateSidewaysController: model.translateSidewaysController,
                                                                                      model: model,
                                                                                    ),

                                                                                    ///Timeline Button
                                                                                    ///For My Account and My credit card
                                                                                    Positioned(
                                                                                      top: 20,
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () {
                                                                                          // if (!model.showButtonsInCreditCard) return;
                                                                                          if (model.cardTypeList[currentStep!].timeLineEnum == TimeLineEnum.TIMELINE_YES) {
                                                                                            // Navigator.pushNamed(context, RoutePaths.TimeLinePage,
                                                                                            //     arguments: TimeLinePageArguments(cardType: model.cardTypeList[currentStep!].cardType, timeLineArguments: model.timeLineArguments));
                                                                                            model.showTimeline(!model.timelinePage);
                                                                                          }
                                                                                        },
                                                                                        child: AnimatedOpacity(
                                                                                          ///For Credit Card
                                                                                          duration: const Duration(milliseconds: 500),
                                                                                          opacity: model.cardTypeList[currentStep!].timeLineEnum != TimeLineEnum.TIMELINE_YES ? 0 : 1,
                                                                                          child: AnimatedBuilder(
                                                                                            animation: model.appSwiperController,
                                                                                            builder: (BuildContext context, Widget? child) {
                                                                                              double translateYOffset = 0;
                                                                                              double opacity = 0;
                                                                                              if (model.appSwiperController.positions.isNotEmpty) {
                                                                                                opacity = currentStep - (model.appSwiperController.page ?? 0);
                                                                                                translateYOffset = currentStep - (model.appSwiperController.page ?? 0);
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
                                                                                                    ? AppSvg.asset(AssetUtils.timelineButton, height: 24.w, width: 24.w, color: AppColor.light_acccent_blue)
                                                                                                    : AppSvg.asset(AssetUtils.swipeUp, height: 24.w, width: 24.w, color: AppColor.light_acccent_blue),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),

                                                                                    ///Transactions button
                                                                                    ///For My Account and My credit card
                                                                                    Positioned(
                                                                                      bottom: 20,
                                                                                      child:

                                                                                          ///No transaction button for debit card
                                                                                          model.isDebitCard(currentStep)
                                                                                              ? Container(
                                                                                                  child: AnimatedCrossFade(
                                                                                                    duration: const Duration(milliseconds: 500),
                                                                                                    reverseDuration: const Duration(milliseconds: 500),
                                                                                                    firstCurve: Curves.easeIn,
                                                                                                    secondCurve: Curves.easeIn,
                                                                                                    alignment: Alignment.center,
                                                                                                    crossFadeState: model.settings ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                                                                    firstChild: InkWell(
                                                                                                      onTap: () {
                                                                                                        model.showSettingPage(false);
                                                                                                      },
                                                                                                      child: Container(
                                                                                                          width: 48,
                                                                                                          height: 48,
                                                                                                          margin: EdgeInsets.only(bottom: 4),
                                                                                                          decoration: BoxDecoration(
                                                                                                            color: Colors.white,
                                                                                                            border: Border.all(color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                                                                                                            borderRadius: BorderRadius.circular(100),
                                                                                                            boxShadow: [
                                                                                                              BoxShadow(
                                                                                                                  color: Theme.of(context).colorScheme.inverseSurface,
                                                                                                                  blurRadius: 5,
                                                                                                                  spreadRadius: 0.1,
                                                                                                                  offset: Offset(0, 2))
                                                                                                            ],
                                                                                                          ),
                                                                                                          padding: EdgeInsets.all(10),
                                                                                                          child: AppSvg.asset(
                                                                                                            AssetUtils.down,
                                                                                                            color: AppColor.light_acccent_blue,
                                                                                                          )),
                                                                                                    ),
                                                                                                    secondChild: const SizedBox(),
                                                                                                  ),
                                                                                                )
                                                                                              : model.cardTypeList[currentStep].swipeUpEnum == SwipeUpEnum.SWIPE_UP_YES
                                                                                                  ? InkWell(
                                                                                                      splashColor: Colors.transparent,
                                                                                                      highlightColor: Colors.transparent,
                                                                                                      onTap: () {
                                                                                                        if (model.isCreditCard(currentStep)) {
                                                                                                          if (model.settings) {
                                                                                                            model.showSettingPage(false);
                                                                                                            return;
                                                                                                          }

                                                                                                          if (model.showPayBackView) {
                                                                                                            model.goToPayBackView(false);
                                                                                                            return;
                                                                                                          }

                                                                                                          if (model.showButtonsInCreditCard) {
                                                                                                            model.goToTransactionPage(context, currentStep);
                                                                                                            return;
                                                                                                          }
                                                                                                        }
                                                                                                      },
                                                                                                      child: AnimatedOpacity(
                                                                                                        ///For credit card
                                                                                                        duration: const Duration(milliseconds: 500),
                                                                                                        opacity: (!model.showButtonsInCreditCard && model.isCreditCard(currentStep)) ? 0 : 1,
                                                                                                        child: AnimatedBuilder(
                                                                                                          animation: model.appSwiperController,
                                                                                                          builder: (BuildContext context, Widget? child) {
                                                                                                            double translateYOffset = 0;
                                                                                                            double opacity = 0;
                                                                                                            if (model.appSwiperController.hasClients) if (model.appSwiperController.position.hasContentDimensions) {
                                                                                                              opacity = currentStep - (model.appSwiperController.page ?? 0);
                                                                                                              translateYOffset = currentStep - (model.appSwiperController.page ?? 0);
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
                                                                                                                BoxShadow(
                                                                                                                    color: Theme.of(context).colorScheme.inverseSurface,
                                                                                                                    blurRadius: 5,
                                                                                                                    spreadRadius: 0.1,
                                                                                                                    offset: Offset(0, 4))
                                                                                                              ],
                                                                                                            ),
                                                                                                            child: AnimatedCrossFade(
                                                                                                              duration: const Duration(milliseconds: 500),
                                                                                                              reverseDuration: const Duration(milliseconds: 500),
                                                                                                              firstCurve: Curves.easeIn,
                                                                                                              secondCurve: Curves.easeIn,
                                                                                                              alignment: Alignment.center,
                                                                                                              crossFadeState:
                                                                                                                  model.settings || model.showPayBackView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                                                                              firstChild: Padding(
                                                                                                                padding: const EdgeInsets.all(10.0),
                                                                                                                child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue, height: 40, width: 40),
                                                                                                              ),
                                                                                                              secondChild: Text(
                                                                                                                S.current.transactions,
                                                                                                                style: TextStyle(color: AppColor.skyblue, fontSize: 12, fontWeight: FontWeight.w600),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ),
                                                                                                    )
                                                                                                  : SizedBox(),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              AnimatedCrossFade(
                                                                                crossFadeState: model.settings || model.timelinePage || model.showPayBackView ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                                                                firstChild: const SizedBox(),
                                                                                secondChild: SizedBox(
                                                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: model.buildPageIndicator(currentStep, cardData.data!.dashboardDataContent!.debitCard!.length),
                                                                                  ),
                                                                                ),
                                                                                duration: const Duration(milliseconds: 500),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      builder: (context, child) {
                                                                        return Transform.translate(
                                                                          //offset: Offset(0, model.animation.value* (-MediaQuery.of(context).size.height*0.65)),
                                                                          offset: Offset(0, (model.animation.value * (-(MediaQuery.of(context).size.height * 0.7)))),
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
                                                              ],
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
