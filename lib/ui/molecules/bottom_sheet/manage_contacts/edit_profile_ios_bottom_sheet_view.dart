import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EditProfileiosBottomSheetView extends StatefulWidget {
  final Function()? onTakePhoto;

  final Function()? onSelectFromLibrary;

  final Function()? onRemovePhoto;
  final Function()? onCancel;

  final String? title;

  const EditProfileiosBottomSheetView({
    Key? key,
    required this.onSelectFromLibrary,
    required this.onTakePhoto,
    required this.onRemovePhoto,
    required this.onCancel,
    required this.title,
  }) : super(key: key);

  @override
  _EditProfileiosBottomSheetViewState createState() => _EditProfileiosBottomSheetViewState();
}

class _EditProfileiosBottomSheetViewState extends State<EditProfileiosBottomSheetView> {
  _EditProfileiosBottomSheetViewState();

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        widget.title!,
        style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: AppColor.black.withOpacity(0.4)),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text(S.of(context).takePhoto,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onTakePhoto?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).selectFromLibrary,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onSelectFromLibrary?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).removePhoto,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.error)),
          onPressed: () {
            widget.onRemovePhoto?.call();
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(S.of(context).cancel,
            style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColor.pure_blue)),
        onPressed: () {
          widget.onCancel?.call();
        },
      ),
    );
  }
}
