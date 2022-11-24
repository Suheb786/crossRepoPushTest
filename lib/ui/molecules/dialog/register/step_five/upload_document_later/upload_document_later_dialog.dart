import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/upload_document_later/upload_document_later_dialog_view.dart';

class UploadDocumentLaterDialog {
  UploadDocumentLaterDialog._();

  static show(
    BuildContext mContext, {
    Function()? onSelected,
  }) {
    AppDialog.show(mContext,
        isDismissible: true, builder: (context) => UploadDocumentLaterDialogView(onSelected: onSelected));
  }
}
