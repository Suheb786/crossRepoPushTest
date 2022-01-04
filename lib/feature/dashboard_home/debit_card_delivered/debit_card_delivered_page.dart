import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_delivered/debit_card_delivered_view_model.dart';

class DebitCardDeliveredPage extends BasePage<DebitCardDeliveredViewModel> {
  final DebitCard debitCard;

  DebitCardDeliveredPage({required this.debitCard});

  @override
  DebitCardDeliveredPageState createState() => DebitCardDeliveredPageState();
}

class DebitCardDeliveredPageState extends BaseStatefulPage<
    DebitCardDeliveredViewModel, DebitCardDeliveredPage> {
  @override
  ProviderBase provideBase() {
    return cardDeliveredViewModelProvider.call(widget.debitCard);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, DebitCardDeliveredViewModel model) {
    return DebitCardDeliveredPageView(provideBase());
  }
}
