import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'link_account_dialog_view.dart';
import 'link_account_dialog_view_model.dart';

class LinkAccountDialog {
  LinkAccountDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    final Function(LinkBankAccountData)? onSelected,
    required String label,
  }) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => LinkAccountDialogView(
              onDismissed: onDismissed,
              label: label,
              onSelected: onSelected,
            ));
  }
}
