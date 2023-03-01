import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_settings/account_settings_modules.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/change_mobile_number_page_view.dart';
import 'package:neo_bank/feature/account_settings/change_mobile_number/change_mobile_number_page_view_model.dart';

class ChangeMobileNumberPage extends BasePage<ChangeMobileNumberPageViewModel> {
  @override
  ChangeMobileNumberPageState createState() => ChangeMobileNumberPageState();
}

class ChangeMobileNumberPageState
    extends BaseStatefulPage<ChangeMobileNumberPageViewModel, ChangeMobileNumberPage> {
  @override
  ProviderBase provideBase() {
    return changeMobileNumberViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ChangeMobileNumberPageViewModel model) {
    return ChangeMobileNumberPageView(provideBase());
  }
}
