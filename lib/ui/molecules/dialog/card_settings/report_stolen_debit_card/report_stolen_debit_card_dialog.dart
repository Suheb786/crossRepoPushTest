import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/report_stolen_debit_card/report_stolen_debit_card_dialog_view.dart';

class ReportStolenDebitCardDialog {
  ReportStolenDebitCardDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function()? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => ReportStolenDebitCardDialogView(
            onDismissed: onDismissed, onSelected: onSelected));
  }
}
