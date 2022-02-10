import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page_view.dart';
import 'package:neo_bank/feature/register/check_scheduled_videocall/check_scheduled_videocall_page_view_model.dart';

class CheckScheduledVideoCallPage
    extends BasePage<CheckScheduledVideoCallPageViewModel> {
  final CheckVideoCallScheduledArguments _callScheduledArguments;

  CheckScheduledVideoCallPage(this._callScheduledArguments);

  @override
  CheckScheduledVideoCallPageState createState() =>
      CheckScheduledVideoCallPageState();
}

class CheckScheduledVideoCallPageState extends BaseStatefulPage<
    CheckScheduledVideoCallPageViewModel, CheckScheduledVideoCallPage> {
  @override
  ProviderBase provideBase() {
    return checkRescheduledVideoCallViewModelProvider
        .call(widget._callScheduledArguments);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, CheckScheduledVideoCallPageViewModel model) {
    return CheckScheduledVideoCallPageView(provideBase());
  }
}

class CheckVideoCallScheduledArguments {
  final String scheduledDate;
  final String scheduledTime;
  final bool isExist;
  final bool isExpire;

  CheckVideoCallScheduledArguments({
    required this.scheduledDate,
    required this.scheduledTime,
    required this.isExist,
    required this.isExpire,
  });
}
