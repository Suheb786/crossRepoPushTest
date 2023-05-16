import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageCliqBottomSheetWidget extends StatelessWidget {
  final Function()? setAsDefault;
  final Function()? unlinkAccount;
  final Function()? onCancelTap;
  final String? title;
  final bool showSetAsDefault;

  const ManageCliqBottomSheetWidget(
      {Key? key,
      this.setAsDefault,
      this.unlinkAccount,
      this.onCancelTap,
      this.title,
      this.showSetAsDefault = true})
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
            Visibility(
              visible: showSetAsDefault,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  height: 1.h,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                ),
              ),
            ),
            Visibility(
              visible: showSetAsDefault,
              child: InkWell(
                onTap: () {
                  setAsDefault?.call();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    S.of(context).setAsDefault,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).textTheme.bodyLarge!.color!),
                  ),
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
            Visibility(
              visible: false,
              child: InkWell(
                onTap: () {
                  unlinkAccount?.call();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    S.of(context).unlinkAccount,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontSize: 14.t,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Container(
                  height: 1.h,
                  color: Theme.of(context).primaryColorDark.withOpacity(0.3),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onCancelTap?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: Text(
                    S.of(context).cancel,
                    style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
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
