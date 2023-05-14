import 'package:flutter/cupertino.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class UploadDocumentBottomSheetView extends StatefulWidget {
  final Function()? onTakePhoto;
  final Function()? uploadDocument;
  final Function()? onCancel;
  final String? title;

  const UploadDocumentBottomSheetView({this.onTakePhoto, this.uploadDocument, this.title, this.onCancel});

  @override
  _UploadDocumentBottomSheetViewState createState() => _UploadDocumentBottomSheetViewState();
}

class _UploadDocumentBottomSheetViewState extends State<UploadDocumentBottomSheetView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        widget.title!,
        style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w600,
            fontSize: 13.t,
            color: AppColor.black.withOpacity(0.4)),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text(S.of(context).takePhoto,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20.t,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onTakePhoto?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).uploadDocument,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20.t,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.uploadDocument?.call();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(S.of(context).cancel,
            style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: AppColor.pure_blue)),
        onPressed: () {
          widget.onCancel?.call();
        },
      ),
    );
  }
}
