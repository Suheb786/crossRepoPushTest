import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/video_call/video_call_page_view.dart';
import 'package:neo_bank/feature/register/video_call/video_call_page_view_model.dart';

class VideoCallPage extends BasePage<VideoCallPageViewModel> {
  @override
  VideoCallPageState createState() => VideoCallPageState();
}

class VideoCallPageState extends BaseStatefulPage<VideoCallPageViewModel, VideoCallPage> {
  @override
  ProviderBase provideBase() {
    return videoCallViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, VideoCallPageViewModel model) {
    return VideoCallPagePageView(provideBase());
  }
}
