import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_four/account_ready/account_ready_page.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page.dart';
import 'package:neo_bank/feature/register/step_four/upload_documents/upload_documents_page.dart';

class RegisterStepFourPageView
    extends BasePageViewWidget<RegisterStepFourViewModel> {
  RegisterStepFourPageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    ReviewApplicationPage(),
    UploadDocumentsPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.registrationStepFourPageController,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Opacity(
              opacity: pageViewIndex == model.currentPage ? 1 : 0.4,
              child: Transform.rotate(
          angle: pageViewIndex == model.currentPage
                ? 0
                : pageViewIndex < model.currentPage
                    ? -0.03491
                    : 0.03491,
          child: pages[itemIndex],
        ),
            ),
        options: CarouselOptions(
            height: double.maxFinite,
            pageSnapping: true,
            enableInfiniteScroll: false,
            viewportFraction: 0.8,
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
