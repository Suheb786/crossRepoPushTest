import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_cliq/manage_cliq_bottom_sheet_view.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

class ManageCliqBottomSheet {
  ManageCliqBottomSheet._();

  static show(
    BuildContext context, {
    String? title,
    Function()? setAsDefault,
    Function()? unlinkAccount,
    Function()? onCancel,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return ManageCliqBottomSheetView(
          setAsDefault: setAsDefault,
          unlinkAccount: unlinkAccount,
          onCancel: onCancel,
          title: title);
    });
  }
}
