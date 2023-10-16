import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/card_delivery/card_delivery_modules.dart';
import 'package:neo_bank/feature/change_card_pin_success/card_ready_success_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page_view.dart';

import '../../di/dashboard/dashboard_modules.dart';
import '../../main/navigation/route_paths.dart';

class ChangeCardPinSuccessPage extends BasePage<ChangeCardPinSuccessPageViewModel> {
  final ChangeCardPinSuccessArguments _cardPinSuccessArguments;

  ChangeCardPinSuccessPage(this._cardPinSuccessArguments);

  @override
  ChangeCardPinSuccessPageState createState() => ChangeCardPinSuccessPageState();
}

class ChangeCardPinSuccessPageState
    extends BaseStatefulPage<ChangeCardPinSuccessPageViewModel, ChangeCardPinSuccessPage> {
  @override
  ProviderBase provideBase() {
    return changeCardPinSuccessViewModelProvider.call(widget._cardPinSuccessArguments);
  }

  @override
  Widget buildView(BuildContext context, ChangeCardPinSuccessPageViewModel model) {
    return ChangeCardPinSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(ChangeCardPinSuccessPageViewModel model, {param}) {
    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
    ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
    return super.onBackPressed(model, );
  }
}

class ChangeCardPinSuccessArguments {
  final CardType cardType;

  ChangeCardPinSuccessArguments({required this.cardType});
}
