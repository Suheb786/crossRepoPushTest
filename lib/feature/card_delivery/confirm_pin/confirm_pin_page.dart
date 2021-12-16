import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/confirm_pin/confirm_pin_page_view.dart';
import 'package:neo_bank/feature/card_delivery/confirm_pin/confirm_pin_page_view_model.dart';

class ConfirmPinPage extends BasePage<ConfirmPinPageViewModel> {
  @override
  ConfirmPinPageState createState() => ConfirmPinPageState();
}

class ConfirmPinPageState
    extends BaseStatefulPage<ConfirmPinPageViewModel, ConfirmPinPage> {
  @override
  ProviderBase provideBase() {
    return confirmPinViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget buildView(BuildContext context, ConfirmPinPageViewModel model) {
    return ConfirmPinPageView(provideBase());
  }
}
