import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'change_my_email_dialog_view.dart';

class ChangeMyEmailDialog {
  ChangeMyEmailDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    Function()? showError,
    Function(String)? onSelected,
  }) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => ChangeMyEmailDialogView(
              onDismissed: onDismissed,
              showError: showError,
              onSelected: onSelected,
            ));
  }
}
