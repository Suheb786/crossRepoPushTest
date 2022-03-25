import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/card_transaction/card_transaction_view_model.dart';

class CardTransactionPage extends BasePage<CardTransactionViewModel> {
  final GetCreditCardTransactionArguments _creditCardTransactionArguments;

  CardTransactionPage(this._creditCardTransactionArguments);

  @override
  DebitCardDeliveredPageState createState() => DebitCardDeliveredPageState();
}

class DebitCardDeliveredPageState
    extends BaseStatefulPage<CardTransactionViewModel, CardTransactionPage> {
  @override
  ProviderBase provideBase() {
    return cardTransactionViewModelProvider
        .call(widget._creditCardTransactionArguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(CardTransactionViewModel model) {
    model.getTransactions(
        cardId: model.cardTransactionArguments.cardId!, noOfDays: 180);
  }

  @override
  Widget buildView(BuildContext context, CardTransactionViewModel model) {
    return CardTransactionPageView(provideBase());
  }
}

class GetCreditCardTransactionArguments {
  final String? cardId;

  GetCreditCardTransactionArguments({this.cardId: ""});
}
