import 'package:domain/model/user/additional_income_type.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog_view.dart';

class AdditionalIncomeSourceDialog {
  AdditionalIncomeSourceDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(AdditionalIncomeType)? onSelected}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => AdditionIncomeSourceDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}

