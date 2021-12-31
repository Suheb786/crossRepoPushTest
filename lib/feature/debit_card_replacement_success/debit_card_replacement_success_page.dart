import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';

class DebitCardReplacementSuccessPage
    extends BasePage<DebitCardReplacementSuccessPageViewModel> {
  @override
  DebitCardReplacementSuccessPageState createState() =>
      DebitCardReplacementSuccessPageState();
}

class DebitCardReplacementSuccessPageState extends BaseStatefulPage<
    DebitCardReplacementSuccessPageViewModel, DebitCardReplacementSuccessPage> {
  @override
  ProviderBase provideBase() {
    return cardReplacementSuccessViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, DebitCardReplacementSuccessPageViewModel model) {
    return DebitCardReplacementSuccessPageView(provideBase());
  }
}
