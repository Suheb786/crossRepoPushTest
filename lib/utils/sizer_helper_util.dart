import 'package:flutter/cupertino.dart';

class SizeHelperUtil {
  SizeHelperUtil._();

  static double _width = 0.0;
  static double _height = 0.0;
  static double refWidth = 375;
  static double refHeight = 812;

  static void setWidthHeight(BoxConstraints constraints) {
    _width = constraints.maxWidth;
    _height = constraints.maxHeight;
  }

  static double get width => _width;

  static double get height => _height;
}

extension SizeExtension on num {
  double get h => SizeHelperUtil.height * (this / SizeHelperUtil.refHeight);

  double get w => SizeHelperUtil.width * (this / SizeHelperUtil.refWidth);

  double get t => (SizeHelperUtil.height) * (this / (SizeHelperUtil.refHeight));
}
