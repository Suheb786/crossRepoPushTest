import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/non_jordanian_register/non_jordanian_register_modules.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page_view.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page_view_model.dart';

class NotifySuccessPage extends BasePage<NotifySuccessPageViewModel> {
  final NotifySuccessArguments? notifySuccessArguments;

  NotifySuccessPage({this.notifySuccessArguments});

  @override
  NotifySuccessPageState createState() => NotifySuccessPageState();
}

class NotifySuccessPageState
    extends BaseStatefulPage<NotifySuccessPageViewModel, NotifySuccessPage> {
  @override
  ProviderBase provideBase() {
    return notifySuccessViewModelProvider.call(widget.notifySuccessArguments!);
  }

  @override
  Widget buildView(BuildContext context, NotifySuccessPageViewModel model) {
    return NotifySuccessPageView(provideBase());
  }
}

class NotifySuccessArguments {
  final String referenceNo;

  NotifySuccessArguments({required this.referenceNo});
}
