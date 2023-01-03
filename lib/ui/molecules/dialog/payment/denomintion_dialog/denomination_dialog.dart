import 'package:domain/model/bill_payments/get_pre_paid_categories/get_prepaid_categories_model_data.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'denomination_dialog_view.dart';

class DenominationsDialog {
  DenominationsDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(GetPrepaidCategoriesModelData)? onSelected,
      required String billerCode,
      required String serviceCode,
      required String label,
      List<GetPrepaidCategoriesModelData>? getPrePaidCategoriesList}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => DenominationsDialogView(
            billerCode: billerCode,
            serviceCode: serviceCode,
            getPrePaidCategoriesList: getPrePaidCategoriesList,
            onDismissed: onDismissed,
            label: label,
            onSelected: onSelected));
  }
}
