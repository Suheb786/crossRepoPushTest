import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_settings/debit_card_settings_view_model.dart';

class DebitCardSettingsPage extends BasePage<DebitCardSettingsViewModel> {
  final DebitCardSettingsArguments debitCardSettingArguments;

  DebitCardSettingsPage(this.debitCardSettingArguments);

  @override
  DebitCardSettingsPageState createState() => DebitCardSettingsPageState();
}

class DebitCardSettingsPageState extends BaseStatefulPage<DebitCardSettingsViewModel, DebitCardSettingsPage> {
  @override
  ProviderBase provideBase() {
    return debitCardSettingsViewModelProvider.call(widget.debitCardSettingArguments);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Widget buildView(BuildContext context, DebitCardSettingsViewModel model) {
    return DebitCardSettingsPageView(provideBase());
  }
}

class DebitCardSettingsArguments {
  final DebitCard debitCard;
  final bool isPrimaryDebitCard;
  final bool debitCardRequestPhysicalCardEnabled;

  DebitCardSettingsArguments(
      {required this.debitCard,
      required this.isPrimaryDebitCard,
      this.debitCardRequestPhysicalCardEnabled = false});
}
