import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/cancellation_reason_dialog/cancellation_reason_dialog_view.dart';

class CancellationReasonDialog {
  CancellationReasonDialog._();

  static show(
    BuildContext mContext, {
    required List<String> reasons,
    Function? onDismissed,
    Function(String)? onSelected,
    String? title,
  }) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => CancellationReasonDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              title: title,
              reasons: reasons,
            ));
  }
}
