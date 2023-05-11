import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/id_scan_verification_info/supplementary_id_scan_verification_info_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/personalize_debit_card/personalize_debit_card_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/relationship_with_cardholder_debit/relationship_with_cardholder_debit_page.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class SupplementaryDebitCardPageView extends BasePageViewWidget<SupplementaryDebitCardPageViewModel> {
  final pages = [
    RelationshipWithCardholderDebitPage(),
    SupplementaryIdScanVerificationInfoDebitPage(),
    PersonalizeDebitCardPage()
  ];

  SupplementaryDebitCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      color: Theme.of(context).canvasColor,
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
                  position: currentPage!,
                  mainAxisSize: MainAxisSize.max,
                  decorator: DotsDecorator(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeSize: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      size: Size(MediaQuery.of(context).size.width / 3.7, 5),
                      spacing: EdgeInsets.symmetric(horizontal: 1),
                      activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      activeColor: Theme.of(context).primaryColorDark,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.1)),
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
                      currentStep == 2
                          ? S.of(context).applyDebitCard
                          : S.of(context).requestSupplementaryCard.toUpperCase(),
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 10,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 8.0, bottom: 32, start: 24, end: 24),
                      child: ShowUpAnimation(
                        key: ValueKey(currentStep),
                        delayStart: Duration(milliseconds: 50),
                        animationDuration: Duration(milliseconds: 750),
                        curve: Curves.easeInOut,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Text(
                          StepTextHelper.cardDeliveryTextHelper(
                            currentStep ?? 0,
                            S.of(context).whatRelationshipWithCardHolder,
                            S.of(context).provideSupplementaryCardId,
                            S.of(context).setupAndPersonalizeYourNewDebitCard,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppSwiper(
                        pages: pages,
                        appSwiperController: model.appSwiperController,
                        pageController: model.swiperController,
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
