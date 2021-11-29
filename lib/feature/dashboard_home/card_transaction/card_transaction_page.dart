import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';

class CardTransactionPage extends BasePage<CardTransactionViewModel> {
  @override
  DebitCardDeliveredPageState createState() => DebitCardDeliveredPageState();
}

class DebitCardDeliveredPageState
    extends BaseStatefulPage<CardTransactionViewModel, CardTransactionPage> {
  @override
  ProviderBase provideBase() {
    return cardTransactionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, CardTransactionViewModel model) {
    return CardTransactionPageView(provideBase());
  }
}
