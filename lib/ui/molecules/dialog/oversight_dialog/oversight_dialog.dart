import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/oversight_dialog/oversight_dialog_view.dart';

class OversightDialog {
  OversightDialog._();

  static show(BuildContext mContext,
      {Function? onSecodaryButton,
      Function? onPrimaryButton,
      String? image,
      double? imageHight,
      double? imageWidth,
      String? btnTitle,
      bool imageDisabled = false,
      required String title,
      required Widget descriptionWidget,
      String? secondaryButtonTitle,
      bool onWillPop = true}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => OversightDialogView(
              onSecondaryButton: onSecodaryButton,
              onPrimaryButton: onPrimaryButton,
              image: image,
              imageHight: imageHight,
              imageWidth: imageWidth,
              title: title,
              btnTitle: btnTitle,
              descriptionWidget: descriptionWidget,
              onWillPop: onWillPop,
              imageDisabled: imageDisabled,
              secondaryButtonTitle: secondaryButtonTitle,
            ));
  }
}
