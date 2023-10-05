import 'package:domain/model/offer_campaign/offer_categories/offers_categories.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_dialog.dart';

import 'filter_offer_categories_dialog_view.dart';

class FilterOfferCategoriesDialog {
  FilterOfferCategoriesDialog._();

  static show(BuildContext mContext,
      {Function? onDismissed,
      Function(OffersCategories)? onSelected,
      required String label,
      required List<OffersCategories> listOfOffersCategories}) {
    AppDialog.show(mContext,
        isDismissible: true,
        builder: (context) => FilterOfferCategoriesDialogView(
              onDismissed: onDismissed,
              onSelected: onSelected,
              listOfOffersCategories: listOfOffersCategories,
              label: label,
            ));
  }
}
