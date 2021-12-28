import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/edit_transaction_purpose_dialog/edit_transaction_purpose_dialog_view.dart';

class EditTransactionPurposeDialog {
  EditTransactionPurposeDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String, String)? onSelected,
      Beneficiary? beneficiary}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EditTransactionPurposeDialogView(
            onDismissed: onDismissed, onSelected: onSelected, beneficiary: beneficiary));
  }
}
