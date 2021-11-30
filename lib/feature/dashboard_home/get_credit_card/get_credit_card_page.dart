import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/get_credit_card/get_credit_card_view_model.dart';

class GetCreditCardPage extends BasePage<GetCreditCardViewModel> {
  @override
  GetCreditCardPageState createState() => GetCreditCardPageState();
}

class GetCreditCardPageState
    extends BaseStatefulPage<GetCreditCardViewModel, GetCreditCardPage> {
  @override
  ProviderBase provideBase() {
    return getCreditCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, GetCreditCardViewModel model) {
    return GetCreditCardPageView(provideBase());
  }
}
