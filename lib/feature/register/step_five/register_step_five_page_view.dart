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
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_tilt_card.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

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
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              Text(
                getHeader(currentStep, context),
                style: TextStyle(
                    color: AppColor.dark_gray,
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
                    StepTextHelper.registrationFiveStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).confirmYourInformation,
                      S.of(context).videoCallInfoHeader,
                      S.of(context).agentSelectionHeader,
                      S.of(context).pleaseSelectPreferredAgentForVideoCall,
                      S.of(context).pleaseUploadNecessaryInfo,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.very_dark_gray,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                  itemCount: pages.length,
                  carouselController: model.registrationStepFivePageController,
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

  String getHeader(int? currentStep, BuildContext context) {
    switch (currentStep) {
      case 0:
        return S.of(context).reviewApplication;
      case 1:
      case 2:
      case 3:
        return S.of(context).personalDetails;
      case 4:
        return S.of(context).uploadDocuments;
      default:
        return S.of(context).reviewApplication;
    }
  }
}
