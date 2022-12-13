import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'link_account_dialog_view.dart';

class LinkAccountDialog {
  LinkAccountDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      required String label,
      required List<String>? accountsList}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => LinkAccountDialogView(
            onDismissed: onDismissed, label: label, onSelected: onSelected, accountsList: accountsList));
  }
}
