import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_page_view.dart';
import 'package:neo_bank/feature/payment/send_amount_to_contact/send_amount_to_contact_view_model.dart';

class SendAmountToContactPage extends BasePage<SendAmountToContactViewModel> {
  final SendAmountToContactPageArgument sendAmountToContactPageArgument;

  SendAmountToContactPage(this.sendAmountToContactPageArgument);

  @override
  SendAmountToContactPageState createState() => SendAmountToContactPageState();
}

class SendAmountToContactPageState
    extends BaseStatefulPage<SendAmountToContactViewModel, SendAmountToContactPage> {
  @override
  ProviderBase provideBase() {
    return sendAmountToContactViewModelProvider.call(widget.sendAmountToContactPageArgument.beneficiary);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  void onModelReady(SendAmountToContactViewModel model) {
    model.setShowBackButton(widget.sendAmountToContactPageArgument.needBackButton);
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, SendAmountToContactViewModel model) {
    return SendAmountToContactPageView(provideBase());
  }
}

class SendAmountToContactPageArgument {
  final Beneficiary beneficiary;
  final bool needBackButton;
  final Account? account;

  SendAmountToContactPageArgument(this.beneficiary, {this.needBackButton = false, this.account});
}
