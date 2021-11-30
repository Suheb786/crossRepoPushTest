import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/credit_card_detail/credit_card_detail_dialog_view.dart';

class CreditCardDetailDialog {
  CreditCardDetailDialog._();

  static show(BuildContext context) {
    AppDialog.show(context,
        isDismissible: true,
        builder: (context) => CreditCardDetailDialogView());
  }
}
