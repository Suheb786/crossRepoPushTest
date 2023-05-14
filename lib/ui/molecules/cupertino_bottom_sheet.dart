import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/color_utils.dart';

class CupertinoBottomSheet {
  CupertinoBottomSheet._();

  static show(
    BuildContext context, {
    bool isDismissible = true,
    required Widget Function(BuildContext context) builder,
  }) {
    showCupertinoModalPopup(
      context: context,
      barrierColor: AppColor.black.withOpacity(0.5),
      barrierDismissible: isDismissible,
      builder: (context) => builder(context),
    );
  }
}
