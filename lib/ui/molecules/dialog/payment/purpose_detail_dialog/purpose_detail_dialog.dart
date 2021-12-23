import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/purpose_detail_dialog/purpose_detail_dialog_view.dart';

class PurposeDetailDialog {
  PurposeDetailDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => PurposeDetailDialogView(
            onDismissed: onDismissed, onSelected: onSelected));
  }
}
