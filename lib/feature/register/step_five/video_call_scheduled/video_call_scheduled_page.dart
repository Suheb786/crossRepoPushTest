import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/video_call_scheduled/video_call_scheduled_view.dart';
import 'package:neo_bank/feature/register/step_five/video_call_scheduled/video_call_scheduled_view_model.dart';

class VideoCallScheduledPage extends BasePage<VideoCallScheduledViewModel> {
  final VideoCallScheduledArguments _arguments;

  VideoCallScheduledPage(this._arguments);

  @override
  VideoCallScheduledPageState createState() => VideoCallScheduledPageState();
}

class VideoCallScheduledPageState
    extends BaseStatefulPage<VideoCallScheduledViewModel, VideoCallScheduledPage> {
  @override
  ProviderBase provideBase() {
    return videoCallScheduledViewModelProvider.call(widget._arguments);
  }

  @override
  Widget buildView(BuildContext context, VideoCallScheduledViewModel model) {
    return VideoCallScheduledView(provideBase());
  }
}

class VideoCallScheduledArguments {
  final String? applicationId;
  final String? date;
  final String? time;

  VideoCallScheduledArguments({this.applicationId: "", this.date: "", this.time: ""});
}
