import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/manage_contacts/edit_profile_ios_bottom_sheet_view.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

class EditProfileiosBottomSheet {
  EditProfileiosBottomSheet._();

  static show(
    BuildContext context, {
    required String? title,
    required Function()? onRemovePhoto,
    required Function()? onSelectFromLibrary,
    required Function()? onTakePhoto,
    required Function()? onCancel,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return EditProfileiosBottomSheetView(
        onCancel: onCancel,
        onRemovePhoto: onRemovePhoto,
        onSelectFromLibrary: onSelectFromLibrary,
        onTakePhoto: onTakePhoto,
        title: title,
      );
    });
  }
}
