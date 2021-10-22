import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/notify/notify_modules.dart';
import 'package:neo_bank/feature/register/stepone/notify/notify_page_view.dart';
import 'package:neo_bank/feature/register/stepone/notify/notify_page_view_model.dart';

class NotifyPage extends BasePage<NotifyPageViewModel> {
  @override
  NotifyPageState createState() => NotifyPageState();
}

class NotifyPageState
    extends BaseStatefulPage<NotifyPageViewModel, NotifyPage> {
  @override
  ProviderBase provideBase() {
    return notifyViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, NotifyPageViewModel model) {
    return NotifyPageView(provideBase());
  }
}
