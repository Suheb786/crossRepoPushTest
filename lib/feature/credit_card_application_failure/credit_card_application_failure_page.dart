import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/blink_credit_card/blink_credit_card_modules.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page_view.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_view_model.dart';

class CreditCardApplicationFailurePage
    extends BasePage<CreditCardApplicationFailureViewModel> {
  @override
  CreditCardApplicationFailurePageState createState() =>
      CreditCardApplicationFailurePageState();
}

class CreditCardApplicationFailurePageState extends BaseStatefulPage<
    CreditCardApplicationFailureViewModel, CreditCardApplicationFailurePage> {
  @override
  ProviderBase provideBase() {
    return creditCardApplicationFailureViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, CreditCardApplicationFailureViewModel model) {
    return CreditCardApplicationFailurePageView(provideBase());
  }
}
