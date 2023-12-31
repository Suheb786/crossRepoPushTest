import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class EVoucherCategoryListingPage extends BasePage<EVoucherCategoryListingPageViewModel> {
  final CategoryListArgument categoryListArgument;

  EVoucherCategoryListingPage(this.categoryListArgument);

  @override
  EVoucherCategoryListingPageState createState() => EVoucherCategoryListingPageState();
}

class EVoucherCategoryListingPageState
    extends BaseStatefulPage<EVoucherCategoryListingPageViewModel, EVoucherCategoryListingPage> {
  @override
  ProviderBase provideBase() {
    return eVouchersCategoryListingViewModelProvider.call(widget.categoryListArgument);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    return PreferredSize(
      preferredSize: Size(double.maxFinite, 85.h),
      child: Padding(
        padding: EdgeInsets.only(top: 52.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsetsDirectional.only(start: 24.0.w),
                child: AppSvg.asset(AssetUtils.leftArrow,
                    matchTextDirection: true, color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Text(
              getViewModel().argument.voucherCategory.categoryName,
              style: TextStyle(
                  fontSize: 14.t,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 18.0.w),
              child: Container(
                width: 28.w,
              ),
            )
          ],
        ),
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

class CategoryListArgument {
  final VoucherCategories voucherCategory;

  CategoryListArgument({
    required this.voucherCategory,
  });
}
