import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/help_center/help_center_modules.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view.dart';
import 'package:neo_bank/feature/help_center/active_call/active_call_page_view_model.dart';

class ActiveCallPage extends BasePage<ActiveCallPageViewModel> {
  @override
  ActiveCallPagePageState createState() => ActiveCallPagePageState();
}

class ActiveCallPagePageState
    extends BaseStatefulPage<ActiveCallPageViewModel, ActiveCallPage> {
  @override
  ProviderBase provideBase() {
    return activeCallPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ActiveCallPageViewModel model) {
    return ActiveCallPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}
