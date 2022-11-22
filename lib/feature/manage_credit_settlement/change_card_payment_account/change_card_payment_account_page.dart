import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_payment_account/change_card_payment_account_page_view.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_payment_account/change_card_payment_account_page_view_model.dart';

class ChangeCardPaymentAccountPage extends BasePage<ChangeCardPaymentAccountPageViewModel> {
  @override
  ChangeCardPaymentAccountPageState createState() => ChangeCardPaymentAccountPageState();
}

class ChangeCardPaymentAccountPageState
    extends BaseStatefulPage<ChangeCardPaymentAccountPageViewModel, ChangeCardPaymentAccountPage> {
  @override
  ProviderBase provideBase() {
    return changeCardPaymentPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ChangeCardPaymentAccountPageViewModel model) {
    return ChangeCardPaymentAccountPageView(provideBase());
  }
}
