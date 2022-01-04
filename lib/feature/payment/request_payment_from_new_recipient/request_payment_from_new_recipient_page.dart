import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_page_view.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_view_model.dart';

class RequestPaymentFromNewRecipientPage
    extends BasePage<RequestPaymentFromNewRecipientViewModel> {
  String? requestValue;

  RequestPaymentFromNewRecipientPage({this.requestValue});

  @override
  RequestPaymentFromNewRecipientPageState createState() =>
      RequestPaymentFromNewRecipientPageState();
}

class RequestPaymentFromNewRecipientPageState extends BaseStatefulPage<
    RequestPaymentFromNewRecipientViewModel,
    RequestPaymentFromNewRecipientPage> {
  @override
  ProviderBase provideBase() {
    return requestPaymentFromNewRecipientViewModelProvider
        .call(widget.requestValue!);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, RequestPaymentFromNewRecipientViewModel model) {
    return RequestPaymentFromNewRecipientPageView(provideBase());
  }
}
