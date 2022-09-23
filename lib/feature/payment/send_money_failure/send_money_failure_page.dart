import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_page_view.dart';
import 'package:neo_bank/feature/payment/send_money_failure/send_money_failure_view_model.dart';

class SendMoneyFailurePage extends BasePage<SendMoneyFailureViewModel> {
  @override
  SendMoneyFailurePageState createState() => SendMoneyFailurePageState();
}

class SendMoneyFailurePageState extends BaseStatefulPage<SendMoneyFailureViewModel, SendMoneyFailurePage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyFailureViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyFailureViewModel model) {
    return SendMoneyFailurePageView(provideBase());
  }
}
