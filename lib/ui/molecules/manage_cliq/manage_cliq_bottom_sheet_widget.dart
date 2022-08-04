import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageCliqBottomSheetWidget extends StatelessWidget {
  final Function()? setAsDefault;
  final Function()? unlinkAccount;
  final Function()? onCancelTap;
  final String? title;

  const ManageCliqBottomSheetWidget({
    Key? key,
    this.setAsDefault,
    this.unlinkAccount,
    this.onCancelTap,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).accentColor,
        child: Wrap(
          children: <Widget>[
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  title ?? "",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorDark.withOpacity(0.4)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),
            InkWell(
              onTap: () {
                setAsDefault?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  S.of(context).setAsDefault,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).accentTextTheme.bodyText1!.color),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),
            InkWell(
              onTap: () {
                unlinkAccount?.call();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  S.of(context).unlinkAccount,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).errorColor),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Container(
                height: 1,
                color: Theme.of(context).primaryColorDark.withOpacity(0.3),
              ),
            ),
            InkWell(
              onTap: () {
                onCancelTap?.call();
              },
              child: Center(
                  child: Padding(
                padding: EdgeInsets.only(bottom: 24.0),
                child: Text(
                  S.of(context).cancel,
                  style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).accentTextTheme.bodyText1!.color,
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
