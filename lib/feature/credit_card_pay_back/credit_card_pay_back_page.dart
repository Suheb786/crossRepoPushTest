import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page_view.dart';
import 'package:neo_bank/feature/credit_card_pay_back/credit_card_pay_back_page_view_model.dart';

class CreditCardPayBackPage extends BasePage<CreditCardPayBackPageModel> {
  final CreditCardPayBackArguments _creditCardPayBackArguments;

  CreditCardPayBackPage(this._creditCardPayBackArguments);

  @override
  CreditCardPayBackPageState createState() => CreditCardPayBackPageState();
}

class CreditCardPayBackPageState extends BaseStatefulPage<CreditCardPayBackPageModel, CreditCardPayBackPage> {
  @override
  ProviderBase provideBase() {
    return creditCardPayBackViewModelProvider.call(widget._creditCardPayBackArguments);
  }

  @override
  Widget buildView(BuildContext context, CreditCardPayBackPageModel model) {
    return CreditCardPayBackPageView(provideBase());
  }
}

class CreditCardPayBackArguments {
  final String accountHolderName;
  String minDuePayBackAmount;
  String totalMinDueAmount;
  final String secureCode;
  final String accountBalance;

  CreditCardPayBackArguments(
      {required this.accountHolderName,
      required this.minDuePayBackAmount,
      required this.totalMinDueAmount,
      required this.secureCode,
      required this.accountBalance});
}
