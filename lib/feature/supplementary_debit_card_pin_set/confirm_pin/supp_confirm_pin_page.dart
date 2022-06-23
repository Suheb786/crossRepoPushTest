import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/debit_card_replacement/debit_card_replacement_modules.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/confirm_pin/supp_confirm_pin_page_view.dart';
import 'package:neo_bank/feature/supplementary_debit_card_pin_set/confirm_pin/supp_confirm_pin_page_view_model.dart';

class SuppConfirmPinPage extends BasePage<SuppConfirmPinPageViewModel> {
  @override
  SuppConfirmPinPageState createState() => SuppConfirmPinPageState();
}

class SuppConfirmPinPageState
    extends BaseStatefulPage<SuppConfirmPinPageViewModel, SuppConfirmPinPage> {
  @override
  ProviderBase provideBase() {
    return confirmReplacementPinViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(BuildContext context, SuppConfirmPinPageViewModel model) {
    return SuppConfirmPinPageView(provideBase());
  }
}
