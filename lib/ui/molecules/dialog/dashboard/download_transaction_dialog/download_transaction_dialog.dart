import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/download_transaction_dialog/download_transaction_dialog_view.dart';

class DownloadTransactionDialog {
  DownloadTransactionDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, required List<String> years, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) =>
            DownloadTransactionDialogView(onDismissed: onDismissed, onSelected: onSelected, years: years));
  }
}
