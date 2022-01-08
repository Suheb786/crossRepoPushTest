import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog_view.dart';

class StateCityDialog {
  StateCityDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(StateCityData)? onSelected,
      required String title,
      required List<StateCityData> stateCityData,
      required StateCityTypeEnum stateCityTypeEnum}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => StateCityDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            title: title,
            stateCityData: stateCityData,
            stateCityTypeEnum: stateCityTypeEnum));
  }
}

enum StateCityTypeEnum { STATE, CITY }
