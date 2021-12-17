import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';

class CreditCardDeliveredPage extends BasePage<CreditCardDeliveredViewModel> {
  @override
  DebitCardDeliveredPageState createState() => DebitCardDeliveredPageState();
}

class DebitCardDeliveredPageState extends BaseStatefulPage<
    CreditCardDeliveredViewModel, CreditCardDeliveredPage> {
  @override
  ProviderBase provideBase() {
    return creditCardDeliveredViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, CreditCardDeliveredViewModel model) {
    return CreditCardDeliveredPageView(provideBase());
  }
}
