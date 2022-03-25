import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/payment_activity_filter_dialog/payment_activity_filter_dialog_view.dart';

class PaymentActivityFilterDialog {
  PaymentActivityFilterDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      List<String>? filterList,
      FilterType? type}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => PaymentActivityFilterDialogView(
            onDismissed: onDismissed,
            onSelected: onSelected,
            filterType: type,
            filterList: filterList));
  }
}

enum FilterType { period, type }
