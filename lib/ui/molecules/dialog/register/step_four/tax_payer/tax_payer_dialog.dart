import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog_view.dart';

class TaxPayerDialog {
  TaxPayerDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => TaxPayerDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
