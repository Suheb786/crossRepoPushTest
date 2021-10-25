import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/tax_report_information/tax_report_information_page.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';

import 'fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page.dart';
import 'fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page.dart';

class RegisterStepFourPageView
    extends BasePageViewWidget<RegisterStepFourViewModel> {
  RegisterStepFourPageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    TaxationDetailsPage(),
    FatcaUSRelevantW8Page(),
    FatcaUSRelevantW8AddressDetailsPage(),
    FatcaUSW8TaxPayersDetailsPage(),
    FatcaUSRelevantW9Page(),
    FatcaUSRelevantW9AddressDetailsPage(),
    FatcaUSW9TaxPayersDetailsPage(),
    TaxReportInformationPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.registrationStepFourPageController,
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
            scrollPhysics: NeverScrollableScrollPhysics(),
            onPageChanged: (index, reason) {
              model.currentPage = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.scale),
      ),
    );
  }
}
