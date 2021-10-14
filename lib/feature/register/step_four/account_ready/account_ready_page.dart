import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/account_ready/account_ready_model.dart';
import 'package:neo_bank/feature/register/step_four/account_ready/account_ready_view.dart';
import 'package:riverpod/src/framework.dart';

class AccountReadyPage extends BasePage<AccountReadyViewModel> {
  @override
  AccountReadyPageState createState() => AccountReadyPageState();
}

class AccountReadyPageState
    extends BaseStatefulPage<AccountReadyViewModel, AccountReadyPage> {
  @override
  ProviderBase provideBase() {
    return accountReadyPageViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, AccountReadyViewModel model) {
    return AccountReadyView(provideBase());
  }
}
