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
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/postpaid_bills/post_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/prepaid/pre_paid_bill_card_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
          print('feature Enabled ---->${ProviderScope.containerOf(context)
              .read(appHomeViewModelProvider)
              .dashboardDataContent
              .dashboardFeatures
              ?.rtpFeatureEnabled}');
          if (data!.status == Status.SUCCESS) {
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

            return Padding(
              padding: EdgeInsets.only(bottom: 47.0.h),
              child: AppStreamBuilder<int>(
                stream: model.currentStep,
                initialData: model.getInitialNavigation(navigationType!, context),
                dataBuilder: (context, currentStep) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (currentStep == 2) {}
                    },
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        if (currentStep == 0) {
                          Navigator.pushNamed(context, RoutePaths.SendMoney);
                        } else if (currentStep == 1) {
                          getVerticalRouting(context, model, 1);
                        } else if (currentStep == 2) {
                          getVerticalRouting(context, model, 2);
                        } else if (currentStep == 3) {
                          getVerticalRouting(context, model, 3);
                        } else {
                          Navigator.pop(context);
                        }
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.only(top: 75.0.h),
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
                                                name: "pay_via_qr", parameters: {"pay_via_qr_clicked": true});

                                            InformationDialog.show(context,
                                                image: AssetUtils.payRequestViaQRBlackIcon,
                                                title: S.of(context).payViaQR,
                                                descriptionWidget: Text(S.of(context).payAndRequestMoneyViaQR,
                                                    style: TextStyle(
                                                        fontFamily: StringUtils.appFont,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 14.0.t)), onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context, RoutePaths.QRScanningScreen);
                                            });
                                          },
                                          child: AppSvg.asset(AssetUtils.payViaQrIcon)),
                                      Padding(
                                        padding: EdgeInsets.only(top: 9.0.h),
                                        child: Text(
                                          S.of(context).payViaQR,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0.t),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                        child: AppSvg.asset(AssetUtils.payments),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 9.0.h),
                                        child: Text(
                                          S.of(context).billsAndPayments,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 18.0.t),
                                        ),
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
                                                  parameters: {"request_via_qr_clicked": true});
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

                                                Navigator.pushNamed(
                                                    context, RoutePaths.RequestMoneyQrGeneration,
                                                    arguments: RequestMoneyQrGenerationPageArguments(
                                                        ProviderScope.containerOf(context)
                                                            .read(appHomeViewModelProvider)
                                                            .dashboardDataContent
                                                            .account!));
                                              });
                                            },
                                            child: AppSvg.asset(AssetUtils.requestViaQrIcon)),
                                        Padding(
                                          padding: EdgeInsets.only(top: 9.0.h),
                                          child: Text(
                                            S.of(context).requestViaQR,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18.0.t),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                          child: AppSvg.asset(AssetUtils.payments),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 9.0.h),
                                          child: Text(
                                            S.of(context).billsAndPayments,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18.0.t),
                                          ),
                                        )
                                      ],
                                    )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                    child: AppSvg.asset(AssetUtils.payments),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 9.0.h),
                                    child: Text(
                                      S.of(context).billsAndPayments,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18.0.t),
                                    ),
                                  )
                                ],
                              )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0.h),
                                  child: AppSvg.asset(AssetUtils.payments),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 9.0.h),
                                  child: Text(
                                    S.of(context).billsAndPayments,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0.t),
                                  ),
                                )
                              ],
                            ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 34.0.h, bottom: 5.0.h),
                                    child: AppSwiper(
                                      appSwiperController: model.appSwiperController,
                                      pages: pages,
                                      pageController: model.pageController,
                                      onIndexChanged: (index) {
                                        model.updatePage(index);
                                        model.updatePageControllerStream(index);
                                      },
                                      currentStep: currentStep,
                                    ),
                                  ),
                                ),
                                SmoothPageIndicator(
                                  controller: model.controller,
                                  count: pages.length,
                                  effect: ScrollingDotsEffect(
                                    activeStrokeWidth: 2.6,
                                    activeDotScale: 1.3,
                                    activeDotColor: Theme.of(context).primaryColorDark,
                                    dotColor: Theme.of(context).primaryColorDark.withOpacity(0.6),
                                    maxVisibleDots: 5,
                                    radius: 8,
                                    spacing: 10,
                                    dotHeight: 10,
                                    dotWidth: 10,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        });
  }

  getVerticalRouting(BuildContext context, PaymentHomeViewModel model, int index) {
    switch (model.paymentWidgetTypeFeature[index].paymentWidgetType) {
      case PaymentWidgetType.REQUEST_MONEY:
        Navigator.pushNamed(context, RoutePaths.RequestMoney);
        break;
      case PaymentWidgetType.PRE_PAID_BILL:

        ///LOG EVENT TO FIREBASE
        FireBaseLogUtil.fireBaseLog("new_pre_paid", {"new_pre_paid_clicked": true});
        Navigator.pushNamed(context, RoutePaths.NewBillsPage);
        AppConstantsUtils.PRE_PAID_FLOW = true;
        AppConstantsUtils.POST_PAID_FLOW = false;
        AppConstantsUtils.IS_NEW_PAYMENT = true;
        break;
      case PaymentWidgetType.POST_PAID_BILL:

        ///LOG EVENT TO FIREBASE
        FireBaseLogUtil.fireBaseLog("new_post_paid", {"new_post_paid_clicked": true});
        Navigator.pushNamed(context, RoutePaths.NewBillsPage);
        AppConstantsUtils.POST_PAID_FLOW = true;
        AppConstantsUtils.PRE_PAID_FLOW = false;
        AppConstantsUtils.IS_NEW_PAYMENT = true;
        break;

      default:
        Navigator.pop(context);
    }
  }
}
