import 'package:domain/constants/enum/cliq_alias_status_enum.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class UpdateCliqInfoBottomWidget extends StatelessWidget {
  final Function()? onEditId;
  final Function()? onLinkId;
  final Function()? onShareId;
  final Function()? onSuspendId;
  final Function()? onDeleteId;
  final Function()? onCancel;
  final Function()? onActivateId;
  final String? title;
  final CliqAliasIdStatusEnum? cliqAliasIdStatusEnum;
  final bool showLinkAccount;

  const UpdateCliqInfoBottomWidget(
      {Key? key,
      this.onActivateId,
      this.onCancel,
      this.onDeleteId,
      this.onLinkId,
      this.onEditId,
      this.onShareId,
      this.onSuspendId,
      this.title,
      this.cliqAliasIdStatusEnum,
      required this.showLinkAccount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: Wrap(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1.h,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            ///on edit
            Visibility(
              visible: CliqAliasIdStatusEnum.ACTIVE == cliqAliasIdStatusEnum,
              child: InkWell(
                onTap: () {
                  onEditId?.call();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    S.of(context).editId,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyMedium!.color!),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: CliqAliasIdStatusEnum.ACTIVE == cliqAliasIdStatusEnum,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  height: 1.h,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                ),
              ),
            ),

            ///onLink
            Visibility(
              visible: CliqAliasIdStatusEnum.ACTIVE == cliqAliasIdStatusEnum,
              child: Visibility(
                visible: showLinkAccount,
                child: InkWell(
                  onTap: () {
                    onLinkId?.call();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      S.of(context).linkAccount,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.t,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).textTheme.bodyMedium!.color!),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: CliqAliasIdStatusEnum.ACTIVE == cliqAliasIdStatusEnum,
              child: Visibility(
                visible: showLinkAccount,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Container(
                    height: 1.h,
                    color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                  ),
                ),
              ),
            ),

            ///on share
            InkWell(
              onTap: () {
                onShareId?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  S.of(context).shareId,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyMedium!.color!),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            ///suspend/activate
            InkWell(
              onTap: cliqAliasIdStatusEnum == CliqAliasIdStatusEnum.ACTIVE
                  ? () {
                      onSuspendId?.call();
                    }
                  : () {
                      onActivateId?.call();
                    },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  cliqAliasIdStatusEnum == CliqAliasIdStatusEnum.ACTIVE
                      ? S.of(context).suspendId
                      : S.of(context).activateId,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).textTheme.bodyMedium!.color!),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1.h,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            ///on delete
            InkWell(
              onTap: () {
                onDeleteId?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  S.of(context).deleteCliqId,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).errorColor),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),

            InkWell(
              onTap: () {
                onCancel?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0.h),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyMedium!.color!,
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
