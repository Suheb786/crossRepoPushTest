import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_page_view.dart';
import 'package:neo_bank/feature/payment/request_money_from_contact_success/request_money_from_contact_success_view_model.dart';

class RequestAmountFromContactSuccessPage extends BasePage<RequestAmountFromContactSuccessViewModel> {
  List<String>? successValues;

  RequestAmountFromContactSuccessPage({this.successValues});

  @override
  RequestAmountFromContactSuccessPageState createState() => RequestAmountFromContactSuccessPageState();
}

class RequestAmountFromContactSuccessPageState
    extends BaseStatefulPage<RequestAmountFromContactSuccessViewModel, RequestAmountFromContactSuccessPage> {
  @override
  ProviderBase provideBase() {
    return requestAmountFromContactSuccessViewModelProvider.call(widget.successValues!);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, RequestAmountFromContactSuccessViewModel model) {
    return RequestAmountFromContactSuccessPageView(provideBase());
  }
}
