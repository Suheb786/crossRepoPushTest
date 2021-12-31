import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/card_cancel_dialog/card_cancel_dialog_view.dart';

class CardCancelDialog {
  CardCancelDialog._();

  static show(BuildContext context,
      {Function? onDismissed, Function(String, bool)? onSelected}) {
    AppDialog.show(context,
        isDismissible: true,
        builder: (context) => CardCancelDialogView(
              onSelected: onSelected,
              onDismissed: onDismissed,
            ));
  }
}
