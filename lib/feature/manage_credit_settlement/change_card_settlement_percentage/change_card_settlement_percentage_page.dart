import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page_view.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_settlement_percentage/change_card_settlement_percentage_page_view_model.dart';

class ChangeCardSettlementPercentagePage
    extends BasePage<ChangeCardSettlementPercentagePageViewModel> {
  final ChangeCardSettlementPercentageArguments
      changeCardSettlementPercentageArguments;

  ChangeCardSettlementPercentagePage(
      {required this.changeCardSettlementPercentageArguments});

  @override
  ChangeCardSettlementPercentagePageState createState() =>
      ChangeCardSettlementPercentagePageState();
}

class ChangeCardSettlementPercentagePageState extends BaseStatefulPage<
    ChangeCardSettlementPercentagePageViewModel,
    ChangeCardSettlementPercentagePage> {
  @override
  ProviderBase provideBase() {
    return changeCardSettlementPercentagePageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(ChangeCardSettlementPercentagePageViewModel model) {
    super.onModelReady(model);
    model.arguments = widget.changeCardSettlementPercentageArguments;
  }

  @override
  Widget buildView(
      BuildContext context, ChangeCardSettlementPercentagePageViewModel model) {
    return ChangeCardSettlementPercentagePageView(provideBase());
  }
}

class ChangeCardSettlementPercentageArguments {
  final CreditCard creditCard;

  ChangeCardSettlementPercentageArguments({required this.creditCard});
}
