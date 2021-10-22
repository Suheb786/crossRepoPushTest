import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog_view.dart';

class StateCityDialog {
  StateCityDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      required String title,
      required StateCityTypeEnum stateCityTypeEnum}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => StateCityDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            title: title,
            stateCityTypeEnum: stateCityTypeEnum));
  }
}

enum StateCityTypeEnum { STATE, CITY }
