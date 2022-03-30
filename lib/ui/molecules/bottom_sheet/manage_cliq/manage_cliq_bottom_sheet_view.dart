import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ManageCliqBottomSheetView extends StatefulWidget {
  final Function()? setAsDefault;
  final Function()? unlinkAccount;
  final Function()? onCancel;
  final String? title;

  const ManageCliqBottomSheetView(
      {this.setAsDefault, this.unlinkAccount, this.title, this.onCancel});

  @override
  _ManageCliqBottomSheetViewState createState() =>
      _ManageCliqBottomSheetViewState();
}

class _ManageCliqBottomSheetViewState extends State<ManageCliqBottomSheetView> {
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
          child: Text(S.of(context).setAsDefault,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColor.pure_blue)),
          onPressed: () {
            widget.setAsDefault?.call();
          },
        ),
        CupertinoActionSheetAction(
          child: Text(S.of(context).unlinkAccount,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Theme.of(context).errorColor)),
          onPressed: () {
            widget.unlinkAccount?.call();
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
