import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmploymentListWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final Function? onTap;
  const EmploymentListWidget(
      {Key? key,
      required this.label,
      this.onTap,
      this.textColor,
      this.widgetColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsets.only(top: 20, left: 32),
        height: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: widgetColor),
        child: Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
