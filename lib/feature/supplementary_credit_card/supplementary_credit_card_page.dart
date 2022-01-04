import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card/supplementary_credit_card_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card/supplementary_credit_card_page_view_model.dart';

class SupplementaryCreditCardPage
    extends BasePage<SupplementaryCreditCardPageViewModel> {
  @override
  SupplementaryCreditCardPageState createState() =>
      SupplementaryCreditCardPageState();
}

class SupplementaryCreditCardPageState extends BaseStatefulPage<
    SupplementaryCreditCardPageViewModel, SupplementaryCreditCardPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryCreditCardViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, SupplementaryCreditCardPageViewModel model) {
    return SupplementaryCreditCardPageView(provideBase());
  }
}
