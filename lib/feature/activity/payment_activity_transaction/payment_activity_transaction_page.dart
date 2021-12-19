import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';

class PaymentActivityTransactionPage
    extends BasePage<PaymentActivityTransactionViewModel> {
  @override
  PaymentActivityTransactionPageState createState() =>
      PaymentActivityTransactionPageState();
}

class PaymentActivityTransactionPageState extends BaseStatefulPage<
    PaymentActivityTransactionViewModel, PaymentActivityTransactionPage> {
  @override
  ProviderBase provideBase() {
    return paymentActivityTransactionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, PaymentActivityTransactionViewModel model) {
    return PaymentActivityTransactionPageView(provideBase());
  }
}
