import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page_view_model.dart';

class DebitCardReplacementPage
    extends BasePage<DebitCardReplacementPageViewModel> {
  @override
  DebitCardReplacementPageState createState() =>
      DebitCardReplacementPageState();
}

class DebitCardReplacementPageState extends BaseStatefulPage<
    DebitCardReplacementPageViewModel, DebitCardReplacementPage> {
  @override
  ProviderBase provideBase() {
    return debitCardReplacementViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, DebitCardReplacementPageViewModel model) {
    return DebitCardReplacementPageView(provideBase());
  }
}
