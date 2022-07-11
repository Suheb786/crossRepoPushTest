import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view.dart';

class EVouchersFilterDialog {
  EVouchersFilterDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function(String)? onSelected, String? title}) {
    AppDialog.show(mContext,
        builder: (context) => EVouchersFilterDialogView(
              onDismissed: onDismissed,
              title: title,
              onSelected: onSelected,
            ));
  }
}
