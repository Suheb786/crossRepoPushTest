import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'employment_status_dialog_view.dart';
import 'package:domain/constants/enum/nature_of_special_needs_enum.dart';

class EmploymentStatusDialog {
  EmploymentStatusDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(String)? onSelected, required NatureOfSpecialNeedsEnum natureOfNeedsEnum}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EmploymentStatusDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
          natureOfSpecialNeedsEnum: natureOfNeedsEnum,
            ));
  }
}
