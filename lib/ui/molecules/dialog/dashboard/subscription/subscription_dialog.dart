import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/subscription/subscription_dialog_view.dart';

class SubscriptionDialog {
  SubscriptionDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function()? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => SubscriptionDialogView(
            onDismissed: onDismissed, onSelected: onSelected));
  }
}
