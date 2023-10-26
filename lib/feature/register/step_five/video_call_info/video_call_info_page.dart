import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_model.dart';
import 'package:neo_bank/feature/register/step_five/video_call_info/video_call_info_view.dart';

class VideoCallInfoPage extends BasePage<VideoCallInfoViewModel> {
  @override
  VideoCallInfoPageState createState() => VideoCallInfoPageState();
}

class VideoCallInfoPageState extends BaseStatefulPage<VideoCallInfoViewModel, VideoCallInfoPage> {
  @override
  ProviderBase provideBase() {
    return videoCallInfoViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, VideoCallInfoViewModel model) {
    return VideoCallInfoView(provideBase());
  }

  @override
  Future<bool> onBackPressed(VideoCallInfoViewModel model, {param}) async {
    return false;
  }
}
