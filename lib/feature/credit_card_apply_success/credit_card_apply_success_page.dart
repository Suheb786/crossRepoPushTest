import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view_model.dart';

class CreditCardApplySuccessPage
    extends BasePage<CreditCardApplySuccessPageViewModel> {
  @override
  CreditCardApplySuccessPageState createState() =>
      CreditCardApplySuccessPageState();
}

class CreditCardApplySuccessPageState extends BaseStatefulPage<
    CreditCardApplySuccessPageViewModel, CreditCardApplySuccessPage> {
  @override
  ProviderBase provideBase() {
    return creditCardApplySuccessViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, CreditCardApplySuccessPageViewModel model) {
    return CreditCardApplySuccessPageView(provideBase());
  }
}
