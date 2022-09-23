import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/apply_credit_card/apply_credit_card_modules.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_page_view.dart';
import 'package:neo_bank/feature/apply_credit_card_home/apply_credit_card_home_view_model.dart';

class ApplyCreditCardHomePage extends BasePage<ApplyCreditCardHomeViewModel> {
  @override
  ApplyCreditCardHomePageState createState() => ApplyCreditCardHomePageState();
}

class ApplyCreditCardHomePageState
    extends BaseStatefulPage<ApplyCreditCardHomeViewModel, ApplyCreditCardHomePage> {
  @override
  ProviderBase provideBase() {
    return applyCreditCardHomeViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, ApplyCreditCardHomeViewModel model) {
    return ApplyCreditCardHomePageView(provideBase());
  }
}
