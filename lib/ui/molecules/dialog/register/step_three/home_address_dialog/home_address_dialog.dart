import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/home_address_dialog/home_address_dialog_view.dart';

class HomeAddressDialog {
  HomeAddressDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => HomeAddressDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
