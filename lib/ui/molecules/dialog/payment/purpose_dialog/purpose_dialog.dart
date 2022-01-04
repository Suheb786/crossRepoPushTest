import 'package:domain/model/purpose/purpose.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_dialog/purpose_dialog_view.dart';

class PurposeDialog {
  PurposeDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(Purpose)? onSelected,
      List<Purpose>? purposeList}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => PurposeDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            purposeList: purposeList));
  }
}
