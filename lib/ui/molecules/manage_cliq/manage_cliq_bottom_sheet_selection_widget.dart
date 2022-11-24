import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_cliq/manage_cliq_bottom_sheet/manage_cliq_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/manage_cliq_bottom_sheet_widget.dart';

class ManageCliqBottomSheetSelectionWidget {
  ManageCliqBottomSheetSelectionWidget._();

  static Future show(
    BuildContext context, {
    required Function()? setAsDefault,
    required Function()? unlinkAccount,
    required Function()? onCancelled,
    required String? title,
  }) async {
    return Platform.isAndroid
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return ManageCliqBottomSheetWidget(
                title: title,
                setAsDefault: setAsDefault,
                onCancelTap: onCancelled,
                unlinkAccount: unlinkAccount,
              );
            })
        : ManageCliqBottomSheet.show(context,
            onCancel: onCancelled, setAsDefault: setAsDefault, unlinkAccount: unlinkAccount, title: title);
  }
}
