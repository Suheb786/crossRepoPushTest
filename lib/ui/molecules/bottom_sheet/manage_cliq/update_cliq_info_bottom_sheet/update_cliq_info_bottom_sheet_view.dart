import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

class UpdateCliqInfoBottomSheetView extends StatefulWidget {
  final Function()? onEditId;
  final Function()? onLinkId;
  final Function()? onShareId;
  final Function()? onSuspendId;
  final Function()? onDeleteId;
  final Function()? onCancel;
  final Function()? onActivateId;
  final String? title;
  final bool showLinkAccount;
  final CliqAliasIdStatusEnum cliqAliasIdStatusEnum;

  const UpdateCliqInfoBottomSheetView(
      {Key? key,
      this.onEditId,
      this.onLinkId,
      this.onShareId,
      this.onSuspendId,
      this.onDeleteId,
      this.onCancel,
      this.title,
      this.cliqAliasIdStatusEnum = CliqAliasIdStatusEnum.NONE,
      this.onActivateId,
      required this.showLinkAccount})
      : super(key: key);

  @override
  _UpdateCliqInfoBottomSheetViewState createState() =>
      _UpdateCliqInfoBottomSheetViewState(cliqAliasIdStatusEnum);
}

class _UpdateCliqInfoBottomSheetViewState extends State<UpdateCliqInfoBottomSheetView> {
  final CliqAliasIdStatusEnum cliqAliasIdStatusEnum;

  _UpdateCliqInfoBottomSheetViewState(this.cliqAliasIdStatusEnum);

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
        Visibility(
          visible: widget.showLinkAccount,
          child: CupertinoActionSheetAction(
            child: Text(S.of(context).linkAccount,
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: AppColor.pure_blue)),
            onPressed: () {
              widget.onLinkId?.call();
            },
          ),
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
        Visibility(
          visible: cliqAliasIdStatusEnum == CliqAliasIdStatusEnum.ACTIVE,
          child: CupertinoActionSheetAction(
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
        ),
        Visibility(
          visible: cliqAliasIdStatusEnum == CliqAliasIdStatusEnum.SUSPEND,
          child: CupertinoActionSheetAction(
            child: Text(S.of(context).activateId,
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: AppColor.pure_blue)),
            onPressed: () {
              widget.onActivateId?.call();
            },
          ),
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
