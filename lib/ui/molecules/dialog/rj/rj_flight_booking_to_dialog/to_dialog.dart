import 'package:domain/model/rj/destinations.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/rj/rj_flight_booking_to_dialog/to_dialog_view.dart';

class ToDialog {
  ToDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(Destinations)? onSelected,
      String? title,
      List<Destinations>? destinationList}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => ToDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              title: title,
              destinationList: destinationList,
            ));
  }
}
