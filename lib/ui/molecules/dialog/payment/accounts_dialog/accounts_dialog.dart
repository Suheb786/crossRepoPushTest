import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog_view.dart';

class AccountsDialog {
  AccountsDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      required String label,
      List<String>? accountsList}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => AccountsDialogView(
            onDismissed: onDismissed, label: label, onSelected: onSelected, accountsList: accountsList));
  }
}
