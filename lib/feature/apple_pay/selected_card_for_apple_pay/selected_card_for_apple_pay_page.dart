import 'package:domain/model/dashboard/get_dashboard_data/credit_card.dart';
import 'package:domain/model/dashboard/get_dashboard_data/debit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/selected_card_for_apple_pay/selected_card_for_apple_pay_modules.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_page_view.dart';
import 'package:neo_bank/feature/apple_pay/selected_card_for_apple_pay/selected_card_for_apple_pay_view_model.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class SelectedCardForApplePayPage extends BasePage<SelectedCardForApplePayPageViewModel> {
  final SelectedCardsForApplePayPageArguments arguments;

  SelectedCardForApplePayPage({required this.arguments});

  @override
  SelectedCardForApplePayPageState createState() => SelectedCardForApplePayPageState();
}

class SelectedCardForApplePayPageState
    extends BaseStatefulPage<SelectedCardForApplePayPageViewModel, SelectedCardForApplePayPage> {
  @override
  ProviderBase provideBase() {
    return selectedCardForApplePayPageViewModelProvider.call(widget.arguments);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(preferredSize: Size(double.maxFinite, 56.h), child: Container());
  }

  @override
  void onModelReady(SelectedCardForApplePayPageViewModel model) {
    model.addCardList(
        CardTypeData(creditCards: model.arguments.creditCards, debitCards: model.arguments.debitCards));
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, SelectedCardForApplePayPageViewModel model) {
    return SelectedCardForApplePayPageView(provideBase());
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

class SelectedCardsForApplePayPageArguments {
  final List<CreditCard> creditCards;
  final List<DebitCard> debitCards;

  SelectedCardsForApplePayPageArguments({required this.creditCards, required this.debitCards});
}
