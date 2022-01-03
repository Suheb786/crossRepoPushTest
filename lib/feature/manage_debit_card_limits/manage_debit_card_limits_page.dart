import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_debit_card_limits_page_view.dart';

class ManageDebitCardLimitsPage
    extends BasePage<ManageDebitCardLimitsPageViewModel> {
  @override
  ManageDebitCardLimitsPageState createState() =>
      ManageDebitCardLimitsPageState();
}

class ManageDebitCardLimitsPageState extends BaseStatefulPage<
    ManageDebitCardLimitsPageViewModel, ManageDebitCardLimitsPage> {
  @override
  ProviderBase provideBase() {
    return manageCardLimitsViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, ManageDebitCardLimitsPageViewModel model) {
    return ManageDebitCardLimitsPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }
}
