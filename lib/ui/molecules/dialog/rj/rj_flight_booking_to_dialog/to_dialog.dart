import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view_model.dart';

class ToDialog {
  ToDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed, Function(ToSearchCountry)? onSelected, String? title}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => ToDialogView(onDismissed: onDismissed, onSelected: onSelected, title: title));
  }
}
