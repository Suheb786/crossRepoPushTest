import 'package:domain/model/manage_contacts/get_beneficiary_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_page.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/payment_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  NavigationType? navigationType;

  PaymentHomePageView(ProviderBase model, this.navigationType) : super(model);

  // final List pages = [
  // ];

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
              padding: EdgeInsets.only(bottom: 47),
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
                        ///TODO:
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
                      padding: EdgeInsets.only(top: 75),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSvg.asset(AssetUtils.payments),
                          Padding(
                            padding: EdgeInsets.only(top: 9),
                            child: Text(
                              S.of(context).payments,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 4),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          PaymentSwiper(
                                            pages: [
                                              AddSendMoneyContactPage(
                                                  beneficiaries:
                                                      model.smBeneficiaries),
                                              AddRequestMoneyContactPage(
                                                  beneficiaries:
                                                      model.rtpBeneficiaries),
                                              Container()
                                            ],
                                            pageController:
                                                model.pageController,
                                            onIndexChanged: (index) {
                                              model.updatePage(index);
                                              model.updatePageControllerStream(
                                                  index);
                                            },
                                            currentStep: currentStep,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SmoothPageIndicator(
                                    controller: model.controller,
                                    count: 2,
                                    effect: ScrollingDotsEffect(
                                      activeStrokeWidth: 2.6,
                                      activeDotScale: 1.3,
                                      activeDotColor:
                                          Theme.of(context).primaryColorDark,
                                      dotColor: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.6),
                                      maxVisibleDots: 5,
                                      radius: 8,
                                      spacing: 10,
                                      dotHeight: 10,
                                      dotWidth: 10,
                                    ),
                                  ),
                                ],
                              ),
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
