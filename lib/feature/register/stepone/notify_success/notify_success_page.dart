import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/notify/notify_modules.dart';
import 'package:neo_bank/feature/register/stepone/notify_success/notify_success_page_view.dart';
import 'package:neo_bank/feature/register/stepone/notify_success/notify_success_page_view_model.dart';

class NotifySuccessPage extends BasePage<NotifySuccessPageViewModel> {
  @override
  NotifySuccessPageState createState() => NotifySuccessPageState();
}

class NotifySuccessPageState
    extends BaseStatefulPage<NotifySuccessPageViewModel, NotifySuccessPage> {
  @override
  ProviderBase provideBase() {
    return notifySuccessViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NotifySuccessPageViewModel model) {
    return NotifySuccessPageView(provideBase());
  }
}
