import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListScrollWheelListWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final Function? onTap;
  const ListScrollWheelListWidget(
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
        margin: EdgeInsets.symmetric(horizontal: 16),
        height: 64,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: widgetColor),
        child: Text(
          label,
          style: TextStyle(
              color: textColor, fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
