import 'package:domain/model/payment/get_rejection_reason/get_rejection_reason_response.dart';
import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/return_reasons_dialog/return_reason_payment_dialog_view.dart';

class ReturnReasonPaymentDialog {
  ReturnReasonPaymentDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(ReturnReasonsPayment)? onSelected,
      required String title,
      required final GetRejectionReasonResponseModel? returnReasonsPayment}) {
    AppDialog.show(
      mContext,
      isDismissible: true,
      builder: (context) => ReturnReasonPaymentDialogView(
        onDismissed: onDismissed,
        onSelected: onSelected,
        returnReasonsPayment: returnReasonsPayment,
        title: title,
      ),
    );
  }
}
