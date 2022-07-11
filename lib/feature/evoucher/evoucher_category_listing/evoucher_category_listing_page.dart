import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class EVoucherCategoryListingPage extends BasePage<EVoucherCategoryListingPageViewModel> {
  @override
  EVoucherCategoryListingPageState createState() => EVoucherCategoryListingPageState();
}

class EVoucherCategoryListingPageState
    extends BaseStatefulPage<EVoucherCategoryListingPageViewModel, EVoucherCategoryListingPage> {
  @override
  ProviderBase provideBase() {
    return eVouchersCategoryListingViewModelProvider;
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 24.0),
              child: AppSvg.asset(AssetUtils.leftArrow,
                  matchTextDirection: true, color: Theme.of(context).accentColor),
            ),
          ),

          ///TODO:pass category name here
          Text(
            'Games',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 18.0),
            child: Container(
              width: 28,
            ),
          )
        ],
      ),
    );
  }

  @override
  bool extendBodyBehindAppBar() {
    return false;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context, EVoucherCategoryListingPageViewModel model) {
    return EVoucherCategoryListingPageView(provideBase());
  }
}
