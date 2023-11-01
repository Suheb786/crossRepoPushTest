import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'cliq_information_dialog_view.dart';

class CliqInformationDialog {
  CliqInformationDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      required String title,
      required String description,
      required String subDescription}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => CliqInformationDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              isSwipeToCancel: isSwipeToCancel,
              image: image,
              title: title,
              description: description,
              subDescription: subDescription,
            ));
  }
}
