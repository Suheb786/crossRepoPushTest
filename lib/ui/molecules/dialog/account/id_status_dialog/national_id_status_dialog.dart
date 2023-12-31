import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'national_id_status_dialog_view.dart';

class NationalIDStatusDialog {
  NationalIDStatusDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    Function? onSelected,
    String? image,
    bool? isSwipeToCancel,
    double? imageHight,
    double? imageWidth,
    required String title,
    required Widget descriptionWidget,
    String? doneImage,
  }) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => NationalIDStatusDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              isSwipeToCancel: isSwipeToCancel,
              image: image,
              imageHight: imageHight,
              imageWidth: imageWidth,
              title: title,
              descriptionWidget: descriptionWidget,
              doneImage: doneImage,
            ));
  }
}
