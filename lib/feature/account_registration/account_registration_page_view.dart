import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_page.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'add_email/add_email_page.dart';
import 'add_email_otp/email_otp_page.dart';

class AccountRegistrationPageView extends BasePageViewWidget<AccountRegistrationPageViewModel> {
  final pages = [
    // CountrySelectionPage(),
    //CreatePasswordPage(),
    AddEmailPage(),
    EmailOtpPage(),
    AddNumberPage(),
    //CreatePasswordPage(),
    ValidateOtpPage(),
    BaseCardPage()
  ];

  AccountRegistrationPageView(ProviderBase model) : super(model);

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
                  dotsCount: pages.length - 1,
                  position: currentPage!,
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 4.7, 5),
                      size: Size(MediaQuery.of(context).size.width / 4.7, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
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
                      S.of(context).accountRegistration,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 10.t,
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 8.0.h,
                          bottom: currentStep == 1
                              ? 0
                              : currentStep == 3
                                  ? 0
                                  : 32.h,
                          start: 24.w,
                          end: 24.w),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.accountCreatationTextHelper(
                            currentStep ?? 0,
                            S.of(context).enterEmailAndPassword,
                            S.of(context).enterOtpHeader,
                            S.of(context).enterYourMobileNumber,
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
                    AppStreamBuilder<MobileNumberParams>(
                        stream: model.mobileNumberStream,
                        initialData: MobileNumberParams(),
                        dataBuilder: (context, mobileNumber) {
                          return Visibility(
                            visible: currentStep == 3,
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
                                    "${mobileNumber!.mobileCode.isNotEmpty ? (mobileNumber.mobileCode.contains('00') ? mobileNumber.mobileCode.replaceAll('00', '+') : '+${mobileNumber.mobileCode}') : '-'} "
                                    "${mobileNumber.mobileNumber}",
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
                          );
                        }),
                    AppStreamBuilder<String>(
                        stream: model.emailStream,
                        initialData: '',
                        dataBuilder: (context, email) {
                          return Visibility(
                            visible: currentStep == 1,
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
                                    email!,
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
                          );
                        }),
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
