import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_page_view.dart';
import 'package:neo_bank/feature/payment/payment_to_new_recipient/payment_to_new_recipient_view_model.dart';

class PaymentToNewRecipientPage
    extends BasePage<PaymentToNewRecipientViewModel> {
  String? sendValue;

  PaymentToNewRecipientPage({this.sendValue});

  @override
  PaymentToNewRecipientPageState createState() =>
      PaymentToNewRecipientPageState();
}

class PaymentToNewRecipientPageState extends BaseStatefulPage<
    PaymentToNewRecipientViewModel, PaymentToNewRecipientPage> {
  @override
  ProviderBase provideBase() {
    return paymentToNewRecipientViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, PaymentToNewRecipientViewModel model) {
    return PaymentToNewRecipientPageView(provideBase());
  }
}
