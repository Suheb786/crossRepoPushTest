import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'region_filter_dialog_view.dart';

class RegionFilterDialog {
  RegionFilterDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(VoucherRegionByCategories)? onSelected,
      required String title,
      required bool isFromPurchaseFlow,
      required final List<VoucherRegionByCategories> regionByCategoriesList}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => RegionFilterDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              regionByCategoriesList: regionByCategoriesList,
              title: title,
              isFromPurchaseFlow: isFromPurchaseFlow,
            ));
  }
}
