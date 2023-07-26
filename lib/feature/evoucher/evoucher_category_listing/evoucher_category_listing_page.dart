// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

class EVoucherCategoryListingPage extends BasePage<EVoucherCategoryListingPageViewModel> {
  final EVoucherCatagoryListArgument argument;
  EVoucherCategoryListingPage({
    required this.argument,
  });
  @override
  EVoucherCategoryListingPageState createState() => EVoucherCategoryListingPageState();
}

class EVoucherCategoryListingPageState
    extends BaseStatefulPage<EVoucherCategoryListingPageViewModel, EVoucherCategoryListingPage> {
  @override
  ProviderBase provideBase() {
    return eVouchersCategoryListingViewModelProvider.call(widget.argument);
  }

  @override
  PreferredSizeWidget? buildAppbar() {
    final provider = ProviderScope.containerOf(appLevelKey.currentContext!).read(
      evoucherViewModelProvider,
    );
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

            ///TODO:pass category name here
            Text(
              provider.selectedVoucherCategories.categoryName ?? '',
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.secondary),
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

class EVoucherCatagoryListArgument {
  final String name;

  EVoucherCatagoryListArgument({
    required this.name,
  });
}
