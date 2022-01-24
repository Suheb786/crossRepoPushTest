import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page_view.dart';
import 'package:neo_bank/feature/supplementary_credit_card_ready/supplementary_credit_card_ready_page_view_model.dart';

class SupplementaryCreditCardReadyPage
    extends BasePage<SupplementaryCreditCardReadyPageViewModel> {
  @override
  SupplementaryCreditCardReadyPageState createState() =>
      SupplementaryCreditCardReadyPageState();
}

class SupplementaryCreditCardReadyPageState extends BaseStatefulPage<
    SupplementaryCreditCardReadyPageViewModel,
    SupplementaryCreditCardReadyPage> {
  @override
  ProviderBase provideBase() {
    return supplementaryCreditCardReadyViewModelProvider;
  }

  @override
  Widget buildView(
      BuildContext context, SupplementaryCreditCardReadyPageViewModel model) {
    return SupplementaryCreditCardReadyPageView(provideBase());
  }
}
