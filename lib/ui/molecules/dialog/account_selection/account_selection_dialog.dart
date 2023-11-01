import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/account_selection/account_selection_dialog_view.dart';

class AccountSelectionDialog {
  AccountSelectionDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(Account)? onSelected,
      required String title,
      required List<Account> accountList,
      bool showBalance = true}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => AccountSelectionDialogView(
            showBalances: showBalance,
            onDismissed: onDismissed,
            title: title,
            accountList: accountList,
            onSelected: onSelected));
  }
}
