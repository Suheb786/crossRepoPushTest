import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/relationship_with_pep/relationship_with_pep_dialog_view.dart';

class RelationshipWithPEPDialog {
  RelationshipWithPEPDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RelationshipWithPEPDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
