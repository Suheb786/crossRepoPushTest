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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaymentHomePageView extends BasePageViewWidget<PaymentHomeViewModel> {
  PaymentHomePageView(ProviderBase model) : super(model);

  final List pages = [
    AddSendMoneyContactPage(),
    AddRequestMoneyContactPage(),
    Container()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.only(bottom: 47),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          print("current step : $currentStep");
          return GestureDetector(
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
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
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
  }
}
