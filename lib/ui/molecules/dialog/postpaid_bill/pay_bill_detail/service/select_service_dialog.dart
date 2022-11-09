import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'select_service_dialog_view.dart';

class SelectServiceDialog {
  SelectServiceDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String)? onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) =>
            SelectServiceDialogView(onDismissed: onDismissed, onSelected: onSelected, title: title));
  }
}
