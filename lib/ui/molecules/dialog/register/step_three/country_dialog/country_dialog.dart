import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog_view.dart';

class CountryDialog {
  CountryDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => CountryDialogView(
            onDismissed: onDismissed, onSelected: onSelected, title: title));
  }
}
