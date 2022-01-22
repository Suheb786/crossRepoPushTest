import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_settings/credit_card_settings_view_model.dart';

class CreditCardSettingsPage extends BasePage<CreditCardSettingsViewModel> {
  @override
  CreditCardSettingsPageState createState() => CreditCardSettingsPageState();
}

class CreditCardSettingsPageState extends BaseStatefulPage<
    CreditCardSettingsViewModel, CreditCardSettingsPage> {
  @override
  ProviderBase provideBase() {
    return creditCardSettingsViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, CreditCardSettingsViewModel model) {
    return CreditCardSettingsPageView(provideBase());
  }
}
