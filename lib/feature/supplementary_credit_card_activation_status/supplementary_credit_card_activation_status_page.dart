import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/apply_credit_card/apply_credit_card_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card_activation_status/supplementary_credit_card_activation_status_page_view_model.dart';

class SupplementaryCreditCardActivationStatusPage
    extends BasePage<SupplementaryCreditCardActivationStatusPageViewModel> {
  final SupplementaryCreditCardActivationArguments _arguments;

  SupplementaryCreditCardActivationStatusPage(this._arguments);

  @override
  SupplementaryCreditCardActivationStatusPageState createState() =>
      SupplementaryCreditCardActivationStatusPageState();
}

class SupplementaryCreditCardActivationStatusPageState extends BaseStatefulPage<
    SupplementaryCreditCardActivationStatusPageViewModel,
    SupplementaryCreditCardActivationStatusPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryCreditCardActivationViewModelProvider
        .call(widget._arguments);
  }

  @override
  Widget buildView(BuildContext context,
      SupplementaryCreditCardActivationStatusPageViewModel model) {
    return SupplementaryCreditCardActivationStatusPageView(provideBase());
  }
}

class SupplementaryCreditCardActivationArguments {
  final String primaryCardId;

  SupplementaryCreditCardActivationArguments({required this.primaryCardId});
}
