import 'package:auto_size_text/auto_size_text.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_page.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/feature/request_money_via_qr/request_money_qr_generation/request_money_qr_generation_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dashboard/bottom_bar_widget.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/ui/molecules/pager/payment_swiper.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/post_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/prepaid/pre_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../utils/device_size_helper.dart';
import '../../activity/payment_activity/payment_activity_page.dart';
import '../../activity/payment_activity_transaction/payment_activity_transaction_page.dart';
import '../../postpaid_bills/new_bill/new_bills_page.dart';
import '../../send_money_via_qr/qr_scanning_screen/qr_scanning_screen_page.dart';
import '../request_amount_from_contact/request_amount_from_contact_page.dart';
import '../request_money/request_money_page.dart';
import '../send_amount_to_contact/send_amount_to_contact_page.dart';
import '../send_money/send_money_page.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  NavigationType? navigationType;
  List<dynamic> pages = [];

  PaymentHomePageView(ProviderBase model, this.navigationType) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<GetBeneficiaryListResponse>>(
        stream: model.beneficiaryResponse,
        initialData: Resource.none(),
        onData: (data) {
          if (data.status == Status.ERROR) {
            model.showToastWithError(data.appError!);
            Navigator.pop(context);
          }
        },
        dataBuilder: (context, data) {
          if (data!.status == Status.SUCCESS) {
            pages.clear();
            model.paymentWidgetTypeFeature.clear();
            pages.add(AddSendMoneyContactPage(beneficiaries: model.smBeneficiaries));
            model.paymentWidgetTypeFeature.add(
                PaymentHomeWidgetFeature(paymentWidgetType: PaymentWidgetType.SEND_MONEY, isEnabled: true));
            if (ProviderScope.containerOf(context)
                    .read(appHomeViewModelProvider)
                    .dashboardDataContent
                    .dashboardFeatures
                    ?.rtpFeatureEnabled ??
                false) {
              pages.add(AddRequestMoneyContactPage(beneficiaries: model.rtpBeneficiaries));
              model.paymentWidgetTypeFeature.add(PaymentHomeWidgetFeature(
                  paymentWidgetType: PaymentWidgetType.REQUEST_MONEY, isEnabled: true));
            }
            if ((ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .dashboardFeatures
                        ?.blinkRetailAppBillPayment ??
                    true) &&
                (ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .dashboardFeatures
                        ?.appBillPaymentPostpaid ??
                    true)) {
              pages.add(PostPaidBillCardWidget());
              model.paymentWidgetTypeFeature.add(PaymentHomeWidgetFeature(
                  paymentWidgetType: PaymentWidgetType.POST_PAID_BILL, isEnabled: true));
            }

            if ((ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .dashboardFeatures
                        ?.blinkRetailAppBillPayment ??
                    true) &&
                (ProviderScope.containerOf(context)
                        .read(appHomeViewModelProvider)
                        .dashboardDataContent
                        .dashboardFeatures
                        ?.appBillPaymentPrepaid ??
                    true)) {
              pages.add(PrePaidBillCardWidget());
              model.paymentWidgetTypeFeature.add(PaymentHomeWidgetFeature(
                  paymentWidgetType: PaymentWidgetType.PRE_PAID_BILL, isEnabled: true));
            }

            return AppStreamBuilder<Resource<List<RequestMoneyActivityList>>>(
                stream: model.paymentActivityListStream,
                initialData: Resource.none(),
                onData: (paymentActivity) {},
                dataBuilder: (context, currentStep) {
                  if (model.paymentWidgetTypeFeature.last.paymentWidgetType !=
                          PaymentWidgetType.CLIQ_TRANSACTIONS &&
                      pages.length < 5) {
                    pages.add(PaymentActivityPage());
                    model.paymentWidgetTypeFeature.add(PaymentHomeWidgetFeature(
                        paymentWidgetType: PaymentWidgetType.CLIQ_TRANSACTIONS, isEnabled: true));
                  }

                  return AppStreamBuilder<int>(
                    stream: model.currentStep,
                    initialData: model.getInitialNavigation(navigationType!, context),
                    dataBuilder: (context, currentStep) {
                      return Stack(
                        children: [
                          AppStreamBuilder<AnimatedPage>(
                              stream: model.pageSwitchStream,
                              initialData: AnimatedPage.NULL,
                              dataBuilder: (context, switchedPage) {
                                print("something ${switchedPage}");
                                return AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 500),
                                  reverseDuration: const Duration(milliseconds: 400),
                                  switchInCurve: Curves.easeInOut,
                                  switchOutCurve: Curves.linearToEaseOut,
                                  child: switchedPage == AnimatedPage.PAY_NEW_BILL
                                      ? NewBillsPage()
                                      : switchedPage == AnimatedPage.SEND_MONEY
                                          ? SendMoneyPage()
                                          : switchedPage == AnimatedPage.REQUEST_MONEY
                                              ? RequestMoneyPage()
                                              : switchedPage == AnimatedPage.SEND_TO_SPECIFIC_PERSON
                                                  ? SendAmountToContactPage(SendAmountToContactPageArgument(
                                                      model
                                                          .selectedBenificiary)) /*SendAmountToContactPage()*/
                                                  : switchedPage == AnimatedPage.REQUEST_FROM_SPECIFIC_PERSON
                                                      ? RequestAmountFromContactPage(
                                                          RequestAmountToContactPageArgument(
                                                              model.selectedBenificiary))
                                                      : switchedPage == AnimatedPage.REQUEST_MONEY_VIA_QR
                                                          ? RequestMoneyQrGenerationPage(
                                                              RequestMoneyQrGenerationPageArguments(
                                                                  ProviderScope.containerOf(context)
                                                                      .read(appHomeViewModelProvider)
                                                                      .dashboardDataContent
                                                                      .account!))
                                                          : switchedPage == AnimatedPage.PAYMENT_ACTIVITY
                                                              ? PaymentActivityTransactionPage(
                                                                  PaymentActivityTransactionPageArgument(
                                                                    backgroundColor:
                                                                        Theme.of(context).canvasColor,
                                                                    title: S.of(context).paymentActivity,
                                                                    titleColor: AppColor.black,
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                );
                              }),
                          AnimatedBuilder(
                            animation: model.translateUpController,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      (DeviceSizeHelper.isBigDevice ? 0.058 : 0.033)),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (currentStep == 0)
                                    ProviderScope.containerOf(context)
                                                .read(appHomeViewModelProvider)
                                                .dashboardDataContent
                                                .dashboardFeatures
                                                ?.appBillPaymentQrCode ??
                                            true
                                        ? Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                  onTap: () async {
                                                    ///LOG EVENT TO FIREBASE
                                                    await FirebaseAnalytics.instance.logEvent(
                                                        name: "pay_via_qr",
                                                        parameters: {"pay_via_qr_clicked": true.toString()});

                                                    InformationDialog.show(context,
                                                        image: AssetUtils.payRequestViaQRBlackIcon,
                                                        title: S.of(context).payViaQR,
                                                        descriptionWidget: Text(
                                                            S.of(context).payAndRequestMoneyViaQR,
                                                            style: TextStyle(
                                                                fontFamily: StringUtils.appFont,
                                                                fontWeight: FontWeight.w400,
                                                                fontSize: 14.0.t)), onDismissed: () {
                                                      Navigator.pop(context);
                                                    }, onSelected: () {
                                                      Navigator.pop(context);
                                                      Navigator.of(context).push(
                                                          CustomRoute.swipeUpRoute(QrScanningScreenPage()));
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 5.0.h),
                                                    child: AppSvg.asset(AssetUtils.payViaQrIcon,
                                                        height: 45.h, width: 45.h),
                                                  )),
                                              Text(
                                                S.of(context).payViaQR,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.0.t),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(vertical: 0.0.h),
                                                child: AppSvg.asset(AssetUtils.payments,
                                                    height: 35.h, width: 35.h),
                                              ),
                                              Text(
                                                S.of(context).billsAndPayments,
                                                style: TextStyle(
                                                    fontFamily: StringUtils.appFont,
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18.0.t),
                                              )
                                            ],
                                          )
                                  else if (currentStep == 1)
                                    if (model.paymentWidgetTypeFeature[1].paymentWidgetType ==
                                        PaymentWidgetType.REQUEST_MONEY)
                                      ProviderScope.containerOf(context)
                                                  .read(appHomeViewModelProvider)
                                                  .dashboardDataContent
                                                  .dashboardFeatures
                                                  ?.appBillPaymentQrCode ??
                                              true
                                          ? Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                    onTap: () async {
                                                      ///LOG EVENT TO FIREBASE
                                                      await FirebaseAnalytics.instance.logEvent(
                                                          name: "request_via_qr",
                                                          parameters: {
                                                            "request_via_qr_clicked": true.toString()
                                                          });
                                                      InformationDialog.show(context,
                                                          image: AssetUtils.payRequestViaQRBlackIcon,
                                                          title: S.of(context).requestViaQR,
                                                          descriptionWidget: Text(
                                                              S.of(context).payAndRequestMoneyViaQR,
                                                              style: TextStyle(
                                                                  fontFamily: StringUtils.appFont,
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: 14.0.t)), onDismissed: () {
                                                        Navigator.pop(context);
                                                      }, onSelected: () {
                                                        Navigator.pop(context);
                                                        model.animatePage(AnimatedPage.REQUEST_MONEY_VIA_QR);
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                                                      child: AppSvg.asset(AssetUtils.requestViaQrIcon,
                                                          height: 45.h, width: 45.h),
                                                    )),
                                                Text(
                                                  S.of(context).requestViaQR,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18.0.t),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                                  child: AppSvg.asset(AssetUtils.payments,
                                                      height: 35.h, width: 35.h),
                                                ),
                                                Text(
                                                  S.of(context).billsAndPayments,
                                                  style: TextStyle(
                                                      fontFamily: StringUtils.appFont,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18.0.t),
                                                )
                                              ],
                                            )
                                    else
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                            child:
                                                AppSvg.asset(AssetUtils.payments, height: 35.h, width: 35.h),
                                          ),
                                          Text(
                                            S.of(context).billsAndPayments,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18.0.t),
                                          )
                                        ],
                                      )
                                  else if (currentStep == 4)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                          child: AppSvg.asset(AssetUtils.payments, height: 35.h, width: 35.h),
                                        ),
                                        Text(
                                          S.of(context).cliqTransactions,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0.t),
                                        )
                                      ],
                                    )
                                  else
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                          child: AppSvg.asset(AssetUtils.payments, height: 35.h, width: 35.h),
                                        ),
                                        Text(
                                          S.of(context).billsAndPayments,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0.t),
                                        )
                                      ],
                                    ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        /// To get rid of the unwanted card size changes....
                                        AppStreamBuilder<AnimatedPage>(
                                            stream: model.pageSwitchStream,
                                            initialData: AnimatedPage.NULL,
                                            dataBuilder: (context, switchedPage) {
                                              return AnimatedCrossFade(
                                                crossFadeState: switchedPage == AnimatedPage.NULL
                                                    ? CrossFadeState.showFirst
                                                    : CrossFadeState.showSecond,
                                                firstChild: const SizedBox(),
                                                secondChild: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.03 +
                                                      MediaQuery.of(context).size.height *
                                                          (DeviceSizeHelper.isBigDevice ? 0.036 : 0.02) +
                                                      100.h,
                                                ),
                                                duration: const Duration(milliseconds: 500),
                                              );
                                            }),
                                        Expanded(
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.topCenter,
                                            children: [
                                              PaymentSwiper(
                                                appSwiperController: model.appSwiperController,
                                                pages: pages,
                                                // pageController: model.pageController,
                                                onIndexChanged: (index) {
                                                  model.updatePage(index);
                                                },
                                                currentStep: currentStep,
                                                model: model,
                                                translateSidewaysController:
                                                    model.translateSidewaysController,
                                              ),

                                              ///Transactions button
                                              ///For My Account and My credit card
                                              AppStreamBuilder<AnimatedPage>(
                                                  stream: model.pageSwitchStream,
                                                  initialData: AnimatedPage.NULL,
                                                  dataBuilder: (context, switchedPage) {
                                                    return Positioned(
                                                      bottom: switchedPage != AnimatedPage.NULL ? 18 : 23,
                                                      child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        onTap: () {
                                                          if (currentStep == 0) {
                                                            model.animatePage(AnimatedPage.SEND_MONEY);
                                                          } else if (currentStep == 1) {
                                                            getVerticalRouting(context, model, 1);
                                                          } else if (currentStep == 2) {
                                                            getVerticalRouting(context, model, 2);
                                                          } else if (currentStep == 3) {
                                                            getVerticalRouting(context, model, 3);
                                                          } else if (currentStep == 4) {
                                                            getVerticalRouting(context, model, 4);
                                                          } else {}
                                                        },
                                                        child: AnimatedOpacity(
                                                          duration: const Duration(milliseconds: 500),
                                                          opacity: 1,
                                                          child: AnimatedBuilder(
                                                            animation: model.appSwiperController,
                                                            builder: (BuildContext context, Widget? child) {
                                                              double opacity = 0;
                                                              if (model.appSwiperController.hasClients) if (model
                                                                  .appSwiperController
                                                                  .position
                                                                  .hasContentDimensions) {
                                                                opacity = currentStep! -
                                                                    (model.appSwiperController.page ?? 0);
                                                              }
                                                              return Transform.translate(
                                                                offset: Offset(0, 1),
                                                                child: Opacity(
                                                                  opacity: (opacity.abs() - 1).abs(),
                                                                  child: child!,
                                                                ),
                                                              );
                                                            },
                                                            child: AnimatedContainer(
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.easeInOut,
                                                              padding: const EdgeInsets.all(10.0),
                                                              width: switchedPage != AnimatedPage.NULL
                                                                  ? 48
                                                                  : (model
                                                                                  .paymentWidgetTypeFeature[
                                                                                      currentStep!]
                                                                                  .paymentWidgetType ==
                                                                              PaymentWidgetType.SEND_MONEY) ||
                                                                          (model
                                                                                  .paymentWidgetTypeFeature[
                                                                                      currentStep]
                                                                                  .paymentWidgetType ==
                                                                              PaymentWidgetType.REQUEST_MONEY)
                                                                      ? 110
                                                                      : 125,
                                                              height:
                                                                  switchedPage != AnimatedPage.NULL ? 48 : 36,
                                                              alignment: Alignment.center,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                border: Border.all(
                                                                    color: Theme.of(context)
                                                                        .colorScheme
                                                                        .inverseSurface,
                                                                    width: 1),
                                                                borderRadius: BorderRadius.circular(100),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                      color: Theme.of(context)
                                                                          .colorScheme
                                                                          .inverseSurface,
                                                                      blurRadius: 5,
                                                                      spreadRadius: 0.1,
                                                                      offset: Offset(0, 4))
                                                                ],
                                                              ),
                                                              child: AnimatedCrossFade(
                                                                duration: const Duration(milliseconds: 500),
                                                                reverseDuration:
                                                                    const Duration(milliseconds: 500),
                                                                firstCurve: Curves.easeIn,
                                                                secondCurve: Curves.easeIn,
                                                                alignment: Alignment.center,
                                                                crossFadeState:
                                                                    switchedPage != AnimatedPage.NULL
                                                                        ? CrossFadeState.showFirst
                                                                        : CrossFadeState.showSecond,
                                                                firstChild: AppSvg.asset(AssetUtils.down,
                                                                    color: AppColor.light_acccent_blue,
                                                                    height: 40,
                                                                    width: 40),
                                                                secondChild: AutoSizeText(
                                                                  (model
                                                                                  .paymentWidgetTypeFeature[
                                                                                      currentStep!]
                                                                                  .paymentWidgetType ==
                                                                              PaymentWidgetType.SEND_MONEY) ||
                                                                          (model
                                                                                  .paymentWidgetTypeFeature[
                                                                                      currentStep]
                                                                                  .paymentWidgetType ==
                                                                              PaymentWidgetType.REQUEST_MONEY)
                                                                      ? S.current.newPayment
                                                                      : model
                                                                                  .paymentWidgetTypeFeature[
                                                                                      currentStep]
                                                                                  .paymentWidgetType ==
                                                                              PaymentWidgetType.POST_PAID_BILL
                                                                          ? S.current.newPostPaidBill
                                                                          : model
                                                                                      .paymentWidgetTypeFeature[
                                                                                          currentStep]
                                                                                      .paymentWidgetType ==
                                                                                  PaymentWidgetType
                                                                                      .CLIQ_TRANSACTIONS
                                                                              ? S.current.view_more
                                                                              : S.current.newPrePaidBill,
                                                                  style: TextStyle(
                                                                      color: AppColor.light_acccent_blue,
                                                                      fontSize: 12,
                                                                      fontWeight: FontWeight.w600),
                                                                  maxLines: 1,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                        ),

                                        /// INDICATOR...
                                        AppStreamBuilder<AnimatedPage>(
                                            stream: model.pageSwitchStream,
                                            initialData: AnimatedPage.NULL,
                                            dataBuilder: (context, switchedPage) {
                                              return AnimatedCrossFade(
                                                crossFadeState: switchedPage != AnimatedPage.NULL
                                                    ? CrossFadeState.showFirst
                                                    : CrossFadeState.showSecond,
                                                firstChild: const SizedBox(),
                                                secondChild: SizedBox(
                                                  height: MediaQuery.of(context).size.height * 0.03,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(bottom: 17.h),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children:
                                                          buildPageIndicator(currentStep!, pages.length),
                                                    ),
                                                  ),
                                                ),
                                                duration: const Duration(milliseconds: 500),
                                              );
                                            }),

                                        /// BOTTOM BAR
                                        AppStreamBuilder<AnimatedPage>(
                                            stream: model.pageSwitchStream,
                                            initialData: AnimatedPage.NULL,
                                            dataBuilder: (context, switchedPage) {
                                              return AnimatedCrossFade(
                                                duration: Duration(milliseconds: 500),
                                                firstChild: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: MediaQuery.of(context).size.height *
                                                          (DeviceSizeHelper.isBigDevice ? 0.036 : 0.02)),
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: BottomBarWidget(
                                                      onHomeTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      onMoreTap: () {
                                                        Navigator.pop(context);
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
                                                secondChild: const SizedBox(),
                                                crossFadeState: switchedPage == AnimatedPage.NULL
                                                    ? CrossFadeState.showFirst
                                                    : CrossFadeState.showSecond,
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            builder: (BuildContext context, Widget? child) {
                              return Transform.translate(
                                offset: Offset(
                                    0,
                                    model.translateUpAnimation.value *
                                        (-MediaQuery.of(context).size.height * 0.84)),
                                child: child,
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
          } else {
            return Container();
          }
        });
  }

  getVerticalRouting(BuildContext context, PaymentHomeViewModel model, int index) {
    switch (model.paymentWidgetTypeFeature[index].paymentWidgetType) {
      case PaymentWidgetType.REQUEST_MONEY:
        // Navigator.pushNamed(context, RoutePaths.RequestMoney);
        model.animatePage(AnimatedPage.REQUEST_MONEY);
        break;
      case PaymentWidgetType.PRE_PAID_BILL:

        ///LOG EVENT TO FIREBASE
        FireBaseLogUtil.fireBaseLog("new_pre_paid", {"new_pre_paid_clicked": true});
        // Navigator.pushNamed(context, RoutePaths.NewBillsPage);
        model.animatePage(AnimatedPage.PAY_NEW_BILL);
        AppConstantsUtils.PRE_PAID_FLOW = true;
        AppConstantsUtils.POST_PAID_FLOW = false;
        AppConstantsUtils.IS_NEW_PAYMENT = true;
        break;
      case PaymentWidgetType.POST_PAID_BILL:

        ///LOG EVENT TO FIREBASE
        FireBaseLogUtil.fireBaseLog("new_post_paid", {"new_post_paid_clicked": true});
        // Navigator.pushNamed(context, RoutePaths.NewBillsPage);
        model.animatePage(AnimatedPage.PAY_NEW_BILL);
        AppConstantsUtils.POST_PAID_FLOW = true;
        AppConstantsUtils.PRE_PAID_FLOW = false;
        AppConstantsUtils.IS_NEW_PAYMENT = true;
        break;

      case PaymentWidgetType.CLIQ_TRANSACTIONS:
        model.animatePage(AnimatedPage.PAYMENT_ACTIVITY);
        break;

      default:
        Navigator.pop(context);
    }
  }

  List<Widget> buildPageIndicator(int currentPage, int totalPage) {
    List<Widget> list = [];
    for (int i = 0; i < totalPage; i++) {
      list.add(i == currentPage
          ? indicator(true, i, currentPage, totalPage)
          : indicator(false, i, currentPage, totalPage));
    }
    return list;
  }

  Widget indicator(bool isActive, int i, int currentPage, int totalPage) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 2),
      height: getIndicatorSize(isActive, i, currentPage, totalPage),
      width: getIndicatorSize(isActive, i, currentPage, totalPage),
      decoration: BoxDecoration(
        color: getColor(isActive, i),
        shape: BoxShape.circle,
      ),
    );
  }

  double getIndicatorSize(bool isActive, int i, int currentPage, int totalPage) {
    if (isActive) {
      return 7.0;
    } else if ((i == 0 || i == pages.length - 1) && !isActive) {
      return 5.0;
    }
    return 5.0;
  }

  Color getColor(bool isActive, int i) {
    if (isActive) {
      return Colors.black;
    } else {
      return Color(0xFFA9A9A9);
    }
  }
}
