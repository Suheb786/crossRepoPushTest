import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/enter_otp_for_evoucher_category_puchase/enter_otp_for_evoucher_category_puchase_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page.dart';

import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import '../../../di/dashboard/dashboard_modules.dart';

class PurchaseEVoucherPageView extends BasePageViewWidget<PurchaseEVoucherPageViewModel> {
  PurchaseEVoucherPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    final pages = [
      SelectRegionAmountPage(model.argument),
      EvoucherSettlementAccountPage(
        argument: model.argument,
      ),
      EnterOtpForEVoucherCategoryPurchasePage(model.argument),
    ];
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsetsDirectional.only(top: 56.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
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
            padding: EdgeInsets.symmetric(vertical: 36.h),
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
                          fontSize: 10.t,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0.h, bottom: currentStep == 2 ? 0.0 : 8.0.h, start: 24.h, end: 24.h),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.evoucherPurchaseTextHelper(
                            currentStep ?? 0,
                            S.of(context).selectPreferredRegionAmount,
                            S.of(context).howWouldLikeToPay,
                            S.of(context).enterOtpHeader,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 20.t,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Visibility(
                        visible: currentStep == 2,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 32),
                          child: ShowUpAnimation(
                            delayStart: Duration(milliseconds: 500),
                            animationDuration: Duration(milliseconds: 750),
                            curve: Curves.bounceIn,
                            direction: Direction.vertical,
                            offset: 0.5,
                            child: Text(
                              "${(ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileCode?.replaceAll('00', '+'))}" +
                                  " ${ProviderScope.containerOf(context).read(appHomeViewModelProvider).dashboardDataContent.mobileNumber}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 20.t,
                                  fontWeight: FontWeight.w600),
                            ),
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
