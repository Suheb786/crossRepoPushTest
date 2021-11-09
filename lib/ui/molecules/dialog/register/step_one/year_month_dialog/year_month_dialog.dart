import 'package:domain/constants/enum/calendar_enum.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/year_month_dialog/year_month_dialog_view.dart';

class YearMonthDialog {
  YearMonthDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(String)? onSelected,
      required String title,
      required CalendarEnum calendarEnum}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => YearMonthDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              title: title,
              calendarEnum: calendarEnum,
            ));
  }
}
