import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_contacts/edit_profile_ios_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/manage_contacts/edit_profile_pic_widget.dart';

class EditProfilePicBottomSheetSelectionWidget {
  EditProfilePicBottomSheetSelectionWidget._();

  static Future show(
    BuildContext context, {
    required Function()? onCancel,
    required Function()? onRemovePhoto,
    required Function()? onSelectFromLibrary,
    required Function()? onTakePhoto,
    required String? title,
  }) async {
    return
     Platform.isAndroid
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return EditProfileAndroidBottomSheetWidget(
                onCancel: onCancel,
                onRemovePhoto: onRemovePhoto,
                onSelectFromLibrary: onSelectFromLibrary,
                onTakePhoto: onTakePhoto,
                title: title,
              );
            })
        :
         EditProfileiosBottomSheet.show(context,
            title: title,
            onRemovePhoto: onRemovePhoto,
            onSelectFromLibrary: onSelectFromLibrary,
            onTakePhoto: onTakePhoto,
            onCancel: onCancel);
  }
}
