import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';

import 'launcher_page_view.dart';
import 'launcher_page_view_model.dart';

class LauncherPage extends BasePage<LauncherPageViewModel> {
  @override
  LauncherPageState createState() => LauncherPageState();
}

class LauncherPageState extends BaseStatefulPage<LauncherPageViewModel, LauncherPage> {
  @override
  ProviderBase provideBase() {
    return launcherPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, LauncherPageViewModel model) {
    return LauncherPageView(provideBase());
  }
}
