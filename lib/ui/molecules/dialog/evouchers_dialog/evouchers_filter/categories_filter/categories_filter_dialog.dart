import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/widgets.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'categories_filter_dialog_view.dart';

class CategoriesFilterDialog {
  CategoriesFilterDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(VoucherCategories)? onSelected,
      required String title,
      required final List<VoucherCategories> categoriesList}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => CategoriesFilterDialogView(
            onDismissed: onDismissed, onSelected: onSelected, categoriesList: categoriesList, title: title));
  }
}
