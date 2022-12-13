import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_cliq/update_cliq_info_bottom_sheet/update_cliq_info_bottom_sheet_view.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

class UpdateCliqInfoBottomSheet {
  UpdateCliqInfoBottomSheet._();

  static show(
    BuildContext context, {
    String? title,
    CliqAliasIdStatusEnum cliqAliasIdStatusEnum = CliqAliasIdStatusEnum.NONE,
    Function()? onEditId,
    Function()? onShareId,
    Function()? onSuspendId,
    Function()? onDeleteId,
    Function()? onActivateId,
    Function()? onCancel,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return UpdateCliqInfoBottomSheetView(
          onDeleteId: onDeleteId,
          onEditId: onEditId,
          onShareId: onShareId,
          onSuspendId: onSuspendId,
          cliqAliasIdStatusEnum: cliqAliasIdStatusEnum,
          onCancel: onCancel,
          onActivateId: onActivateId,
          title: title);
    });
  }
}
