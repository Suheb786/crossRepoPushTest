import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/select_from_list_dialog/select_from_list_dialog_page_view.dart';

class SelectFromListDialog {
  SelectFromListDialog._();

  static show(
    BuildContext context, {
    Function()? onDismissed,
    Function(Account)? onConfirm,
    required String title,
    required List<String> accountName,
    required List<String> accountNumber,
    required List<String> availableAmount,
  }) {
    AppDialog.show(context,
        builder: (context) => SelectFromListDialogPageView(
              title: title,
              accountName: accountName,
              accountNumber: accountNumber,
              availableAmount: availableAmount,
              onConfirm: onConfirm,
              onDismissed: onDismissed,
            ));
  }
}
