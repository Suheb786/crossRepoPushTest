// ignore_for_file: deprecated_member_use

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_otp/return_payment_otp_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_reason_selection/return_payment_reason_selection_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/return_payment_transaction/return_payment_transaction_slider_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ReturnPaymentTransactionSliderPageView
    extends BasePageViewWidget<ReturnPaymentTransactionSliderPageViewModel> {
  ReturnPaymentTransactionSliderPageView(ProviderBase model) : super(model);

  final List pages = [ReturnPaymentReasonSelectionPage(), ReturnPaymentOtpPage()];

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsetsDirectional.only(top: 56),
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
                      activeSize: Size(MediaQuery.of(context).size.width / 2.4, 5),
                      size: Size(MediaQuery.of(context).size.width / 2.4, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: AppColor.black,
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
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Text(
                        S.of(context).returnPayment.toUpperCase(),
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.black,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 8.0.h, start: 24.w, end: 24.w),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: AppStreamBuilder<String>(
                            initialData: S.of(context).selectTheReasonToReturn,
                            stream: model.changeHeaderWhileEnteringText,
                            dataBuilder: (context, header) {
                              return Text(
                                StepTextHelper.returnPaymentStepTextHelper(
                                  currentStep ?? 0,
                                  S.of(context).selectTheReasonToReturn,
                                  S.current.enterOtpHeader,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: AppColor.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: currentStep == 1,
                      child: ShowUpAnimation(
                        delayStart: Duration(milliseconds: 500),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.bounceIn,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            "${ProviderScope.containerOf(context).read(returnPaymentSelectionPageViewModelProvider).mobileCode?.replaceAll('00', '+')}" +
                                " " 
                                    "${ProviderScope.containerOf(context).read(returnPaymentSelectionPageViewModelProvider).mobileNumber}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
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
