import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/view_debit_card_subscription/view_debit_card_subscription_module.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_page_view.dart';
import 'package:neo_bank/feature/view_debit_card_subscription/view_debit_card_subscription_view_model.dart';

class ViewDebitCardSubscriptionPage
    extends BasePage<ViewDebitCardSubscriptionViewModel> {
  @override
  ViewDebitCardSubscriptionPageState createState() =>
      ViewDebitCardSubscriptionPageState();
}

class ViewDebitCardSubscriptionPageState extends BaseStatefulPage<
    ViewDebitCardSubscriptionViewModel, ViewDebitCardSubscriptionPage> {
  @override
  ProviderBase provideBase() {
    return viewDebitCardSubscriptionViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).canvasColor;
  }

  @override
  Widget buildView(
      BuildContext context, ViewDebitCardSubscriptionViewModel model) {
    return ViewDebitCardSubscriptionPageView(provideBase());
  }
}
