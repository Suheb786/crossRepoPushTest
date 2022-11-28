import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_page_view.dart';
import 'package:neo_bank/feature/payment/add_send_money_contact/add_send_money_contact_view_model.dart';

class AddSendMoneyContactPage extends BasePage<AddSendMoneyContactViewModel> {
  final List<Beneficiary>? beneficiaries;

  AddSendMoneyContactPage({this.beneficiaries});

  @override
  AddSendMoneyContactPageState createState() => AddSendMoneyContactPageState();
}

class AddSendMoneyContactPageState
    extends BaseStatefulPage<AddSendMoneyContactViewModel, AddSendMoneyContactPage>
    with AutomaticKeepAliveClientMixin {
  AddSendMoneyContactPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return addSendMoneyContactViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, AddSendMoneyContactViewModel model) {
    return AddSendMoneyContactPageView(provideBase(), widget.beneficiaries);
  }

  @override
  bool get wantKeepAlive => true;
}
