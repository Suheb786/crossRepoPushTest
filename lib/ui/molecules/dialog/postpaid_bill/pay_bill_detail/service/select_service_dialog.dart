import 'package:domain/model/bill_payments/get_biller_lookup_list/biller_service.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'select_service_dialog_view.dart';

class SelectServiceDialog {
  SelectServiceDialog._();

  static show(BuildContext mContext, List<BillerService> billerService, String billerCodeString,
      {Function? onDismissed, required Function(BillerService) onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => SelectServiceDialogView(
            onDismissed: onDismissed, onSelected: onSelected, title: title, billerService: billerService));
  }
}
