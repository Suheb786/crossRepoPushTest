import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/version_update/version_update_dialog_view.dart';

class VersionUpdateDialog {
  VersionUpdateDialog._();

  static show(BuildContext mContext,
      {Function? onSelected,
      String? image,
      required String title,
      required Widget descriptionWidget}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => VersionUpdateDialogView(
            onSelected: onSelected,
            image: image,
            title: title,
            descriptionWidget: descriptionWidget));
  }
}
