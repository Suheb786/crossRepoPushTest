import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/create_password_info_dialog_view.dart';

class CreatePasswordInfoDialog {
  CreatePasswordInfoDialog._();

  static show(BuildContext mContext, {Function? onDismissed}) {
    AppDialog.show(mContext,
        isDismissible: true, builder: (context) => CreatePasswordInfoDialogView(onDismissed: onDismissed));
  }
}
