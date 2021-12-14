import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard_dialog/dashboard_dialog_view.dart';

class DashboardDialog {
  DashboardDialog._();

  static show(BuildContext context) {
    AppDialog.show(context,
        isDismissible: true, builder: (context) => DashboardDialogView());
  }
}
