import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/calendar_dialog/calendar_dialog_view.dart';

class CalendarDialog {
  CalendarDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(DateTime)? onSelected,
      required DateTime initialDateTime,
      String? title,
      Function(String)? onHeaderTapped}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => CalendarDialogView(
            onDismissed: onDismissed,
            onHeaderTapped: onHeaderTapped,
            onSelected: onSelected,
            initialDateTime: initialDateTime,
            title: title));
  }
}
