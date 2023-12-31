import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'evoucher_landing_dialog_view.dart';

class EvoucherDialog {
  EvoucherDialog._();

  static show(BuildContext mContext, {Function? onDismissed, Function? onSelected, bool? isSwipeToCancel}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => EvoucherLandingDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              isSwipeToCancel: isSwipeToCancel,
            ));
  }
}
