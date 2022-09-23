import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_page_view.dart';
import 'package:neo_bank/feature/payment/request_money_failure/request_money_failure_view_model.dart';

class RequestMoneyFailurePage extends BasePage<RequestMoneyFailureViewModel> {
  @override
  RequestMoneyFailurePageState createState() => RequestMoneyFailurePageState();
}

class RequestMoneyFailurePageState
    extends BaseStatefulPage<RequestMoneyFailureViewModel, RequestMoneyFailurePage> {
  @override
  ProviderBase provideBase() {
    return requestMoneyFailureViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, RequestMoneyFailureViewModel model) {
    return RequestMoneyFailurePageView(provideBase());
  }
}
