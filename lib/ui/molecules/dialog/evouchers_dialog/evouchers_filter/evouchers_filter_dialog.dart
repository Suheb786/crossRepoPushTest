import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_region_by_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/evouchers_dialog/evouchers_filter/evouchers_filter_dialog_view.dart';

import 'evouchers_filter_dialog_view_model.dart';

class EVouchersFilterDialog {
  EVouchersFilterDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(FilterSelectedData)? onSelected,
      String? title,
      List<VoucherCategories>? categoriesList,
      List<String>? rangeList,
      List<VoucherRegionByCategories>? regionList}) {
    AppDialog.show(mContext,
        builder: (context) => EVouchersFilterDialogView(
              onDismissed: onDismissed,
              title: title,
              onSelected: onSelected,
              categoriesList: categoriesList,
              rangeList: rangeList,
              regionList: regionList,
            ));
  }
}
