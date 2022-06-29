import 'package:domain/model/payment/payment_activity_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';
import 'package:neo_bank/feature/activity/notification/notification_page.dart';
import 'package:neo_bank/feature/activity/payment_activity/payment_activity_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/cutom_route.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ActivityHomePageView extends BasePageViewWidget<ActivityHomeViewModel> {
  ActivityHomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {},
      child: Padding(
        padding: EdgeInsetsDirectional.only(bottom: 47),
        child: AppStreamBuilder<Resource<List<PaymentActivityData>>>(
            stream: model.paymentActivityListStream,
            initialData: Resource.none(),
            dataBuilder: (context, paymentListData) {
              return AppStreamBuilder<int>(
                stream: model.currentStep,
                initialData: 0,
                dataBuilder: (context, currentStep) {
                  return GestureDetector(
                    onVerticalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        if (currentStep == 1 &&
                            paymentListData!.data!.length > 4) {
                          Navigator.push(
                              context,
                              CustomRoute.createRoute(
                                  PaymentActivityTransactionPage()));
                        }
                      } else {
                        if (details.primaryVelocity! > 0.5) {
                          Navigator.pop(context);
                        }
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(top: 75),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppSvg.asset(AssetUtils.book),
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 9),
                            child: Text(
                              S.of(context).activity,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 18),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(top: 30),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(top: 4),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        fit: StackFit.expand,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.only(
                                                bottom: 20.0),
                                            child: AppSwiper(
                                              appSwiperController:
                                                  model.appSwiperController,
                                              pages: [
                                                NotificationPage(),
                                                PaymentActivityPage(),
                                                Container()
                                              ],
                                              pageController:
                                                  model.pageController,
                                              onIndexChanged: (index) {
                                                model.updatePage(index);
                                                model
                                                    .updatePageControllerStream(
                                                        index);
                                              },
                                              currentStep: currentStep,
                                            ),
                                          ),
                                          Visibility(
                                            visible: currentStep == 1 &&
                                                paymentListData!.data!.length >
                                                    4,
                                            child: Positioned(
                                              bottom: 0,
                                              child: Column(
                                                children: [
                                                  AppSvg.asset(
                                                      AssetUtils.swipeUp),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(top: 2),
                                                    child: Text(
                                                      "Swipe to view more",
                                                      style: TextStyle(
                                                          color: AppColor
                                                              .dark_gray_2,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.only(top: 5),
                                    child: SmoothPageIndicator(
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
              );
            }),
      ),
    );
  }
}
