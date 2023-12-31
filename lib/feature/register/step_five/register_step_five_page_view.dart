import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/agent_selection/agent_selection_page.dart';
import 'package:neo_bank/feature/register/step_five/register_step_five_page_view_model.dart';
import 'package:neo_bank/feature/register/step_five/review_application/review_application_page.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page.dart';
import 'package:neo_bank/feature/register/step_five/upload_documents/upload_documents_page.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:show_up_animation/show_up_animation.dart';

class RegisterStepFivePageView extends BasePageViewWidget<RegisterStepFiveViewModel> {
  RegisterStepFivePageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    ReviewApplicationPage(),
    VideoCallInfoPage(),
    AgentSelectionPage(),
    ScheduleVideoCallPage(),
    UploadDocumentsPage(),
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
                getHeader(currentStep, context),
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
                    StepTextHelper.registrationFiveStepTextHelper(
                      currentStep ?? 0,
                      S.of(context).confirmYourInformation,
                      S.of(context).videoCallInfoHeader,
                      S.of(context).videoCallInfoHeader,
                      S.of(context).pleaseSelectPreferredAgentForVideoCall,
                      S.of(context).pleaseUploadNecessaryInfo,
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
                  // key: ValueKey(currentStep),
                  pages: pages,
                  appSwiperController: model.appSwiperController,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                  currentStep: currentStep,
                  pageController: model.registrationStepFivePageController,
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
        return S.of(context).videoCall;
      case 4:
        return S.of(context).uploadDocuments;

      default:
        return S.of(context).reviewApplication;
    }
  }
}
