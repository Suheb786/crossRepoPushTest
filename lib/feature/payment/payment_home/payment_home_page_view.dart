import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_page.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_page.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  PaymentHomePageView(ProviderBase model) : super(model);

  List pages = [AddSendMoneyContactPage(), AddRequestMoneyContactPage()];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(top: 85),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 1,
        dataBuilder: (context, currentStep) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              AppSwiper(
                                pages: pages,
                                pageController: model.pageController,
                                onIndexChanged: (index) {
                                  model.updatePage(index);
                                  model.updatePageControllerStream(index);
                                },
                                currentStep: currentStep,
                              ),
                            ],
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
                            dotColor: Theme.of(context)
                                .primaryColorDark
                                .withOpacity(0.6),
                            maxVisibleDots: 5,
                            radius: 8,
                            spacing: 10,
                            dotHeight: 10,
                            dotWidth: 10,
                          )),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
