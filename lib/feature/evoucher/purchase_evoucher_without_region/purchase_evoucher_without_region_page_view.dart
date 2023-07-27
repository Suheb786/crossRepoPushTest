import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/settlement_amount/settlement_amount_page.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../base/base_page.dart';
import '../../../generated/l10n.dart';
import '../../../ui/molecules/pager/app_swiper.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';
import '../../../utils/parser/step_text_helper.dart';
import 'otp_purchase_evoucher_without_region/otp_purchase_evoucher_without_region_page.dart';

class PurchaseEVoucherWithoutRegionPageView
    extends BasePageViewWidget<PurchaseEVoucherWithoutRegionPageViewModel> {
  PurchaseEVoucherWithoutRegionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    final pages = [
      SettlementAccountPage(
        argument: model.argument,
      ),
      PurchaseEVoucherWithoutRegionPage(model.argument)
    ];
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 56),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: AppStreamBuilder<int>(
              initialData: 0,
              stream: model.currentPageStream,
              dataBuilder: (context, currentPage) {
                return DotsIndicator(
                  dotsCount: pages.length,
                  position: currentPage!,
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      size: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1.w),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).colorScheme.secondary,
                      color: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                );
              },
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: AppStreamBuilder<int>(
              stream: model.currentPageStream,
              initialData: 0,
              dataBuilder: (context, currentStep) {
                return Column(
                  children: [
                    Text(
                      S.of(context).eVouchers.toUpperCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0.h, bottom: currentStep == 1 ? 0.0 : 8.0.h, start: 24.h, end: 24.h),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.changeEmailAddressTextHelper(
                            currentStep ?? 0,
                            S.of(context).howWouldLikeToPay,
                            S.of(context).enterOtpHeader,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: currentStep == 1,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32),
                        child: ShowUpAnimation(
                          delayStart: Duration(milliseconds: 500),
                          animationDuration: Duration(milliseconds: 750),
                          curve: Curves.bounceIn,
                          direction: Direction.vertical,
                          offset: 0.5,
                          child: Text(
                            "+962 79 322 8080",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppSwiper(
                        pages: pages,
                        appSwiperController: model.appSwiperController,
                        pageController: model.pageController,
                        onIndexChanged: (index) {
                          model.changeCurrentPage(index);
                        },
                        currentStep: currentStep,
                      ),
                    )
                  ],
                );
              },
            ),
          )),
        ],
      ),
    );
  }
}
