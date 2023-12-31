import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/string_utils.dart';

class LinkAccountSelectionWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final Function? onTap;
  final int currentIndex;

  const LinkAccountSelectionWidget(
      {Key? key, required this.label, this.onTap, this.textColor, this.widgetColor, this.currentIndex = 0})
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
            Text(
              S.of(context).savingAccount('${currentIndex + 1}'),
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              label,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: textColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
