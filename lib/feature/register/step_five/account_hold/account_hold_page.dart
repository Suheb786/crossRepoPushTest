import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_view.dart';
import 'package:neo_bank/feature/register/step_five/account_hold/account_hold_view_model.dart';

class AccountHoldPage extends BasePage<AccountHoldViewModel> {
  final AccountHoldArguments _arguments;

  AccountHoldPage(this._arguments);

  @override
  AccountHoldPageState createState() => AccountHoldPageState();
}

class AccountHoldPageState extends BaseStatefulPage<AccountHoldViewModel, AccountHoldPage> {
  @override
  ProviderBase provideBase() {
    return accountHoldViewModelProvider.call(widget._arguments);
  }

  @override
  Widget buildView(BuildContext context, AccountHoldViewModel model) {
    return AccountHoldView(provideBase());
  }
}

class AccountHoldArguments {
  final String? applicationId;

  AccountHoldArguments({this.applicationId = ""});
}
