import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class UpdateCliqInfoBottomSheetView extends StatefulWidget {
  final Function()? onEditId;
  final Function()? onShareId;
  final Function()? onSuspendId;
  final Function()? onDeleteId;
  final Function()? onCancel;
  final String? title;

  const UpdateCliqInfoBottomSheetView(
      {Key? key, this.onEditId, this.onShareId, this.onSuspendId, this.onDeleteId, this.onCancel, this.title})
      : super(key: key);

  @override
  _UpdateCliqInfoBottomSheetViewState createState() => _UpdateCliqInfoBottomSheetViewState();
}

class _UpdateCliqInfoBottomSheetViewState extends State<UpdateCliqInfoBottomSheetView> {
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
          child: Text(S.of(context).editId,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onEditId?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).shareId,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onShareId?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).suspendId,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.onSuspendId?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).deleteCliqId,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Theme.of(context).errorColor)),
          onPressed: () {
            widget.onDeleteId?.call();
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
