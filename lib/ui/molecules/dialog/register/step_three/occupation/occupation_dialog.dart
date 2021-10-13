import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog_view.dart';

class OccupationDialog {
  OccupationDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => OccupationDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
