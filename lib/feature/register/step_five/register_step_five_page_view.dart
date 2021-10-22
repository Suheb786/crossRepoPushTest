import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_page.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_page.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';

class RegisterStepFivePageView
    extends BasePageViewWidget<RegisterStepFiveViewModel> {
  RegisterStepFivePageView(ProviderBase model) : super(model);

  List<Widget> pages = [
    ReviewApplicationPage(),
    VideoCallInfoPage(),
    AgentSelectionPage(),
    ScheduleVideoCallPage(),
    UploadDocumentsPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36),
      child: CarouselSlider.builder(
        itemCount: pages.length,
        carouselController: model.registrationStepFivePageController,
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
