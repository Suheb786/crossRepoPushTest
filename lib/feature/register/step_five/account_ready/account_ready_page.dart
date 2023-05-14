import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_model.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_view.dart';

class AccountReadyPage extends BasePage<AccountReadyViewModel> {
  final AccountReadyArguments _accountReadyArguments;

  AccountReadyPage(this._accountReadyArguments);

  @override
  AccountReadyPageState createState() => AccountReadyPageState();
}

class AccountReadyPageState extends BaseStatefulPage<AccountReadyViewModel, AccountReadyPage> {
  @override
  ProviderBase provideBase() {
    return accountReadyPageViewModelProvider.call(widget._accountReadyArguments);
  }

  @override
  Widget buildView(BuildContext context, AccountReadyViewModel model) {
    return AccountReadyView(provideBase());
  }
}

class AccountReadyArguments {
  final bool isDocumentUploaded;

  AccountReadyArguments({this.isDocumentUploaded = false});
}
