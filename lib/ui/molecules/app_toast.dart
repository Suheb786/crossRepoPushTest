import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppToast {
  AppToast._();

  static showToast(
    String message, {
    Color backgroundColor = AppColor.white,
    Toast duration = Toast.LENGTH_LONG,
    Color textColor = AppColor.black,
    ToastGravity gravity = ToastGravity.BOTTOM,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: duration,
      gravity: gravity,
      backgroundColor: backgroundColor,
      timeInSecForIosWeb: 3,
      textColor: textColor,
      fontSize: 14,
    );
  }
}
