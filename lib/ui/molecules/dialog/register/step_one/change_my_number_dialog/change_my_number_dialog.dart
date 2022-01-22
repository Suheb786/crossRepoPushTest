import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/change_my_number_dialog/change_my_number_dialog_view.dart';

class ChangeMyNumberDialog {
  ChangeMyNumberDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    Function()? showError,
    Function(CountryData, String)? onSelected,
    required List<CountryData> countryList,
  }) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => ChangeMyNumberDialogView(
            onDismissed: onDismissed,
            showError: showError,
            onSelected: onSelected,
            countryDataList: countryList));
  }
}
