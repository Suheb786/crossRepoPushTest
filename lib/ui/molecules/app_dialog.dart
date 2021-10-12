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
        transitionBuilder: (context, a1, a2, widget) {
          return SlideTransition(
            position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(a1),
            child: widget,
          );
        },
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: AppColor.very_pale_blue_white.withOpacity(0.9),
        pageBuilder: (ctx, anim1, anim2) => builder(ctx));
  }
}
