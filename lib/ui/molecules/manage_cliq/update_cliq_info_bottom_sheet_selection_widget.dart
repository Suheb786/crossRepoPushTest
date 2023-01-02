import 'dart:io';

import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_cliq/update_cliq_info_bottom_sheet/update_cliq_info_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/manage_cliq/update_cliq_info_bottom_widget.dart';

class UpdateCliqInfoBottomSheetSelectionWidget {
  UpdateCliqInfoBottomSheetSelectionWidget._();

  static Future show(BuildContext context,
      {required Function()? onEditId,
      required Function()? onShareId,
      required Function()? onCancelled,
      required Function()? onDeleteId,
      required Function()? onSuspendId,
      required Function()? onActivatId,
      required Function()? onLinkId,
      required CliqAliasIdStatusEnum cliqAliasIdStatusEnum,
      required String? title,
      required bool showLinkAccount}) async {
    return Platform.isAndroid
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return UpdateCliqInfoBottomWidget(
                  onCancel: onCancelled,
                  onShareId: onShareId,
                  onEditId: onEditId,
                  onLinkId: onLinkId,
                  onDeleteId: onDeleteId,
                  onSuspendId: onSuspendId,
                  onActivateId: onActivatId,
                  cliqAliasIdStatusEnum: cliqAliasIdStatusEnum,
                  title: title,
                  showLinkAccount: showLinkAccount);
            })
        : UpdateCliqInfoBottomSheet.show(context,
            onCancel: onCancelled,
            onShareId: onShareId,
            onEditId: onEditId,
            onLinkId: onLinkId,
            onDeleteId: onDeleteId,
            onSuspendId: onSuspendId,
            onActivateId: onActivatId,
            showLinkAccount: showLinkAccount,
            cliqAliasIdStatusEnum: cliqAliasIdStatusEnum,
            title: title);
  }
}
