import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/account_setting/upload_profile_bottom_sheet_widget.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/upload_profile/upload_profile_bottom_sheet.dart';

class ChooseProfileWidget {
  ChooseProfileWidget._();

  static Future show(
    BuildContext context, {
    required Function()? onCameraTap,
    required Function()? onGalleryTap,
    required Function()? onRemoveTap,
    required Function()? onCancelled,
    required String? title,
  }) async {
    return Platform.isAndroid
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return UploadProfileBottomSheetWidget(
                title: title,
                onCameraTap: onCameraTap,
                onCancelTap: onCancelled,
                onRemoveTap: onRemoveTap,
                onPhotoLibraryTap: onGalleryTap,
              );
            })
        : UploadProfileBottomSheet.show(context,
            onCancel: onCancelled,
            onTakePhoto: onCameraTap,
            onGalleryTap: onGalleryTap,
            onRemoveTap: onRemoveTap,
            title: title);
  }
}
