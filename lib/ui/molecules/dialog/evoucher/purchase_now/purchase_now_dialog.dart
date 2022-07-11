import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evoucher/purchase_now/purchase_now_view.dart';

class PurchaseNowDialog {
  PurchaseNowDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function? onSelected,
      String? image,
      bool? isSwipeToCancel,
      required String title,
      required Widget descriptionWidget,
      required String subTitle,
      required String price}) {
    AppDialog.show(mContext,
        isDismissible: false,
        builder: (context) => PurchaseNowDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              isSwipeToCancel: isSwipeToCancel,
              image: image,
              title: title,
              descriptionWidget: descriptionWidget,
              price: price,
              subTitle: subTitle,
            ));
  }
}
