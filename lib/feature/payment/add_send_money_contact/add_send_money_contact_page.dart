import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_page_view.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';

class AddSendMoneyContactPage extends BasePage<AddSendMoneyContactViewModel> {
  @override
  AddSendMoneyContactPageState createState() => AddSendMoneyContactPageState();
}

class AddSendMoneyContactPageState extends BaseStatefulPage<
    AddSendMoneyContactViewModel, AddSendMoneyContactPage> {
  @override
  ProviderBase provideBase() {
    return addSendMoneyContactViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, AddSendMoneyContactViewModel model) {
    return AddSendMoneyContactPageView(provideBase());
  }
}
