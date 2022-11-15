import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'nature_special_needs_dialog_view.dart';

class NatureSpecialNeedsDialog {
  NatureSpecialNeedsDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => NatureSpecialNeedsDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
