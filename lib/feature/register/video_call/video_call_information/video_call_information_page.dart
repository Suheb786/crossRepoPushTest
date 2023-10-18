import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/video_call/video_call_information/video_call_information_page_view.dart';
import 'package:neo_bank/feature/register/video_call/video_call_information/video_call_information_page_view_model.dart';

class VideoCallInformationPage extends BasePage<VideoCallInformationPageViewModel> {
  @override
  VideoCallInformationPageState createState() => VideoCallInformationPageState();
}

class VideoCallInformationPageState
    extends BaseStatefulPage<VideoCallInformationPageViewModel, VideoCallInformationPage> {
  @override
  ProviderBase provideBase() {
    return videoCallInformationPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, VideoCallInformationPageViewModel model) {
    return VideoCallInformationPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(VideoCallInformationPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(videoCallViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
