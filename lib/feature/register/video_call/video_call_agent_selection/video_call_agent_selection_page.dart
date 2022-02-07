import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/video_call/video_call_agent_selection/video_call_agent_selection_page_view.dart';
import 'package:neo_bank/feature/register/video_call/video_call_agent_selection/video_call_agent_selection_page_view_model.dart';

class VideoCallAgentSelectionPage
    extends BasePage<VideoCallAgentSelectionPageViewModel> {
  @override
  VideoCallAgentSelectionPageState createState() =>
      VideoCallAgentSelectionPageState();
}

class VideoCallAgentSelectionPageState extends BaseStatefulPage<
    VideoCallAgentSelectionPageViewModel, VideoCallAgentSelectionPage> {
  @override
  ProviderBase provideBase() {
    return videoCallAgentSelectionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(VideoCallAgentSelectionPageViewModel model) {
    model.countDownController =
        CountdownTimerController(endTime: model.endTime);
  }

  @override
  Widget buildView(
      BuildContext context, VideoCallAgentSelectionPageViewModel model) {
    return VideoCallAgentSelectionPageView(provideBase());
  }
}
