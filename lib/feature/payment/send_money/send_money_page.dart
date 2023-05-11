import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_page_view.dart';
import 'package:neo_bank/feature/payment/send_money/send_money_view_model.dart';

class SendMoneyPage extends BasePage<SendMoneyViewModel> {
  @override
  SendMoneyPageState createState() => SendMoneyPageState();
}

class SendMoneyPageState extends BaseStatefulPage<SendMoneyViewModel, SendMoneyPage> {
  @override
  ProviderBase provideBase() {
    return sendMoneyViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget buildView(BuildContext context, SendMoneyViewModel model) {
    return SendMoneyPageView(provideBase());
  }
}
