import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog_view.dart';

class RTPConfirmationDialog {
  RTPConfirmationDialog._();

  static show(BuildContext mContext,
      {Function()? onDismiss,
      Function()? onAccepted,
      Function()? onRejected,
      required String amount,
      required String currency,
      required bool isAmountVisible,
      required String cdtrAcct,
      required String cdtrDpText,
      required String cdtrName,
      required Widget actionWidget,
      required Widget description,
      required Widget listOfDetails,
      required bool showDescription}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RTPConfirmationDialogView(
              actionWidget: actionWidget,
              description: description,
              listOfDetails: listOfDetails,
              showDescription: showDescription,
              amount: amount,
              currency: currency,
              cdtrAcct: cdtrAcct,
              cdtrDpText: cdtrDpText,
              cdtrName: cdtrName,
              onAccepted: onAccepted,
              onDismiss: onDismiss,
              onRejected: onRejected,
              isAmountVisible: isAmountVisible,
            ));
  }
}
