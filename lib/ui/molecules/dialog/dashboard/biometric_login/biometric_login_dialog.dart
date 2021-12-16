import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/biometric_login/biometric_login_dialog_view.dart';

class BiometricLoginDialog {
  BiometricLoginDialog._();

  static show(BuildContext mContext,
      {Function? mayBeLater, Function? enableBioMetric}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => BiometricLoginDialogView(
              mayBeLater: mayBeLater,
              enableBioMetric: enableBioMetric,
            ));
  }
}
