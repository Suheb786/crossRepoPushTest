import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page_view.dart';
import 'package:neo_bank/feature/change_card_pin/change_card_pin_page_view_model.dart';

class ChangeCardPinPage extends BasePage<ChangeCardPinPageViewModel> {
  @override
  ChangeCardPinPageState createState() => ChangeCardPinPageState();
}

class ChangeCardPinPageState
    extends BaseStatefulPage<ChangeCardPinPageViewModel, ChangeCardPinPage> {
  @override
  ProviderBase provideBase() {
    return changeCardPinViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ChangeCardPinPageViewModel model) {
    return ChangeCardPinPageView(provideBase());
  }
}
