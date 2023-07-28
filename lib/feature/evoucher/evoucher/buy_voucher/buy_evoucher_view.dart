import 'package:domain/constants/enum/evoucher_filter_option_enum.dart';
import 'package:domain/model/e_voucher/voucher_categories.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher/evoucher_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/evoucher/browser_category_widget.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_text_widget.dart';
import 'package:neo_bank/ui/molecules/evoucher/voucher_search_filter_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../evoucher_category_listing/evoucher_category_listing_page.dart';
import '../../purchase_now/purchase_now_page.dart';

class BuyEvoucherView extends BasePageViewWidget<EvoucherViewModel> {
  BuyEvoucherView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: SingleChildScrollView(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
            child: Focus(
              child: AppTextField(
                labelText: "",
                controller: model.buyVoucherSearchController,
                hintText: S.of(context).eVoucherSearchLabel,
                hintTextColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
                containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                onChanged: (value) {
                  if (model.buyVoucherSearchController.text.isEmpty) {
                    model.toggleSearch(true);
                  }
                },
                suffixIcon: (value, data) {
                  return InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                        height: 16.0.h,
                        width: 16.0.w,
                        padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                        child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                  );
                },
              ),
              onFocusChange: (focus) {
                if (model.evoucherFilterOption == EvoucherFilterOption.FROM_SEARCH_FILTER) {
                  model.toggleSearch(focus);
                } else if (model.buyVoucherSearchController.text.isNotEmpty) {
                  model.toggleSearch(focus);
                }
              },
            ),
          ),
          SizedBox(height: 32.h),
          ValueListenableBuilder<bool>(
              valueListenable: model.categoriesDisplayToggleNotifier,
              builder: (context, bool isShowingCategories, child) {
                return isShowingCategories
                    ? AppStreamBuilder<Resource<List<VoucherCategories>>>(
                        initialData: Resource.none(),
                        stream: model.voucherCategoriesResponseStream,
                        dataBuilder: (context, categoryData) {
                          switch (categoryData?.status) {
                            case Status.SUCCESS:
                              return (categoryData?.data ?? []).isNotEmpty
                                  ? Column(
                                      children: [
                                        EVoucherTextWidget(
                                          alignment: AlignmentDirectional.topStart,
                                          text: S.of(context).browserByCatgy,
                                          textSize: 14.t,
                                          textWeight: FontWeight.w600,
                                          textColor: Theme.of(context).colorScheme.shadow,
                                        ),
                                        Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 24.0.w, end: 24.w, bottom: 48.h, top: 0.h),
                                          child: BrowserByCategoryItemWidget(
                                            categoryData!.data!,
                                            onSelectCategory: (category, index) {
                                              model.setSelectedCategory(category);
                                              Navigator.pushNamed(
                                                context,
                                                RoutePaths.EVouchersListing,
                                                
                                                arguments: CategoryListArgument(
                                                    id: categoryData.data?[index].id ?? 0.0),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(child: Text(S.of(context).noDataFound));
                            default:
                              return Container();
                          }
                        },
                      )
                    : AppStreamBuilder<Resource<List<VoucherItem>>>(
                        initialData: Resource.none(),
                        stream: model.voucherItemFilterResponseStream,
                        dataBuilder: (context, voucherItems) {
                          switch (voucherItems?.status) {
                            case Status.SUCCESS:
                              if ((voucherItems?.data ?? []).isNotEmpty) {
                                return Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 24.0.w, end: 24.w, bottom: 48.h, top: 0.h),
                                  child: VoucherSearchAndFilterWidget(voucherItems!.data!,
                                      onSelectSelectedVoucher: (voucherItems) {
                                    Navigator.pushNamed(
                                      context,
                                      RoutePaths.PurchaseNowDetail,
                                      arguments: PurchaseNowArgument(selectedVoucherItem: voucherItems),
                                    );
                                  }),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    S.of(context).noDataFound,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).primaryColorDark),
                                  ),
                                );
                              }
                            default:
                              return Container();
                          }
                        },
                      );
              }),
        ],
      )),
    );
  }
}
