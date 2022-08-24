import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog_view.dart';

class OccupationDialog {
  OccupationDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String, String)? onSelected,
      String? title,
      List<GetComboValuesData>? businessTypeList,
      required EmploymentStatusEnum employmentStatusEnum}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => OccupationDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            title: title,
            businessTypeList: businessTypeList,
            employmentStatusEnum: employmentStatusEnum));
  }
}
