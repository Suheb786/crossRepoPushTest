import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_details.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'bill_name_dialog_view.dart';

class PayBillDialog {
  PayBillDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(BillerDetailsList)? onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) =>
            PayBillDialogView(onDismissed: onDismissed, onSelected: onSelected, title: title));
  }
}
