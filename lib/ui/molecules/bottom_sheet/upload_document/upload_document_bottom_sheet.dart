import 'package:flutter/cupertino.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/upload_document/upload_document_bottom_sheet_view.dart';
import 'package:neo_bank/ui/molecules/cupertino_bottom_sheet.dart';

class UploadDocumentBottomSheet {
  UploadDocumentBottomSheet._();

  static show(
    BuildContext context, {
    String? title,
    Function()? onTakePhoto,
    Function()? uploadDocument,
    Function()? onCancel,
  }) async {
    CupertinoBottomSheet.show(context, builder: (context) {
      return UploadDocumentBottomSheetView(
          onTakePhoto: onTakePhoto,
          uploadDocument: uploadDocument,
          onCancel: onCancel,
          title: title);
    });
  }
}
