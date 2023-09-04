import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/sub_accounts_dialogs/confirmation_dialog/confirmation_dialog_view.dart';

class ConfirmationDialog {
  ConfirmationDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    Function? onConfirmed,
    String? image,
    bool? isSwipeToCancel,
    double? imageHight,
    double? imageWidth,
    required String title,
    required Widget descriptionWidget,
    String? doneImage,
  }) {
    AppDialog.show(mContext, builder: (context) {
      return ConfirmationDialogView(
        onDismissed: onDismissed,
        onConfirmed: onConfirmed,
        isSwipeToCancel: isSwipeToCancel,
        image: image,
        imageHight: imageHight,
        imageWidth: imageWidth,
        title: title,
        descriptionWidget: descriptionWidget,
        doneImage: doneImage,
      );
    });
  }
}
