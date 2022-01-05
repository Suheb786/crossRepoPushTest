import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card/supplementary_debit_card_page_view_model.dart';

class SupplementaryDebitCardPage
    extends BasePage<SupplementaryDebitCardPageViewModel> {
  @override
  SupplementaryDebitCardPageState createState() =>
      SupplementaryDebitCardPageState();
}

class SupplementaryDebitCardPageState extends BaseStatefulPage<
    SupplementaryDebitCardPageViewModel, SupplementaryDebitCardPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryDebitCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, SupplementaryDebitCardPageViewModel model) {
    return SupplementaryDebitCardPageView(provideBase());
  }
}
