import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'add_other_card_to_apple_wallet_dialog_view.dart';

class AddOtherCardToAppleWalletDialog {
  AddOtherCardToAppleWalletDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => AddOtherCardToAppleWalletDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            isSwipeToCancel: isSwipeToCancel,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
