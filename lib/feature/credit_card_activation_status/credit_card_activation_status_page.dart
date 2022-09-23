import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/apply_credit_card/apply_credit_card_modules.dart';
import 'package:neo_bank/feature/credit_card_activation_status/credit_card_activation_status_page_view.dart';
import 'package:neo_bank/feature/credit_card_activation_status/credit_card_activation_status_page_view_model.dart';

class CreditCardActivationStatusPage extends BasePage<CreditCardActivationStatusPageViewModel> {
  @override
  CreditCardActivationStatusPageState createState() => CreditCardActivationStatusPageState();
}

class CreditCardActivationStatusPageState
    extends BaseStatefulPage<CreditCardActivationStatusPageViewModel, CreditCardActivationStatusPage> {
  @override
  ProviderBase provideBase() {
    return creditCardActivationViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CreditCardActivationStatusPageViewModel model) {
    return CreditCardActivationStatusPageView(provideBase());
  }
}
