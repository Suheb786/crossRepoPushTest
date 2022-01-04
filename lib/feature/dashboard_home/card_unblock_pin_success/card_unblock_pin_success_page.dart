import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/card_unblock_pin_success/card_unblock_pin_success_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/manage_card_pin/manage_card_pin_page.dart';

class CardPinUnBlockSuccessPage
    extends BasePage<CardPinUnBlockSuccessPageViewModel> {
  final ManageCardPinArguments manageCardPinArguments;

  CardPinUnBlockSuccessPage({required this.manageCardPinArguments});

  @override
  CardPinUnBlockSuccessPageState createState() =>
      CardPinUnBlockSuccessPageState();
}

class CardPinUnBlockSuccessPageState extends BaseStatefulPage<
    CardPinUnBlockSuccessPageViewModel, CardPinUnBlockSuccessPage> {
  @override
  ProviderBase provideBase() {
    return cardPinUnblockSuccessViewModelProvider
        .call(widget.manageCardPinArguments);
  }

  @override
  Widget buildView(
      BuildContext context, CardPinUnBlockSuccessPageViewModel model) {
    return CardPinUnBlockSuccessPageView(provideBase());
  }
}
