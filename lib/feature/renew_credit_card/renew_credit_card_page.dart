import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/renew_credit_card/renew_credit_card_page_view.dart';
import 'package:neo_bank/feature/renew_credit_card/renew_credit_card_page_view_model.dart';

class RenewCreditCardPage extends BasePage<RenewCreditCardPageViewModel> {
  @override
  RenewCreditCardPageState createState() => RenewCreditCardPageState();
}

class RenewCreditCardPageState extends BaseStatefulPage<
    RenewCreditCardPageViewModel, RenewCreditCardPage> {
  @override
  ProviderBase provideBase() {
    return renewCreditCardPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, RenewCreditCardPageViewModel model) {
    return RenewCreditCardPageView(provideBase());
  }
}
