import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog_view.dart';

class CountryDialog {
  CountryDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(CountryData)? onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) =>
            CountryDialogView(onDismissed: onDismissed, onSelected: onSelected, title: title));
  }
}
