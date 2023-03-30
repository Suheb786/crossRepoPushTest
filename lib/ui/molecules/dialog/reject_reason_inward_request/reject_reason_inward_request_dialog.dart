import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/reject_reason_inward_request/reject_reason_inward_request_dialog_view.dart';

class RejectReasonInwardRequestDialog {
  RejectReasonInwardRequestDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(RejectionReasonInward)? onSelected,
      required String title,
      required final List<RejectionReasonInward> rejectionReasonInward}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RejectReasonInwardRequestDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            rejectionReasonInward: rejectionReasonInward,
            title: title));
  }
}
