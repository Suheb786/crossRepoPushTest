import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppDivider extends StatelessWidget {
  final double thickness;
  final Color color;
  final double height;
  final double indent;
  final double endIndent;

  const AppDivider(
      {Key? key,
        this.thickness: 1,
        this.color: AppColor.light_gray,
        this.height: 1,
        this.indent: 0,
        this.endIndent: 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: thickness,
      height: height,
      color: color,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
