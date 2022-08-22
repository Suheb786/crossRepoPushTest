import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'employment_status_dialog_view.dart';

class EmploymentStatusDialog {
  EmploymentStatusDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String, String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EmploymentStatusDialogView(onDismissed: onDismissed, onSelected: onSelected));
  }
}
