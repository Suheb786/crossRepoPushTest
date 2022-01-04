import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_view_model.dart';

class DebitCardSettingsPage extends BasePage<DebitCardSettingsViewModel> {
  @override
  DebitCardSettingsPageState createState() => DebitCardSettingsPageState();
}

class DebitCardSettingsPageState extends BaseStatefulPage<
    DebitCardSettingsViewModel, DebitCardSettingsPage> {
  @override
  ProviderBase provideBase() {
    return debitCardSettingsViewModelProvider;
  }

  // @override
  // Color? scaffoldBackgroundColor() {
  //   return Theme.of(context).canvasColor;
  // }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Widget buildView(BuildContext context, DebitCardSettingsViewModel model) {
    return DebitCardSettingsPageView(provideBase());
  }
}
