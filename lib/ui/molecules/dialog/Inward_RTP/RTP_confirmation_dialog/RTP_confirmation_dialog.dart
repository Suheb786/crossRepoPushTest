import 'package:domain/model/cliq/request_money_activity/request_money_activity_list.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_activity_transaction_view_model.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/Inward_RTP/RTP_confirmation_dialog/RTP_confirmation_dialog_view.dart';

class RTPConfirmationDialog {
  RTPConfirmationDialog._();

  static show(BuildContext mContext,
      {Function()? onDismiss,
      Function()? onAccepted,
      Function()? onRejected,
      required String amount,
      required String cdtrAcct,
      required String cdtrDpText,
      required String cdtrName,
      required Widget actionWidget,
      required Widget description,
      required Widget listOfDetails,
      required bool showDescription}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => RTPConfirmationDialogView(
              actionWidget: actionWidget,
              description: description,
              listOfDetails: listOfDetails,
              showDescription: showDescription,
              amount: amount,
              cdtrAcct: cdtrAcct,
              cdtrDpText: cdtrDpText,
              cdtrName: cdtrName,
              onAccepted: onAccepted,
              onDismiss: onDismiss,
              onRejected: onRejected,
            ));
  }
}
