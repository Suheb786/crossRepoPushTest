import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_page_view.dart';
import 'package:neo_bank/feature/payment/add_request_money_contact/add_request_money_contact_view_model.dart';

class AddRequestMoneyContactPage
    extends BasePage<AddRequestMoneyContactViewModel> {
  @override
  AddRequestMoneyContactPageState createState() =>
      AddRequestMoneyContactPageState();
}

class AddRequestMoneyContactPageState extends BaseStatefulPage<
    AddRequestMoneyContactViewModel, AddRequestMoneyContactPage> {
  @override
  ProviderBase provideBase() {
    return addRequestMoneyContactViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(
      BuildContext context, AddRequestMoneyContactViewModel model) {
    return AddRequestMoneyContactPageView(provideBase());
  }
}
