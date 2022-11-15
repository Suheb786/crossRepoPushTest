import 'package:domain/model/account/available_time_slots.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_five/schedule_call_time_dialog/schedule_call_time_dialog_view.dart';

class ScheduleCallTimeDialog {
  ScheduleCallTimeDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(AvailableTimeSlots)? onSelected,
      List<AvailableTimeSlots>? data,
      String? title}) {
    AppDialog.show(mContext,
        builder: (context) => ScheduleCallTimeDialogView(
            onDismissed: onDismissed, data: data!, onSelected: onSelected, title: title));
  }
}
