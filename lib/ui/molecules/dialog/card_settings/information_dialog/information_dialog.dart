import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog_view.dart';

class InformationDialog {
  InformationDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      double? imageHight,
      double? imageWidth,
      String? btnTitle,
      required String title,
      required Widget descriptionWidget,
      String? doneImage,
      bool onWillPop = true}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => InformationDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              isSwipeToCancel: isSwipeToCancel,
              image: image,
              imageHight: imageHight,
              imageWidth: imageWidth,
              title: title,
              btnTitle: btnTitle,
              descriptionWidget: descriptionWidget,
              doneImage: doneImage,
              onWillPop: onWillPop,
            ));
  }
}
