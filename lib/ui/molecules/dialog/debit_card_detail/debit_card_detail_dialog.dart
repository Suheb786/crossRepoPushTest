import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/debit_card_detail/debit_card_detail_dialog_view.dart';

class DebitCardDetailDialog {
  DebitCardDetailDialog._();

  static show(BuildContext context) {
    AppDialog.show(context,
        isDismissible: true, builder: (context) => DebitCardDetailDialogView());
  }
}
