import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/reason_of_unavailability/reason_of_unavailability_dialog_view.dart';

class ReasonOfUnavailabilityDialog {
  ReasonOfUnavailabilityDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => ReasonOfUnavailabilityDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
