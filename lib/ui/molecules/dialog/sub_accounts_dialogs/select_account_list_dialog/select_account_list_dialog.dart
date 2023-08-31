import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/sub_accounts_dialogs/select_account_list_dialog/select_account_list_dialog_view.dart';

class SelectAccountListDialog {
  SelectAccountListDialog._();

  static show(BuildContext context,
      {Function()? onDismissed,
      Function(Account)? onConfirm,
      required String title,
      required List<Account> accountList}) {
    AppDialog.show(context,
        builder: (context) => SelectAccountListDialogPageView(
              title: title,
              onConfirm: onConfirm,
              onDismissed: onDismissed,
              accountList: accountList,
            ));
  }
}
