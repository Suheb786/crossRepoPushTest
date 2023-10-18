import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'apple_pay_landing_dialog_view.dart';

class ApplePayDialog {
  ApplePayDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => ApplePayDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            isSwipeToCancel: isSwipeToCancel,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
