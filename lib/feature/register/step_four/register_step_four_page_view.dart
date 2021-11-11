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
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

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
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).fatcaandPep,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 8.0, bottom: 32, left: 24, right: 24),
                child: ShowUpAnimation(
                  key: ValueKey(currentStep),
                  delayStart: Duration(milliseconds: 50),
                  animationDuration: Duration(milliseconds: 750),
                  curve: Curves.easeInOut,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Text(
                    StepTextHelper.registrationFourStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).tellUsAboutImportantInformations,
                      S.of(context).weNeedToMatchNamesONTaxReturn,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).weNeedToMatchNamesONTaxReturn,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).taxReportInfoDesc,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: pages.length,
                  carouselController: model.registrationStepFourPageController,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      AppTiltCard(
                          pageViewIndex: pageViewIndex,
                          currentPage: currentStep,
                          child: pages[itemIndex]),
                  options: CarouselOptions(
                      height: double.maxFinite,
                      pageSnapping: true,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.88,
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      onPageChanged: (index, reason) {
                        model.updatePage(index);
                      },
                      enlargeStrategy: CenterPageEnlargeStrategy.height),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
