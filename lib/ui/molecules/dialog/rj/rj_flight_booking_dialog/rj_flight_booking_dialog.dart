import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_dialog/rj_flight_booking_dialog_view.dart';

class RjFlightBookingDialog {
  RjFlightBookingDialog._();

  static show(
    BuildContext mContext, {
    Function? onDismissed,
    Function(String)? onSelected,
  }) {
    AppDialog.show(mContext,
        builder: (context) => RjFlightBookingDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
            ));
  }
}
