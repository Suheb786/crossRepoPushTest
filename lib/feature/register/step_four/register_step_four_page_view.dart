import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_four/agent_selection/agent_selection_page.dart';
import 'package:neo_bank/feature/register/step_four/register_step_four_page_view_model.dart';
import 'package:neo_bank/feature/register/step_four/review_application/review_application_page.dart';
import 'package:neo_bank/feature/register/step_four/upload_documents/upload_documents_page.dart';
import 'package:neo_bank/feature/register/step_four/video_call_info/video_call_info_page.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';

class RegisterStepFourPageView
    extends BasePageViewWidget<RegisterStepFourViewModel> {
  RegisterStepFourPageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    ReviewApplicationPage(),
    UploadDocumentsPage(),
    AgentSelectionPage(),
    VideoCallInfoPage(),
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
