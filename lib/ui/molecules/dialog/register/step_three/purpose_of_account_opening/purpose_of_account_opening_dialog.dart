import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog_view.dart';

class PurposeOfAccountOpeningDialog {
  PurposeOfAccountOpeningDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String, String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => PurposeOfAccountOpeningDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
