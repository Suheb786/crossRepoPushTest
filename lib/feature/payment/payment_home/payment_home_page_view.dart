import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
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
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  NavigationType? navigationType;

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
            return Padding(
              padding: EdgeInsets.only(bottom: 47.0.h),
              child: AppStreamBuilder<int>(
                stream: model.currentStep,
                initialData: navigationType == NavigationType.DASHBOARD ? 0 : 1,
                dataBuilder: (context, currentStep) {
                  print("current step : $currentStep");
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (currentStep == 2) {}
                    },
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        if (currentStep == 0) {
                          Navigator.pushNamed(context, RoutePaths.SendMoney);
                        } else {
                          Navigator.pushNamed(context, RoutePaths.RequestMoney);
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.only(top: 75.0.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (currentStep == 0)
                            InkWell(
                                onTap: () {
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
                                  });
                                },
                                child: AppSvg.asset(AssetUtils.payViaQrIcon))
                          else
                            InkWell(
                                onTap: () {
                                  InformationDialog.show(context,
                                      image: AssetUtils.payRequestViaQRBlackIcon,
                                      title: S.of(context).requestViaQR,
                                      descriptionWidget: Text(S.of(context).payAndRequestMoneyViaQR,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.0.t)), onDismissed: () {
                                    Navigator.pop(context);
                                  }, onSelected: () {
                                    Navigator.pop(context);

                                    Navigator.popAndPushNamed(context, RoutePaths.RequestMoneyQrGeneration,
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
                              currentStep == 0 ? S.of(context).payViaQR : S.of(context).requestViaQR,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0.t),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 34.0.h, bottom: 5.0.h),
                                    child: AppSwiper(
                                      appSwiperController: model.appSwiperController,
                                      pages: [
                                        AddSendMoneyContactPage(beneficiaries: model.smBeneficiaries),
                                        AddRequestMoneyContactPage(beneficiaries: model.rtpBeneficiaries),
                                        Container()
                                      ],
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
                                  count: 2,
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
}
