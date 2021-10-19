import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_three/confirm_detail/confirm_detail_page.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page.dart';
import 'package:neo_bank/feature/register/step_three/enter_address/enter_address_page.dart';
import 'package:neo_bank/feature/register/step_three/id_verification_info/id_verification_info_page.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page.dart';
import 'package:neo_bank/feature/register/step_three/register_step_three_page_view_model.dart';
import 'package:neo_bank/feature/register/step_three/tax_report_information/tax_report_information_page.dart';
import 'package:neo_bank/feature/register/step_three/taxation_details/taxation_details_page.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';

class RegisterStepThreePageView
    extends BasePageViewWidget<RegisterStepThreeViewModel> {
  RegisterStepThreePageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    IdVerificationInfoPage(),
    ConfirmDetailPage(),
    EnterAddressPage(),
    ProfileDetailsPage(),
    EmploymentStatusPage(),
    TaxationDetailsPage(),
    TaxReportInformationPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.registrationStepThreePageController,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            AppTiltCard(
                pageViewIndex: pageViewIndex,
                currentPage: model.currentPage,
                child: pages[itemIndex]),
        options: CarouselOptions(
            height: double.maxFinite,
            pageSnapping: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            enlargeCenterPage: true,
            scrollPhysics: NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
              model.currentPage = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.scale),
      ),
    );
  }
}