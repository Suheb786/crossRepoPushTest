import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_page_view.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';

class SendAmountToContactPage extends BasePage<SendAmountToContactViewModel> {
  @override
  SendAmountToContactPageState createState() => SendAmountToContactPageState();
}

class SendAmountToContactPageState extends BaseStatefulPage<
    SendAmountToContactViewModel, SendAmountToContactPage> {
  @override
  ProviderBase provideBase() {
    return sendAmountToContactViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, SendAmountToContactViewModel model) {
    return SendAmountToContactPageView(provideBase());
  }
}
