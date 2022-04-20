import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_cliq/update_cliq_info_bottom_sheet/update_cliq_info_bottom_sheet_view.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

class UpdateCliqInfoBottomSheet {
  UpdateCliqInfoBottomSheet._();

  static show(
    BuildContext context, {
    String? title,
    Function()? onEditId,
    Function()? onShareId,
    Function()? onSuspendId,
    Function()? onDeleteId,
    Function()? onCancel,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return UpdateCliqInfoBottomSheetView(
          onDeleteId: onDeleteId,
          onEditId: onEditId,
          onShareId: onShareId,
          onSuspendId: onSuspendId,
          onCancel: onCancel,
          title: title);
    });
  }
}
