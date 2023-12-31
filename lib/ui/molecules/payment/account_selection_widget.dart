import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountSelectionWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final String? labelTitle;
  final Function? onTap;
  final int currentIndex;

  const AccountSelectionWidget(
      {Key? key,
      required this.label,
      this.labelTitle = "",
      this.onTap,
      this.textColor,
      this.widgetColor,
      this.currentIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(start: 32),
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: widgetColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /***
             *  un-commented the label title to show
             * could be a future use.
             *  ***/

            labelTitle != null || labelTitle != ""
                ? !labelTitle!.contains(S.of(context).denomination)
                    ? Text(
                        labelTitle == null || labelTitle == "" ? S.of(context).account : '$labelTitle ',
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      )
                    : Container()
                : Container(),
            labelTitle != null || labelTitle != ""
                ? !labelTitle!.contains(S.of(context).denomination)
                    ? SizedBox(
                        height: 4,
                      )
                    : Container()
                : Container(),
            Text(
              label,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: textColor,
                  fontSize: labelTitle != null || labelTitle != ""
                      ? labelTitle!.contains(S.of(context).denomination)
                          ? 14
                          : 10
                      : 10,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
