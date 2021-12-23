import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_page_view.dart';
import 'package:neo_bank/feature/payment/request_amount_from_contact/request_amount_from_contact_view_model.dart';

class RequestAmountFromContactPage
    extends BasePage<RequestAmountFromContactViewModel> {
  @override
  RequestAmountFromContactPageState createState() =>
      RequestAmountFromContactPageState();
}

class RequestAmountFromContactPageState extends BaseStatefulPage<
    RequestAmountFromContactViewModel, RequestAmountFromContactPage> {
  @override
  ProviderBase provideBase() {
    return requestAmountFromContactViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(
      BuildContext context, RequestAmountFromContactViewModel model) {
    return RequestAmountFromContactPageView(provideBase());
  }
}
