import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/account_transaction/account_transaction_view_model.dart';

class AccountTransactionPage extends BasePage<AccountTransactionViewModel> {
  final AccountTransactionPageArgument account;

  AccountTransactionPage(this.account);

  @override
  AccountTransactionPageState createState() => AccountTransactionPageState();
}

class AccountTransactionPageState
    extends BaseStatefulPage<AccountTransactionViewModel, AccountTransactionPage> {
  @override
  ProviderBase provideBase() {
    return accountTransactionViewModelProvider.call(widget.account);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, AccountTransactionViewModel model) {
    return AccountTransactionPageView(
      provideBase(),
    );
  }

  @override
  Future<bool> onBackPressed(AccountTransactionViewModel model, {param}) {
    model.animateBackToDashboard(context);
    return super.onBackPressed(model);
  }
}

class AccountTransactionPageArgument {
  final String? accountNo;

  AccountTransactionPageArgument(this.accountNo);
}
