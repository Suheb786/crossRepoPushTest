import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view.dart';
import 'package:neo_bank/feature/card_ready_success/card_ready_success_page_view_model.dart';

import '../../main/navigation/route_paths.dart';

class CardReadySuccessPage extends BasePage<CardReadySuccessPageViewModel> {
  @override
  CardReadySuccessPageState createState() => CardReadySuccessPageState();
}

class CardReadySuccessPageState
    extends BaseStatefulPage<CardReadySuccessPageViewModel, CardReadySuccessPage> {
  @override
  ProviderBase provideBase() {
    return cardReadySuccessViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, CardReadySuccessPageViewModel model) {
    return CardReadySuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(CardReadySuccessPageViewModel model, {param}) {
    Navigator.pushNamed(context, RoutePaths.AppHome);
    return super.onBackPressed(model);
  }
}
