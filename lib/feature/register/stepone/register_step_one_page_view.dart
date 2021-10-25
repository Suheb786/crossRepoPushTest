import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/stepone/addnumber/add_number_page.dart';
import 'package:neo_bank/feature/register/stepone/countryselection/country_selection_page.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_page.dart';
import 'package:neo_bank/feature/register/stepone/notify/notify_page.dart';
import 'package:neo_bank/feature/register/stepone/register_step_one_page_model.dart';
import 'package:neo_bank/feature/register/stepone/validateotp/validate_otp_page.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';

class RegisterStepOnePageView
    extends BasePageViewWidget<RegisterStepOneViewModel> {
  RegisterStepOnePageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    CountrySelectionPage(),
    //NotifyPage(),
    AddNumberPage(),
    ValidateOtpPage(),
    CreatePasswordPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.pageController,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            AppTiltCard(
                pageViewIndex: pageViewIndex,
                currentPage: model.currentPage,
                child: pages[itemIndex]),
        options: CarouselOptions(
            height: double.maxFinite,
            pageSnapping: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.92,
            //enlargeCenterPage: true,
            scrollPhysics: NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
              model.currentPage = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.scale),
      ),
    );
  }
}
