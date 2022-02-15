import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/video_call/schdeule_video_call_later/schedule_video_call_later_page.dart';
import 'package:neo_bank/feature/register/video_call/video_call_agent_selection/video_call_agent_selection_page.dart';
import 'package:neo_bank/feature/register/video_call/video_call_information/video_call_information_page.dart';
import 'package:neo_bank/feature/register/video_call/video_call_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/pager/app_swiper.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/parser/step_text_helper.dart';
import 'package:show_up_animation/show_up_animation.dart';

class VideoCallPagePageView extends BasePageViewWidget<VideoCallPageViewModel> {
  VideoCallPagePageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    VideoCallInformationPage(),
    VideoCallAgentSelectionPage(),
    ScheduleVideoCallLaterPage()
  ];

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 56),
      child: AppStreamBuilder<int>(
        stream: model.currentStep,
        initialData: 0,
        dataBuilder: (context, currentStep) {
          return Column(
            children: [
              DotsIndicator(
                dotsCount: 5,
                position: 4,
                mainAxisSize: MainAxisSize.max,
                decorator: DotsDecorator(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    activeSize: Size(MediaQuery.of(context).size.width / 6, 4),
                    size: Size(MediaQuery.of(context).size.width / 6, 4),
                    spacing: EdgeInsets.symmetric(horizontal: 1),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    activeColor: Theme.of(context).accentColor,
                    color:
                        Theme.of(context).primaryColorLight.withOpacity(0.3)),
              ),
              SizedBox(
                height: 36,
              ),
              Text(
                S.of(context).videoCall,
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
                    StepTextHelper.cardDeliveryTextHelper(
                      currentStep ?? 0,
                      S.of(context).videoCallInfoHeader,
                      S.of(context).videoCallInfoHeader,
                      S.of(context).pleaseSelectPreferredAgentForVideoCall,
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
                child: AppSwiper(
                  //key: ValueKey(currentStep),
                  appSwiperController: model.appSwiperController,
                  pages: pages,
                  onIndexChanged: (index) {
                    model.updatePage(index);
                  },
                  currentStep: currentStep,
                  pageController: model.videoCallPageController,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
