import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_success_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_verification_success/credit_card_verification_view_model.dart';

class CreditCardVerificationSuccessPage
    extends BasePage<CreditCardVerificationSuccessViewModel> {
  @override
  CreditCardVerificationSuccessPageState createState() =>
      CreditCardVerificationSuccessPageState();
}

class CreditCardVerificationSuccessPageState extends BaseStatefulPage<
    CreditCardVerificationSuccessViewModel, CreditCardVerificationSuccessPage> {
  @override
  ProviderBase provideBase() {
    return creditCardVerificationSuccessViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, CreditCardVerificationSuccessViewModel model) {
    return CreditCardVerificationSuccessPageView(provideBase());
  }
}
