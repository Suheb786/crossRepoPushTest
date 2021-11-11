import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/addnumber/add_number_page.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_page.dart';
import 'package:neo_bank/feature/account_registration/validateotp/validate_otp_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class AccountRegistrationPageView
    extends BasePageViewWidget<AccountRegistrationPageViewModel> {
  AccountRegistrationPageView(ProviderBase model) : super(model);

  List pages = [
    // CountrySelectionPage(),
    AddNumberPage(),
    ValidateOtpPage(),
    CreatePasswordPage()
  ];

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
                  dotsCount: pages.length,
                  position: currentPage!.toDouble(),
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      activeSize:
                          Size(MediaQuery.of(context).size.width / 5, 4),
                      size: Size(MediaQuery.of(context).size.width / 5, 4),
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
            child: PageView.builder(
              itemCount: pages.length,
              physics: NeverScrollableScrollPhysics(),
              controller: model.accountRegistrationStepsController,
              onPageChanged: (currentPage) {
                model.changeCurrentPage(currentPage);
              },
              itemBuilder: (context, index) {
                return Padding(
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
                                color: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 8.0,
                                bottom: currentStep == 1 ? 0 : 32,
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
                                    S.of(context).whatYourEmailAndMobileNumber,
                                    S.of(context).enterOtpHeader,
                                    S.of(context).createPasswordHeader),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyText1!
                                        .color,
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
                                  '+962 79 322 8080',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: CarouselSlider.builder(
                              itemCount: pages.length,
                              carouselController: model.pageController,
                              itemBuilder: (BuildContext context, int itemIndex,
                                      int pageViewIndex) =>
                                  AppTiltCard(
                                      pageViewIndex: pageViewIndex,
                                      currentPage: currentStep,
                                      child: pages[itemIndex]),
                              options: CarouselOptions(
                                  height: double.maxFinite,
                                  pageSnapping: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 0.88,
                                  enableInfiniteScroll: false,
                                  scrollPhysics: NeverScrollableScrollPhysics(),
                                  onPageChanged: (index, reason) {
                                    model.changeCurrentPage(index);
                                  },
                                  enlargeStrategy:
                                      CenterPageEnlargeStrategy.height),
                            ),
                          ),
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
