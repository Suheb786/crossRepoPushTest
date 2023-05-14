import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/feature/non_jordanian_register/non_jordanian_register_page_view_model.dart';
import 'package:neo_bank/feature/non_jordanian_register/notify/notify_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class NonJordanianRegisterPageView extends BasePageViewWidget<NonJordanianRegisterPageViewModel> {
  NonJordanianRegisterPageView(ProviderBase model) : super(model);

  final List pages = [NotifyPage(), BaseCardPage()];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
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
                  dotsCount: pages.length - 1,
                  position: currentPage!,
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 1.2, 4),
                      size: Size(MediaQuery.of(context).size.width / 1.2, 4),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).primaryColorLight.withOpacity(0.3)),
                );
              },
            ),
          ),
          Expanded(
            child: PageView.builder(
              itemCount: pages.length,
              physics: NeverScrollableScrollPhysics(),
              controller: model.nonJordanianRegistrationStepsController,
              onPageChanged: (currentPage) {
                model.changeCurrentPage(currentPage);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 36.h),
                  child: AppStreamBuilder<int>(
                    stream: model.currentPageStream,
                    initialData: 0,
                    dataBuilder: (context, currentStep) {
                      return Column(
                        children: [
                          Text(
                            S.of(context).notifyMe,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 10.t,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(top: 8.0.h, bottom: 32.h, start: 24.w, end: 24.w),
                            child: ShowUpAnimation(
                              key: ValueKey(currentStep),
                              delayStart: Duration(milliseconds: 50),
                              animationDuration: Duration(milliseconds: 750),
                              curve: Curves.easeInOut,
                              direction: Direction.vertical,
                              offset: 0.5,
                              child: Text(
                                S.of(context).pleaseEnterLatestEmail,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 20.t,
                                    fontWeight: FontWeight.w600),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
