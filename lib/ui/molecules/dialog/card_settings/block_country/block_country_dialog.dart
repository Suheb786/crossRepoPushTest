import 'package:domain/model/country/country_list/country_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/block_country/block_country_dialog_view.dart';

class BlockCountryDialog {
  BlockCountryDialog._();

  static show(
    BuildContext mContext, {
    required CountryData countryData,
    Function? onDismissed,
    Function(String)? onSelected,
    String? title,
  }) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => BlockCountryDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              title: title,
              countryData: countryData,
            ));
  }
}
