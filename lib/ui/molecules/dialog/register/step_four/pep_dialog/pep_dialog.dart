import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/pep_dialog/pep_dialog_view.dart';

class PEPDialog {
  PEPDialog._();

  static show(
    BuildContext mContext, {
    Function()? onSelected,
  }) {
    AppDialog.show(mContext,
        isDismissible: true, builder: (context) => PEPDialogView(onSelected: onSelected));
  }
}
