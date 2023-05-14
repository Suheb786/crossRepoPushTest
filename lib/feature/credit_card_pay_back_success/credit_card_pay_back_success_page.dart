import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page_view.dart';
import 'package:neo_bank/feature/credit_card_pay_back_success/credit_card_pay_back_success_page_view_model.dart';

class CreditCardPayBackSuccessPage extends BasePage<CreditCardPayBackSuccessViewModel> {
  final CreditCardPayBackSuccessArguments _creditCardPayBackSuccessArguments;

  CreditCardPayBackSuccessPage(this._creditCardPayBackSuccessArguments);

  @override
  CreditCardPayBackSuccessPageState createState() => CreditCardPayBackSuccessPageState();
}

class CreditCardPayBackSuccessPageState
    extends BaseStatefulPage<CreditCardPayBackSuccessViewModel, CreditCardPayBackSuccessPage> {
  @override
  ProviderBase provideBase() {
    return creditCardPayBackSuccessViewModelProvider.call(widget._creditCardPayBackSuccessArguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, CreditCardPayBackSuccessViewModel model) {
    return CreditCardPayBackSuccessPageView(provideBase());
  }
}

class CreditCardPayBackSuccessArguments {
  final String payBackAmount;
  final String accountHolderName;

  CreditCardPayBackSuccessArguments({this.payBackAmount = "", this.accountHolderName = ""});
}
