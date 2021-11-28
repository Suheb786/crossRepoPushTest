import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/card_delivered/card_delivered_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/card_delivered/card_delivered_view_model.dart';

class CardDeliveredPage extends BasePage<CardDeliveredViewModel> {
  @override
  CardDeliveredPageState createState() => CardDeliveredPageState();
}

class CardDeliveredPageState
    extends BaseStatefulPage<CardDeliveredViewModel, CardDeliveredPage> {
  @override
  ProviderBase provideBase() {
    return cardDeliveredViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, CardDeliveredViewModel model) {
    return CardDeliveredPageView(provideBase());
  }
}
