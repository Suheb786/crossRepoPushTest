import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employer_country/employer_country_dialog_view.dart';

class EmployerCountryDialog {
  EmployerCountryDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EmployerCountryDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
