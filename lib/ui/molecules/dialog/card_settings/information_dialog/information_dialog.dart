import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog_view.dart';

class InformationDialog {
  InformationDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      required String image,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => InformationDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
