import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_cliq/manage_cliq_modules.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/click_id_type_selection/cliq_id_type_selection_page.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/create_cliq_id_page_view_model.dart';
import 'package:neo_bank/feature/manage_cliq_id/create_cliq_id/enter_otp_for_cliq_id/enter_otp_for_cliq_id_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'link_bank_account_cliqId/link_bank_account_cliqId_page.dart';

class CreateCliqIdPageView extends BasePageViewWidget<CreateCliqIdPageViewModel> {
  final pages = [CliqIdTypeSelectionPage(), LinkBankAccountCliqIdPage(), EnterOtpForCliqIdPage()];

  CreateCliqIdPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).primaryColor,
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
                      S.of(context).createNewCliqId.toUpperCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 10.t,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0.h, bottom: currentStep == 2 ? 0.h : 32.h, start: 24.w, end: 24.w),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: AppStreamBuilder<String>(
                            initialData: S.of(context).letsCreateNewCliqId,
                            stream: model.changeHeaderWhileEnteringText,
                            dataBuilder: (context, header) {
                              return Text(
                                StepTextHelper.accountRegistrationTextHelper(
                                  currentStep ?? 0,
                                  header!,
                                  S.of(context).linkBankAccountToYourNewId,
                                  S.of(context).enterOtpHeader,
                                ),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 20.t,
                                    fontWeight: FontWeight.w600),
                              );
                            }),
                      ),
                    ),
                    Visibility(
                      visible: currentStep == 2,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 32.h),
                        child: ShowUpAnimation(
                          delayStart: Duration(milliseconds: 500),
                          animationDuration: Duration(milliseconds: 750),
                          curve: Curves.bounceIn,
                          direction: Direction.vertical,
                          offset: 0.5,
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Text(
                              "${(ProviderScope.containerOf(context).read(linkBankAccountCliqIdViewModelProvider).mobileCode.replaceAll('00', '+'))}" +
                                  " ${ProviderScope.containerOf(context).read(linkBankAccountCliqIdViewModelProvider).mobileNumber}",
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
