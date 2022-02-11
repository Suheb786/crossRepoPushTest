import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_page.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_page.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/base_card/base_card_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class AccountRegistrationPageView
    extends BasePageViewWidget<AccountRegistrationPageViewModel> {
  final pages = [
    // CountrySelectionPage(),
    AddNumberPage(),
    CreatePasswordPage(),
    ValidateOtpPage(),
    BaseCardPage()
  ];

  AccountRegistrationPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
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
                  dotsCount: pages.length - 1,
                  position: currentPage!.toDouble(),
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeSize:
                          Size(MediaQuery.of(context).size.width / 3.7, 5),
                      size: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).accentColor,
                      color:
                          Theme.of(context).primaryColorLight.withOpacity(0.3)),
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
                      S.of(context).accountRegistration,
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: currentStep == 2 ? 0 : 32,
                          left: 24,
                          right: 24),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.accountRegistrationTextHelper(
                            currentStep ?? 0,
                            S.of(context).enterYourEmailAndMobile,
                            S.of(context).createPasswordHeader,
                            S.of(context).enterOtpHeader,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    AppStreamBuilder<MobileNumberParams>(
                        stream: model.mobileNumberStream,
                        initialData: MobileNumberParams(),
                        dataBuilder: (context, mobileNumber) {
                          return Visibility(
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
                                  "${mobileNumber!.mobileCode.isNotEmpty ? (mobileNumber.mobileCode.contains('00') ? mobileNumber.mobileCode.replaceAll('00', '+') : '+${mobileNumber.mobileCode}') : '-'} "
                                  "${mobileNumber.mobileNumber}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          );
                        }),
                    Expanded(
                      child: AppStreamBuilder<bool>(
                          stream: model.swipeEnableStream,
                          initialData: false,
                          dataBuilder: (context, data) {
                            print("SWIPER VALUE FROM VIEW ::::: $data");
                            return AppSwiper(
                              pages: pages,
                              appSwiperController: model.appSwiperController,
                              pageController: model.pageController,
                              swipeEnable: data,
                              onIndexChanged: (index) {
                                model.changeCurrentPage(index);
                              },
                              currentStep: currentStep,
                            );
                          }),
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
