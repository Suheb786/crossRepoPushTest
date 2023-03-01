import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/dialog/efawateer_landing_page_dialog/efawateer_landing_page_dialog_view.dart';

import '../../app_dialog.dart';

class EfawateerLandingDialog {
  EfawateerLandingDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => EfawateerLandingDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            isSwipeToCancel: isSwipeToCancel,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
