import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/video_call/schdeule_video_call_later/schedule_video_call_later_page_view.dart';
import 'package:neo_bank/feature/register/video_call/schdeule_video_call_later/schedule_video_call_later_page_view_model.dart';

class ScheduleVideoCallLaterPage extends BasePage<ScheduleVideoCallLaterPageViewModel> {
  @override
  ScheduleVideoCallLaterPageState createState() => ScheduleVideoCallLaterPageState();
}

class ScheduleVideoCallLaterPageState
    extends BaseStatefulPage<ScheduleVideoCallLaterPageViewModel, ScheduleVideoCallLaterPage> {
  @override
  ProviderBase provideBase() {
    return scheduleVideoCallLaterPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ScheduleVideoCallLaterPageViewModel model) {
    return ScheduleVideoCallLaterPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ScheduleVideoCallLaterPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(videoCallViewModelProvider);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
