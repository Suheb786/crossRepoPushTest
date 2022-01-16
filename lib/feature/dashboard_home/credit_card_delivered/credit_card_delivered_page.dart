import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/credit_card_delivered/credit_card_delivered_view_model.dart';

class CreditCardDeliveredPage extends BasePage<CreditCardDeliveredViewModel> {
  final List<CreditCard> creditCard;

  CreditCardDeliveredPage({required this.creditCard});

  @override
  DebitCardDeliveredPageState createState() => DebitCardDeliveredPageState();
}

class DebitCardDeliveredPageState extends BaseStatefulPage<
    CreditCardDeliveredViewModel, CreditCardDeliveredPage> {
  @override
  ProviderBase provideBase() {
    return creditCardDeliveredViewModelProvider.call(widget.creditCard);
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
