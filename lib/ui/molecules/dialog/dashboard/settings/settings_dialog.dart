import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view.dart';

class SettingsDialog {
  SettingsDialog._();

  static show(BuildContext mContext) {
    AppDialog.show(mContext,
        barrierColor: Theme.of(mContext).primaryColorDark.withOpacity(0.5),
        isDismissible: true,
        builder: (context) => SettingsDialogView());
  }
}
