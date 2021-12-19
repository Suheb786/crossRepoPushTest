import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view.dart';
import 'package:neo_bank/feature/card_delivery/card_delivery_page_view_model.dart';

class CardDeliveryPage extends BasePage<CardDeliveryPageViewModel> {
  @override
  CardDeliveryPageState createState() => CardDeliveryPageState();
}

class CardDeliveryPageState
    extends BaseStatefulPage<CardDeliveryPageViewModel, CardDeliveryPage> {
  @override
  ProviderBase provideBase() {
    return cardDeliveryViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CardDeliveryPageViewModel model) {
    return CardDeliveryPageView(provideBase());
  }
}
