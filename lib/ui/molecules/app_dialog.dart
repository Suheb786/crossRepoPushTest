import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppDialog {
  AppDialog._();

  static Future show(
    BuildContext context, {
    required Widget Function(BuildContext context) builder,
    bool isDismissible: true,
  }) {
    return showGeneralDialog(
        context: context,
        barrierLabel: '',
        barrierDismissible: isDismissible,
        transitionDuration: Duration(milliseconds: 100),
        barrierColor: AppColor.very_pale_blue_white.withOpacity(0.9),
        pageBuilder: (ctx, anim1, anim2) => builder(ctx));
  }
}
