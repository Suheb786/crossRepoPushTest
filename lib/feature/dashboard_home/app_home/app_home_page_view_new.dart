import 'dart:io';

import 'package:data/helper/antelop_helper.dart';
import 'package:domain/constants/enum/account_status_enum.dart';
import 'package:domain/constants/enum/evoucher_landing_page_navigation_type_enum.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/model/qr/verify_qr_response.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/app_home_page_widgets.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_page.dart';
import 'package:neo_bank/feature/send_money_via_qr/send_money_qr_scanning/send_money_qr_scanning_page.dart';
import 'package:neo_bank/feature/sub_account/open_sub_account/open_sub_account_success/open_sub_account_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
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

import '../../../ui/molecules/app_progress.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../utils/device_size_helper.dart';
import '../../credit_card_pay_back/credit_card_pay_back_page.dart';
import '../../sub_account/transfer/select_transfer/select_transfer_page.dart';
import '../credit_card_settings/credit_card_settings_page.dart';

class AppHomePageViewNew extends BasePageViewWidget<AppHomeViewModel> {
  AppHomePageViewNew(ProviderBase model) : super(model);

  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context, model) {
    _buildContext = context;
    listenPopUps(model, context);
    return AppStreamBuilder<int>(
      stream: model.currentStep,
      initialData: 0,
      dataBuilder: (context, myyCurrentStep) {
        int currentStep = myyCurrentStep ?? 0;
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
                      if (!(data.data?.isRJPopUPClicked ?? false) &&
                          (model.dashboardDataContent.dashboardFeatures?.isRJFeatureEnabled ?? false)) {
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
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                fontSize: 14),
                          ),
                        );
                      }

                      ///Efawateer pop up
                      if (!(data.data?.isEfawateerPopUPClicked ?? false) &&
                          (model.dashboardDataContent.dashboardFeatures?.blinkRetailAppBillPayment ??
                              false)) {
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
                              Navigator.pushNamed(context, RoutePaths.PaymentHome,
                                  arguments: NavigationType.REQUEST_MONEY);
                            });
                      }

                      ///e-voucher pop up
                      if (!(data.data?.isEVoucherPopUPClicked ?? false) &&
                          (model.dashboardDataContent.dashboardFeatures?.eVouchers ?? false)) {
                        EvoucherDialog.show(context, isSwipeToCancel: true, onDismissed: () {
                          Navigator.pop(context);
                          data.data?.isEVoucherPopUPClicked = true;
                          model.saveCurrentUserData(user: data.data!);
                        }, onSelected: () {
                          Navigator.pop(context);
                          data.data?.isEVoucherPopUPClicked = true;
                          model.saveCurrentUserData(user: data.data!);
                          Navigator.of(context).push(CustomRoute.swipeUpRoute(
                              EvoucherPage(
                                EvoucherPageArguments(
                                    EvoucherLandingPageNavigationType.NORMAL_EVOUCHER_LANDING),
                              ),
                              routeName: RoutePaths.Evoucher));
                        });
                      }

                      ///Show account status pop up
                      if (model.dashboardDataContent.account?.accountStatusEnum ==
                          AccountStatusEnum.DORMANT) {
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
                                        style: TextStyle(
                                            color: Theme.of(context).colorScheme.surface,
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.0.t,
                                            height: 1.7),
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
                                      if (value &&
                                          Platform.isIOS &&
                                          AppConstantsUtils.isApplePayFeatureEnabled &&
                                          isAllCardsInApplePay &&
                                          (model.debitCards.isNotEmpty || model.creditCards.isNotEmpty)) {
                                        ApplePayDialog.show(context,
                                            image: AssetUtils.applePayLogo,
                                            title: S.of(context).blinkWithApplePay, onSelected: () {
                                          Navigator.pop(context);
                                          Navigator.pushNamed(context, RoutePaths.SelectedCardForApplePayPage,
                                              arguments: SelectedCardsForApplePayPageArguments(
                                                  debitCards: model.debitCards,
                                                  creditCards: model.creditCards));
                                        }, onDismissed: () {
                                          Navigator.pop(context);
                                        },
                                            descriptionWidget: Text(
                                              S.of(context).blinkWithApplePayLandingDialogDescription,
                                              style: TextStyle(
                                                  color: AppColor.veryDarkGray2,
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14.t,
                                                  fontWeight: FontWeight.w400),
                                            ));
                                      }
                                    },
                                    dataBuilder: (context, value) {
                                      return AppStreamBuilder<bool>(
                                          stream: model.showAddAnotherCardToApplePayPopUpStream,
                                          initialData: false,
                                          onData: (value) {
                                            if (value &&
                                                Platform.isIOS &&
                                                AppConstantsUtils.isApplePayFeatureEnabled &&
                                                isAllCardsInApplePay) {
                                              AddOtherCardToAppleWalletDialog.show(context,
                                                  title: S.of(context).addOtherCardToAppleWallet,
                                                  image: AssetUtils.applePayButton,
                                                  descriptionWidget: Text(
                                                    S.of(context).addOtherCardToAppleWalletDialogDescription,
                                                    style: TextStyle(
                                                        color: AppColor.veryDarkGray1,
                                                        fontFamily: StringUtils.appFont,
                                                        fontSize: 14.t,
                                                        fontWeight: FontWeight.w400),
                                                  ), onSelected: () {
                                                Navigator.pop(context);
                                                Navigator.pushNamed(
                                                    context, RoutePaths.SelectedCardForApplePayPage,
                                                    arguments: SelectedCardsForApplePayPageArguments(
                                                        debitCards: model.debitCards,
                                                        creditCards: model.creditCards));
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
                                                        alignment: Alignment.bottomCenter,
                                                        children: [
                                                          AppStreamBuilder<Resource<bool>>(
                                                              stream: model.updateNickNameResponseStream,
                                                              initialData: Resource.none(),
                                                              onData: (value) {
                                                                if (value.status == Status.LOADING) {
                                                                  AppProgress(_buildContext);
                                                                } else if (value.status == Status.ERROR ||
                                                                    value.status == Status.SUCCESS) {
                                                                  Navigator.pop(_buildContext);
                                                                }
                                                              },
                                                              dataBuilder: (context, value) {
                                                                return const SizedBox();
                                                              }),

                                                          ///Settings page
                                                          ///Timeline page
                                                          AppStreamBuilder<DashboardAnimatedPage>(
                                                              stream: model.pageSwitchStream,
                                                              initialData: DashboardAnimatedPage.NULL,
                                                              dataBuilder: (context, switchedPage) {
                                                                return AnimatedSwitcher(
                                                                  duration: const Duration(milliseconds: 500),
                                                                  reverseDuration:
                                                                      const Duration(milliseconds: 400),
                                                                  switchInCurve: Curves.easeInOut,
                                                                  switchOutCurve: Curves.linearToEaseOut,
                                                                  child:
                                                                      switchedPage ==
                                                                              DashboardAnimatedPage.SETTINGS
                                                                          ? model.selectedDebitCard != null
                                                                              ? DebitCardSettingsPage(DebitCardSettingsArguments(
                                                                                  accountStatusEnum: cardData
                                                                                          ?.data
                                                                                          ?.dashboardDataContent
                                                                                          ?.account
                                                                                          ?.accountStatusEnum ??
                                                                                      AccountStatusEnum.NONE,
                                                                                  isPrimaryDebitCard: model
                                                                                      .isPrimaryDebitCard,
                                                                                  debitCard: model
                                                                                      .selectedDebitCard!,
                                                                                  debitCardRequestPhysicalCardEnabled: cardData
                                                                                          ?.data
                                                                                          ?.dashboardDataContent
                                                                                          ?.dashboardFeatures
                                                                                          ?.isDebitCardRequestPhysicalCardEnabled ??
                                                                                      false))
                                                                              : CreditCardSettingsPage(
                                                                                  CreditCardSettingsArguments(
                                                                                      creditCard: model
                                                                                          .selectedCreditCard!,
                                                                                      isChangePinEnabled: cardData
                                                                                              ?.data
                                                                                              ?.dashboardDataContent
                                                                                              ?.dashboardFeatures
                                                                                              ?.isPinChangeEnabled ??
                                                                                          true))
                                                                          : switchedPage ==
                                                                                  DashboardAnimatedPage
                                                                                      .TIMELINE
                                                                              ? DebitCardTimeLinePage(TimeLinePageArguments(cardType: model.cardTypeList[currentStep].cardType, timeLineArguments: model.timeLineArguments))
                                                                              : switchedPage == DashboardAnimatedPage.PAYBACK
                                                                                  ? CreditCardPayBackPage(
                                                                                      CreditCardPayBackArguments(
                                                                                          accountHolderName: model
                                                                                                  .selectedCreditCard
                                                                                                  ?.name ??
                                                                                              '',
                                                                                          secureCode: model
                                                                                                  .selectedCreditCard
                                                                                                  ?.cardCode ??
                                                                                              '',
                                                                                          accountBalance: cardData!
                                                                                                  .data!
                                                                                                  .dashboardDataContent
                                                                                                  ?.account
                                                                                                  ?.availableBalance ??
                                                                                              '0',
                                                                                          minDuePayBackAmount:
                                                                                              (model.selectedCreditCard
                                                                                                          ?.paymentDueAmount ??
                                                                                                      '')
                                                                                                  .toString(),
                                                                                          totalMinDueAmount: model
                                                                                                  .selectedCreditCard
                                                                                                  ?.usedBalance ??
                                                                                              '0'),
                                                                                    )
                                                                                  : switchedPage == DashboardAnimatedPage.ACT_SETTING
                                                                                      ? AppStreamBuilder<Resource<CreateAccountResponse>>(
                                                                                          stream: model.createAccountStream,
                                                                                          initialData: Resource.none(),
                                                                                          onData: (event) {
                                                                                            if (event
                                                                                                    .status ==
                                                                                                Status
                                                                                                    .SUCCESS) {
                                                                                              Navigator.pushNamed(
                                                                                                      context,
                                                                                                      RoutePaths
                                                                                                          .OpenSubAccountSuccessPage,
                                                                                                      arguments: OpenSubAccountSuccessPageArgument(
                                                                                                          accountNo: model
                                                                                                              .accountNo,
                                                                                                          iban: model
                                                                                                              .iban))
                                                                                                  .then(
                                                                                                      (value) {
                                                                                                model
                                                                                                    .closeSubAccountDialogAndRefreshPage();
                                                                                              });
                                                                                            }
                                                                                          },
                                                                                          dataBuilder: (context, createAccountResponse) {
                                                                                            return Padding(
                                                                                              padding: EdgeInsetsDirectional
                                                                                                  .only(
                                                                                                      start: 36.0
                                                                                                          .w),
                                                                                              child: Column(
                                                                                                mainAxisAlignment:
                                                                                                    MainAxisAlignment
                                                                                                        .end,
                                                                                                children: [
                                                                                                  AddMoneyTile(),
                                                                                                  TransferBetweenAccountTile(
                                                                                                    isVisible: (cardData?.data?.dashboardDataContent?.dashboardFeatures?.transferBetweenAccountsFeature ??
                                                                                                            false) &&
                                                                                                        model
                                                                                                            .hasSubAccount(
                                                                                                          (cardData?.data?.dashboardDataContent?.accounts ??
                                                                                                              []),
                                                                                                        ),
                                                                                                    onTap:
                                                                                                        () {
                                                                                                      var accounts =
                                                                                                          (cardData?.data?.dashboardDataContent?.accounts ??
                                                                                                              []);
                                                                                                      Navigator
                                                                                                          .pushNamed(
                                                                                                        context,
                                                                                                        RoutePaths
                                                                                                            .SelectTransferPage,
                                                                                                        arguments:
                                                                                                            SelectTranferPageArgument(
                                                                                                          selectedAccount:
                                                                                                              model.selectedAccount,
                                                                                                          allAccountsList: /*model.getAllMyAccounts()*/
                                                                                                              accounts,
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                    isEnabled:
                                                                                                        true,
                                                                                                    isCardActivated:
                                                                                                        true,
                                                                                                  ),
                                                                                                  OpenSubAccountTile(
                                                                                                    isCardActivated: (cardData?.data?.dashboardDataContent?.dashboardFeatures?.subAccountFeature ??
                                                                                                            false) &&
                                                                                                        (cardData?.data?.dashboardDataContent?.allowSubAccount ??
                                                                                                            false),
                                                                                                    isEnabled: (cardData?.data?.dashboardDataContent?.dashboardFeatures?.subAccountFeature ??
                                                                                                            false) &&
                                                                                                        (cardData?.data?.dashboardDataContent?.allowSubAccount ??
                                                                                                            false),
                                                                                                    model:
                                                                                                        model,
                                                                                                  ),
                                                                                                  ShareAccountTile(
                                                                                                      context:
                                                                                                          context,
                                                                                                      model:
                                                                                                          model),
                                                                                                  SizedBox(
                                                                                                      height: (cardData?.data?.dashboardDataContent?.dashboardFeatures?.transferBetweenAccountsFeature ?? false) &&
                                                                                                              model.hasSubAccount(
                                                                                                                (cardData?.data?.dashboardDataContent?.accounts ?? []),
                                                                                                              )
                                                                                                          ? 110.h
                                                                                                          : 180.h),
                                                                                                ],
                                                                                              ),
                                                                                            );
                                                                                          })
                                                                                      : switchedPage == DashboardAnimatedPage.SUB_ACT_SETTING
                                                                                          ? Padding(
                                                                                              padding: EdgeInsetsDirectional
                                                                                                  .only(
                                                                                                      start: 36.0
                                                                                                          .w),
                                                                                              child: Column(
                                                                                                mainAxisAlignment:
                                                                                                    MainAxisAlignment
                                                                                                        .end,
                                                                                                children: [
                                                                                                  TransferBetweenAccountTile(
                                                                                                    isEnabled: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.transferBetweenAccountsFeature ??
                                                                                                        false),
                                                                                                    isCardActivated: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.transferBetweenAccountsFeature ??
                                                                                                        false),
                                                                                                    onTap:
                                                                                                        () {
                                                                                                      var accounts =
                                                                                                          (cardData?.data?.dashboardDataContent?.accounts ??
                                                                                                              []);
                                                                                                      Navigator
                                                                                                          .pushNamed(
                                                                                                        context,
                                                                                                        RoutePaths
                                                                                                            .SelectTransferPage,
                                                                                                        arguments:
                                                                                                            SelectTranferPageArgument(
                                                                                                          selectedAccount:
                                                                                                              model.selectedAccount,
                                                                                                          allAccountsList:
                                                                                                              accounts,
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ),
                                                                                                  ShareAccountTile(
                                                                                                    context:
                                                                                                        context,
                                                                                                    model:
                                                                                                        model,
                                                                                                    isCardActivated: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.shareAccountInformationFeature ??
                                                                                                        false),
                                                                                                    isEnabled: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.shareAccountInformationFeature ??
                                                                                                        false),
                                                                                                  ),
                                                                                                  CloseSubAccount(
                                                                                                    model:
                                                                                                        model,
                                                                                                    isCardActivated: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.closeSubAccountFeature ??
                                                                                                        false),
                                                                                                    isEnabled: (cardData
                                                                                                            ?.data
                                                                                                            ?.dashboardDataContent
                                                                                                            ?.dashboardFeatures
                                                                                                            ?.closeSubAccountFeature ??
                                                                                                        false),
                                                                                                  ),
                                                                                                  SizedBox(
                                                                                                      height:
                                                                                                          180.h),
                                                                                                ],
                                                                                              ),
                                                                                            )
                                                                                          : const SizedBox(),
                                                                );
                                                              }),
                                                          AnimatedBuilder(
                                                            animation: model.translateTimelineDownController,
                                                            child: AnimatedBuilder(
                                                                animation:
                                                                    model.translateSettingsUpController,
                                                                child: AnimatedBuilder(
                                                                  animation: model
                                                                      .translateAccountSettingsUpController,
                                                                  child: Container(
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment.stretch,
                                                                      children: [
                                                                        /// To get rid of the unwanted card size changes....
                                                                        AppStreamBuilder<
                                                                                DashboardAnimatedPage>(
                                                                            stream: model.pageSwitchStream,
                                                                            initialData:
                                                                                DashboardAnimatedPage.NULL,
                                                                            dataBuilder:
                                                                                (context, switchedPage) {
                                                                              return AnimatedCrossFade(
                                                                                crossFadeState: switchedPage ==
                                                                                            DashboardAnimatedPage
                                                                                                .NULL ||
                                                                                        switchedPage ==
                                                                                            DashboardAnimatedPage
                                                                                                .TIMELINE
                                                                                    ? CrossFadeState.showFirst
                                                                                    : CrossFadeState
                                                                                        .showSecond,
                                                                                firstChild: const SizedBox(),
                                                                                secondChild: SizedBox(
                                                                                  height: MediaQuery.of(
                                                                                                  context)
                                                                                              .size
                                                                                              .height *
                                                                                          0.03 +
                                                                                      MediaQuery.of(context)
                                                                                              .size
                                                                                              .height *
                                                                                          (DeviceSizeHelper
                                                                                                  .isBigDevice
                                                                                              ? 0.036
                                                                                              : 0.02) +
                                                                                      117.h,
                                                                                ),
                                                                                duration: const Duration(
                                                                                    milliseconds: 500),
                                                                              );
                                                                            }),
                                                                        AppStreamBuilder<
                                                                                DashboardAnimatedPage>(
                                                                            stream: model.pageSwitchStream,
                                                                            initialData:
                                                                                DashboardAnimatedPage.NULL,
                                                                            dataBuilder:
                                                                                (context, switchedPage) {
                                                                              return AnimatedOpacity(
                                                                                duration: const Duration(
                                                                                    milliseconds: 250),
                                                                                opacity: switchedPage !=
                                                                                        DashboardAnimatedPage
                                                                                            .NULL
                                                                                    ? 0
                                                                                    : 1,
                                                                                child: AppHomePageWidgets
                                                                                    .totalBalance(StringUtils
                                                                                        .formatBalance(cardData
                                                                                                ?.data
                                                                                                ?.dashboardDataContent
                                                                                                ?.availableBalance ??
                                                                                            "0.000")),
                                                                              );
                                                                            }),
                                                                        Expanded(
                                                                          child: Stack(
                                                                            fit: StackFit.expand,
                                                                            alignment: Alignment.topCenter,
                                                                            children: [
                                                                              DashboardSwiper(
                                                                                pages: pagesList,
                                                                                appSwiperController:
                                                                                    model.appSwiperController,
                                                                                onIndexChanged: (index) {
                                                                                  model.updatePage(index);
                                                                                },
                                                                                currentStep: currentStep,
                                                                                translateSidewaysController: model
                                                                                    .translateSidewaysController,
                                                                                model: model,
                                                                              ),

                                                                              ///Timeline Button
                                                                              ///For My Account and My credit card
                                                                              /*Positioned(
                                                                                top: MediaQuery.of(context)
                                                                                            .size
                                                                                            .height *
                                                                                        (DeviceSizeHelper
                                                                                                .isBigDevice
                                                                                            ? 0.06
                                                                                            : 0.04) -
                                                                                    24,
                                                                                child: AnimatedOpacity(
                                                                                  duration: const Duration(
                                                                                      milliseconds: 500),
                                                                                  opacity: model
                                                                                              .cardTypeList[
                                                                                                  currentStep]
                                                                                              .timeLineEnum !=
                                                                                          TimeLineEnum
                                                                                              .TIMELINE_YES
                                                                                      ? 0
                                                                                      : 1,
                                                                                  child: AnimatedBuilder(
                                                                                    animation: model
                                                                                        .appSwiperController,
                                                                                    builder:
                                                                                        (BuildContext context,
                                                                                            Widget? child) {
                                                                                      double opacity = 0;
                                                                                      if (model
                                                                                              .appSwiperController
                                                                                              .hasClients &&
                                                                                          model
                                                                                              .appSwiperController
                                                                                              .positions
                                                                                              .isNotEmpty) {
                                                                                        opacity = currentStep -
                                                                                            (model.appSwiperController
                                                                                                    .page ??
                                                                                                0);
                                                                                      }
                                                                                      return Transform
                                                                                          .translate(
                                                                                        offset: Offset(0, 1),
                                                                                        child: Opacity(
                                                                                          opacity:
                                                                                              (opacity.abs() -
                                                                                                      1)
                                                                                                  .abs(),
                                                                                          child: child!,
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: InkWell(
                                                                                      splashColor:
                                                                                          Colors.transparent,
                                                                                      highlightColor:
                                                                                          Colors.transparent,
                                                                                      onTap: () {
                                                                                        if (model
                                                                                                .cardTypeList[
                                                                                                    currentStep]
                                                                                                .timeLineEnum ==
                                                                                            TimeLineEnum
                                                                                                .TIMELINE_YES) {
                                                                                          model.showTimeline(!(model
                                                                                                  .pageSwitchSubject
                                                                                                  .value ==
                                                                                              DashboardAnimatedPage
                                                                                                  .TIMELINE));
                                                                                        }
                                                                                      },
                                                                                      child: Container(
                                                                                        height: 48,
                                                                                        width: 48,
                                                                                        padding:
                                                                                            const EdgeInsets
                                                                                                .all(10),
                                                                                        decoration: BoxDecoration(
                                                                                            shape: BoxShape
                                                                                                .circle,
                                                                                            color:
                                                                                                Colors.white,
                                                                                            border: Border.all(
                                                                                                color: Theme.of(
                                                                                                        context)
                                                                                                    .colorScheme
                                                                                                    .inverseSurface,
                                                                                                width: 1)),

                                                                                        ///For Credit Card
                                                                                        child: AppStreamBuilder<
                                                                                                DashboardAnimatedPage>(
                                                                                            stream: model
                                                                                                .pageSwitchStream,
                                                                                            initialData:
                                                                                                DashboardAnimatedPage
                                                                                                    .NULL,
                                                                                            dataBuilder: (context,
                                                                                                switchedPage) {
                                                                                              return AnimatedSwitcher(
                                                                                                duration: const Duration(
                                                                                                    milliseconds:
                                                                                                        500),
                                                                                                child: !(switchedPage ==
                                                                                                        DashboardAnimatedPage
                                                                                                            .TIMELINE)
                                                                                                    ? AppSvg.asset(
                                                                                                        AssetUtils
                                                                                                            .timelineButton,
                                                                                                        height: 24
                                                                                                            .w,
                                                                                                        width: 24
                                                                                                            .w,
                                                                                                        color: AppColor
                                                                                                            .light_acccent_blue)
                                                                                                    : AppSvg.asset(
                                                                                                        AssetUtils
                                                                                                            .swipeUpSmall,
                                                                                                        height: 24
                                                                                                            .w,
                                                                                                        width: 24
                                                                                                            .w,
                                                                                                        color:
                                                                                                            AppColor.light_acccent_blue),
                                                                                              );
                                                                                            }),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),*/

                                                                              ///Transactions button
                                                                              ///For My Account and My credit card
                                                                              AppStreamBuilder<
                                                                                      DashboardAnimatedPage>(
                                                                                  stream:
                                                                                      model.pageSwitchStream,
                                                                                  initialData:
                                                                                      DashboardAnimatedPage
                                                                                          .NULL,
                                                                                  dataBuilder: (context,
                                                                                      switchedPage) {
                                                                                    return Positioned(
                                                                                      bottom: 20,
                                                                                      child:

                                                                                          ///No transaction button for debit card
                                                                                          switchedPage ==
                                                                                                      DashboardAnimatedPage
                                                                                                          .SETTINGS &&
                                                                                                  (model.isDebitCard(
                                                                                                          currentStep) ||
                                                                                                      model.isCreditCard(
                                                                                                          currentStep))
                                                                                              ? Container(
                                                                                                  child:
                                                                                                      AnimatedCrossFade(
                                                                                                    duration: const Duration(
                                                                                                        milliseconds:
                                                                                                            500),
                                                                                                    reverseDuration:
                                                                                                        const Duration(
                                                                                                            milliseconds: 500),
                                                                                                    firstCurve:
                                                                                                        Curves
                                                                                                            .easeIn,
                                                                                                    secondCurve:
                                                                                                        Curves
                                                                                                            .easeIn,
                                                                                                    alignment:
                                                                                                        Alignment
                                                                                                            .center,
                                                                                                    crossFadeState: switchedPage ==
                                                                                                            DashboardAnimatedPage
                                                                                                                .SETTINGS
                                                                                                        ? CrossFadeState
                                                                                                            .showFirst
                                                                                                        : CrossFadeState
                                                                                                            .showSecond,
                                                                                                    firstChild:
                                                                                                        InkWell(
                                                                                                      onTap:
                                                                                                          () {
                                                                                                        model.showSettingPage(
                                                                                                            false,
                                                                                                            updateDashboard: true,
                                                                                                            currentStep: currentStep);
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
                                                                                                              BoxShadow(color: Theme.of(context).colorScheme.inverseSurface, blurRadius: 5, spreadRadius: 0.1, offset: Offset(0, 2))
                                                                                                            ],
                                                                                                          ),
                                                                                                          padding: EdgeInsets.all(10),
                                                                                                          child: AppSvg.asset(
                                                                                                            AssetUtils.down,
                                                                                                            color: AppColor.light_acccent_blue,
                                                                                                          )),
                                                                                                    ),
                                                                                                    secondChild:
                                                                                                        const SizedBox(),
                                                                                                  ),
                                                                                                )
                                                                                              : model.cardTypeList[currentStep].swipeUpEnum ==
                                                                                                      SwipeUpEnum
                                                                                                          .SWIPE_UP_YES
                                                                                                  ? InkWell(
                                                                                                      splashColor:
                                                                                                          Colors.transparent,
                                                                                                      highlightColor:
                                                                                                          Colors.transparent,
                                                                                                      onTap:
                                                                                                          () {
                                                                                                        if (model
                                                                                                            .isCreditCard(currentStep)) {
                                                                                                          if (switchedPage ==
                                                                                                              DashboardAnimatedPage.SETTINGS) {
                                                                                                            model.showSettingPage(false);
                                                                                                            return;
                                                                                                          }

                                                                                                          if (switchedPage ==
                                                                                                              DashboardAnimatedPage.PAYBACK) {
                                                                                                            model.goToPayBackView(false);
                                                                                                            return;
                                                                                                          }

                                                                                                          if (model.showButtonsInCreditCard) {
                                                                                                            model.goToTransactionPage(context, currentStep);
                                                                                                            return;
                                                                                                          }
                                                                                                        }

                                                                                                        if (model
                                                                                                            .isMyAccount(currentStep)) {
                                                                                                          if (switchedPage ==
                                                                                                              DashboardAnimatedPage.ACT_SETTING) {
                                                                                                            model.showHideAccountSettings(false);
                                                                                                          } else {
                                                                                                            model.goToAccountTransactionPage(context, model.cardTypeList[currentStep].object as Account);
                                                                                                          }
                                                                                                        }

                                                                                                        if (model
                                                                                                            .isMySubAccount(currentStep)) {
                                                                                                          if (switchedPage ==
                                                                                                              DashboardAnimatedPage.SUB_ACT_SETTING) {
                                                                                                            model.showHideSubAccountSettings(false);
                                                                                                          } else if (switchedPage == DashboardAnimatedPage.TRANSACTIONS) {
                                                                                                            model.showHideAccountSettings(false);
                                                                                                          } else {
                                                                                                            model.goToAccountTransactionPage(context, model.cardTypeList[currentStep].object as Account);
                                                                                                          }
                                                                                                        }
                                                                                                      },
                                                                                                      child:
                                                                                                          AnimatedOpacity(
                                                                                                        ///For credit card
                                                                                                        duration:
                                                                                                            const Duration(milliseconds: 500),
                                                                                                        opacity: (!model.showButtonsInCreditCard && model.isCreditCard(currentStep))
                                                                                                            ? 0
                                                                                                            : 1,
                                                                                                        child:
                                                                                                            AnimatedBuilder(
                                                                                                          animation:
                                                                                                              model.appSwiperController,
                                                                                                          builder:
                                                                                                              (BuildContext context, Widget? child) {
                                                                                                            double opacity = 0;
                                                                                                            if (model.appSwiperController.hasClients && model.appSwiperController.positions.isNotEmpty) if (model.appSwiperController.position.hasContentDimensions) {
                                                                                                              opacity = currentStep - (model.appSwiperController.page ?? 0);
                                                                                                            }
                                                                                                            return Transform.translate(
                                                                                                              offset: Offset(0, 1),
                                                                                                              child: Opacity(
                                                                                                                opacity: (opacity.abs() - 1).abs(),
                                                                                                                child: child!,
                                                                                                              ),
                                                                                                            );
                                                                                                          },

                                                                                                          ///For credit card
                                                                                                          child:
                                                                                                              AnimatedContainer(
                                                                                                            duration: const Duration(milliseconds: 500),
                                                                                                            curve: Curves.easeInOut,
                                                                                                            width: switchedPage == DashboardAnimatedPage.SETTINGS || switchedPage == DashboardAnimatedPage.PAYBACK || switchedPage == DashboardAnimatedPage.ACT_SETTING || switchedPage == DashboardAnimatedPage.SUB_ACT_SETTING ? 48 : 150,
                                                                                                            height: switchedPage == DashboardAnimatedPage.SETTINGS || switchedPage == DashboardAnimatedPage.PAYBACK || switchedPage == DashboardAnimatedPage.ACT_SETTING || switchedPage == DashboardAnimatedPage.SUB_ACT_SETTING ? 48 : 36,
                                                                                                            alignment: Alignment.center,
                                                                                                            margin: switchedPage == DashboardAnimatedPage.SETTINGS || switchedPage == DashboardAnimatedPage.PAYBACK || switchedPage == DashboardAnimatedPage.ACT_SETTING || switchedPage == DashboardAnimatedPage.SUB_ACT_SETTING ? EdgeInsets.zero : EdgeInsets.only(bottom: 4),
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
                                                                                                              crossFadeState: switchedPage == DashboardAnimatedPage.SETTINGS || switchedPage == DashboardAnimatedPage.PAYBACK || switchedPage == DashboardAnimatedPage.ACT_SETTING || switchedPage == DashboardAnimatedPage.SUB_ACT_SETTING ? CrossFadeState.showFirst : CrossFadeState.showSecond,
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
                                                                                    );
                                                                                  }),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        /// INDICATOR...
                                                                        AppStreamBuilder<
                                                                                DashboardAnimatedPage>(
                                                                            stream: model.pageSwitchStream,
                                                                            initialData:
                                                                                DashboardAnimatedPage.NULL,
                                                                            dataBuilder:
                                                                                (context, switchedPage) {
                                                                              return AnimatedCrossFade(
                                                                                crossFadeState: switchedPage !=
                                                                                        DashboardAnimatedPage
                                                                                            .NULL
                                                                                    ? CrossFadeState.showFirst
                                                                                    : CrossFadeState
                                                                                        .showSecond,
                                                                                firstChild: const SizedBox(),
                                                                                secondChild: SizedBox(
                                                                                  height:
                                                                                      MediaQuery.of(context)
                                                                                              .size
                                                                                              .height *
                                                                                          0.04,
                                                                                  child: Padding(
                                                                                    padding: EdgeInsets.only(
                                                                                        bottom: 17.h),
                                                                                    child: Row(
                                                                                      mainAxisAlignment:
                                                                                          MainAxisAlignment
                                                                                              .center,
                                                                                      children: model
                                                                                          .buildPageIndicator(
                                                                                              currentStep,
                                                                                              cardData!
                                                                                                  .data!
                                                                                                  .dashboardDataContent!
                                                                                                  .debitCard!
                                                                                                  .length),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                duration: const Duration(
                                                                                    milliseconds: 500),
                                                                              );
                                                                            }),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  builder:
                                                                      (BuildContext context, Widget? child) {
                                                                    return Transform.translate(
                                                                      offset: Offset(
                                                                          0,
                                                                          (model.accountSettingsAnimation
                                                                                  .value *
                                                                              (-MediaQuery.of(context)
                                                                                      .size
                                                                                      .height *
                                                                                  0.5))),
                                                                      child: child,
                                                                    );
                                                                  },
                                                                ),
                                                                builder: (context, child) {
                                                                  return Transform.translate(
                                                                    offset: Offset(
                                                                        0,
                                                                        (model.settingsAnimation.value *
                                                                            (-MediaQuery.of(context)
                                                                                    .size
                                                                                    .height *
                                                                                0.78))),
                                                                    child: child,
                                                                  );
                                                                }),
                                                            builder: (context, child) {
                                                              ///Timeline animation
                                                              return Transform.translate(
                                                                offset: Offset(
                                                                    0,
                                                                    model.translateTimelineDownController
                                                                            .value *
                                                                        (MediaQuery.of(context).size.height *
                                                                            0.65)),
                                                                child: child,
                                                              );
                                                            },
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
