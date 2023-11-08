import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/session_timeout/session_timeout_dialog_view.dart';

class SessionTimeoutDialog {
  SessionTimeoutDialog._();

  static show(
    BuildContext mContext, {
    Function? onSelected,
  }) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => SessionTimeoutDialogView(onSelected: onSelected));
  }
}
