import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_page_view.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';

class SendAmountToContactPage extends BasePage<SendAmountToContactViewModel> {
  final Beneficiary _beneficiary;

  SendAmountToContactPage(this._beneficiary);

  @override
  SendAmountToContactPageState createState() => SendAmountToContactPageState();
}

class SendAmountToContactPageState
    extends BaseStatefulPage<SendAmountToContactViewModel, SendAmountToContactPage> {
  @override
  ProviderBase provideBase() {
    return sendAmountToContactViewModelProvider.call(widget._beneficiary);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget buildView(BuildContext context, SendAmountToContactViewModel model) {
    return SendAmountToContactPageView(provideBase());
  }
}
