import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/apple_pay_launcher_page/apple_pay_launcher_modules.dart';

import 'apple_pay_launcher_page_view.dart';
import 'apple_pay_launcher_page_view_model.dart';

class ApplePayLauncherPage extends BasePage<ApplePayLauncherPageViewModel> {
  ApplePayLauncherPage();

  @override
  ApplePayLauncherPageState createState() => ApplePayLauncherPageState();
}

class ApplePayLauncherPageState
    extends BaseStatefulPage<ApplePayLauncherPageViewModel, ApplePayLauncherPage> {
  @override
  ProviderBase provideBase() {
    return applePayLauncherPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ApplePayLauncherPageViewModel model) {
    return ApplePayLauncherPageView(provideBase());
  }
}
