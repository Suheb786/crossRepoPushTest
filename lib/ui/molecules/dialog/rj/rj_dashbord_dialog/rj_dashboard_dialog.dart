import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'rj_dashboard_dialog_view.dart';

class RjDialog {
  RjDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      required String image,
      bool? isSwipeToCancel,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RjDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            isSwipeToCancel: isSwipeToCancel,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
