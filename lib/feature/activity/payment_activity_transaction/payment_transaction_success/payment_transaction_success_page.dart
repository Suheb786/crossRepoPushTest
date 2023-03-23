import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page_view.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class PaymentTransationSuccessPage extends BasePage<PaymentTransationSuccessPageViewModel> {
  @override
  State<StatefulWidget> createState() => PaymentTransationSuccessPageState();
}

class PaymentTransationSuccessPageState
    extends BaseStatefulPage<PaymentTransationSuccessPageViewModel, PaymentTransationSuccessPage> {
  @override
  Widget buildView(BuildContext context, PaymentTransationSuccessPageViewModel model) {
    return PaymentTransationSuccessPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  ProviderBase provideBase() {
    return paymentTransationSuccessPageViewModelProvider;
  }
}
