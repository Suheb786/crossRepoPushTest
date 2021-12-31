import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_settings/debit_card_settings_modules.dart';
import 'package:neo_bank/feature/debit_card_settings/debit_card_settings_page_view.dart';
import 'package:neo_bank/feature/debit_card_settings/debit_card_settings_page_view_model.dart';

class DebitCardSettingsPage extends BasePage<DebitCardSettingsPageViewModel> {
  @override
  DebitCardSettingsPageState createState() => DebitCardSettingsPageState();
}

class DebitCardSettingsPageState extends BaseStatefulPage<
    DebitCardSettingsPageViewModel, DebitCardSettingsPage> {
  @override
  ProviderBase provideBase() {
    return debitCardSettingsViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, DebitCardSettingsPageViewModel model) {
    return DebitCardSettingsPageView(provideBase());
  }
}
