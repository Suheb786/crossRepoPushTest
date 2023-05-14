import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_signature/fatca_signature_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8/fatca_us_relevant_w8_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9/fatca_us_relevant_w9_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w9_tax_payer_details/fatca_us_w9_tax_payer_details_page.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

import 'fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page.dart';
import 'fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page.dart';

class RegisterStepFourPageView extends BasePageViewWidget<RegisterStepFourViewModel> {
  RegisterStepFourPageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    TaxationDetailsPage(),
    FatcaUSRelevantW8Page(),
    FatcaUSRelevantW8AddressDetailsPage(),
    FatcaUSW8TaxPayersDetailsPage(),
    FatcaUSRelevantW9Page(),
    FatcaUSRelevantW9AddressDetailsPage(),
    FatcaUSW9TaxPayersDetailsPage(),
    FatcaSignaturePage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.h),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                S.of(context).otherDetails,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 10.t,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(top: 8.0.h, bottom: 32.h, start: 24.w, end: 24.w),
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
                      S.of(context).fewMoreQuestions,
                      S.of(context).weNeedToMatchNamesONTaxReturn,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).weNeedToMatchNamesONTaxReturn,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).pleaseProvideInformationIfAppliesToYou,
                      S.of(context).consentForSignatureUpload,
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
              Expanded(
                child: AppSwiper(
                  pageController: model.registrationStepFourPageController,
                  appSwiperController: model.appSwiperController,
                  pages: pages,
                  currentStep: currentStep,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
