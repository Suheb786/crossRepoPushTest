import 'dart:io';

import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/upload_document/upload_document_bottom_sheet.dart';

import 'bottom_sheet/upload_document/upload_document_bottom_sheet.dart';

class UploadDocumentSelectionWidget {
  UploadDocumentSelectionWidget._();

  static Future show(
    BuildContext context, {
    required Function()? onCameraTap,
    required Function()? onUploadDocumentTap,
    required Function()? onCancelled,
    required String? title,
  }) async {
    return Platform.isAndroid
        ? showModalBottomSheet(
            context: context,
            builder: (context) {
              return UploadDocumentBottomSheetWidget(
                title: title,
                onCameraTap: onCameraTap,
                onCancelTap: onCancelled,
                onPhotoLibraryTap: onUploadDocumentTap,
              );
            })
        : UploadDocumentBottomSheet.show(context,
            onCancel: onCancelled,
            onTakePhoto: onCameraTap,
            uploadDocument: onUploadDocumentTap,
            title: title);
  }
}
