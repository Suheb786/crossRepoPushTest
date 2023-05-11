import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_otp_screen/reject_request_payment_otp_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/reject_request_payment_page_view_model.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/reject_request_payment_screens/select_reject_reason/select_reject_reason_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RejectRequestPaymentPageView extends BasePageViewWidget<RejectRequestPaymentPageViewModel> {
  final pages = [SelectRejectReasonPage(), RejectRequestPaymentOtpPage()];

  RejectRequestPaymentPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: EdgeInsets.only(top: 56.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                      activeSize: Size(MediaQuery.of(context).size.width / 2.5.w, 5.h),
                      size: Size(MediaQuery.of(context).size.width / 2.5.w, 5.h),
                      spacing: EdgeInsets.symmetric(horizontal: 1.w),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: AppColor.black,
                      color: AppColor.gray1.withOpacity(0.3)),
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
                      S.of(context).returnPayment.toUpperCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.veryDarkGray2,
                          fontSize: 10.t,
                          fontWeight: FontWeight.w600),
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
                          child: Text(
                            StepTextHelper.registrationTwoStepTextHelper(
                              currentStep ?? 0,
                              S.of(context).selectReasonToReject,
                              S.of(context).enterOtpHeader,
                            ),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.veryDarkGray2,
                                fontSize: 20.t,
                                fontWeight: FontWeight.w600),
                          )),
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
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "${ProviderScope.containerOf(context).read(selectRejectReasonPageViewModelProvider).mobileCode.replaceAll('00', '+')}" +
                                  " ${ProviderScope.containerOf(context).read(selectRejectReasonPageViewModelProvider).mobileNumber}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.veryDarkGray2,
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
