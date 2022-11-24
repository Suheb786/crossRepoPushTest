import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page_view.dart';
import 'package:neo_bank/feature/register/step_five/schedule_video_call/schedule_video_call_page_view_model.dart';

class ScheduleVideoCallPage extends BasePage<ScheduleVideoCallPageViewModel> {
  @override
  ScheduleVideoCallPageState createState() => ScheduleVideoCallPageState();
}

class ScheduleVideoCallPageState
    extends BaseStatefulPage<ScheduleVideoCallPageViewModel, ScheduleVideoCallPage> {
  @override
  ProviderBase provideBase() {
    return scheduleVideoCallPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ScheduleVideoCallPageViewModel model) {
    return ScheduleVideoCallPageView(provideBase());
  }
}
