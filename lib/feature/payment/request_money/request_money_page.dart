import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_page_view.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_view_model.dart';

class RequestMoneyPage extends BasePage<RequestMoneyViewModel> {
  @override
  RequestMoneyPageState createState() => RequestMoneyPageState();
}

class RequestMoneyPageState extends BaseStatefulPage<RequestMoneyViewModel, RequestMoneyPage> {
  @override
  ProviderBase provideBase() {
    return requestMoneyViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget buildView(BuildContext context, RequestMoneyViewModel model) {
    return RequestMoneyPageView(provideBase());
  }
}
