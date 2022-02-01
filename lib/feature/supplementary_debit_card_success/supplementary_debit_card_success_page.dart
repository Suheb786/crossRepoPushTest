import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card_success/supplementary_debit_card_success_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card_success/supplementary_debit_card_success_page_view_model.dart';

class SupplementaryDebitCardSuccessPage
    extends BasePage<SupplementaryDebitCardSuccessPageViewModel> {
  @override
  SupplementaryDebitCardSuccessPageState createState() =>
      SupplementaryDebitCardSuccessPageState();
}

class SupplementaryDebitCardSuccessPageState extends BaseStatefulPage<
    SupplementaryDebitCardSuccessPageViewModel,
    SupplementaryDebitCardSuccessPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryDebitCardSuccessViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, SupplementaryDebitCardSuccessPageViewModel model) {
    return SupplementaryDebitCardSuccessPageView(provideBase());
  }
}
