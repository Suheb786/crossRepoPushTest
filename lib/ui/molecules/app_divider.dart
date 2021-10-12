import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppDivider extends StatelessWidget {
  final Color? color;
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;

  const AppDivider(
      {Key? key,
      this.color: AppColor.white,
      this.height: 1,
      this.thickness: 1,
      this.indent: 0,
      this.endIndent: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Divider(
        height: height,
        color: color,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
