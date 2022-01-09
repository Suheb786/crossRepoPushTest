import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/mobile_number_dialog/mobile_number_dialog_view.dart';

class MobileNumberDialog {
  MobileNumberDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(CountryData)? onSelected,
      List<CountryData>? countryDataList,
      String? title}) {
    AppDialog.show(mContext,
        builder: (context) => MobileNumberDialogView(
            onDismissed: onDismissed,
            countryDataList: countryDataList!,
            onSelected: onSelected,
            title: title));
  }
}
