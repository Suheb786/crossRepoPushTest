import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/iban_dialog/iban_dialog_view.dart';

class IbanDialog {
  IbanDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String, String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) =>
            IbanDialogView(onDismissed: onDismissed, onSelected: onSelected));
  }
}
