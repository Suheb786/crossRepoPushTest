import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CupertinoBottomSheet {
  CupertinoBottomSheet._();

  static show(
    BuildContext context, {
    bool isDismissible: true,
    required Widget Function(BuildContext context) builder,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: AppColor.very_pale_blue_white.withOpacity(0.9),
      barrierDismissible: isDismissible,
      builder: (context) => builder(context),
    );
  }
}
