import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page.dart';

import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_category_list_widget.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/stream_builder/app_stream_builder.dart';

class EVoucherCategoryListingPageView extends BasePageViewWidget<EVoucherCategoryListingPageViewModel> {
  EVoucherCategoryListingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, EVoucherCategoryListingPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 40.h),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: Column(
        children: [
          Focus(
            child: AppTextField(
              labelText: "",
              controller: model.categorayListController,
              hintText: S.of(context).eVoucherSearchLabel,
              hintTextColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
              containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              onChanged: (value) {
                model.searchItems();
              },
              suffixIcon: (value, data) {
                return InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                      height: 16.0.h,
                      width: 16.0.h,
                      padding: const EdgeInsets.all(6),
                      child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                );
              },
            ),
            onFocusChange: (focus) {},
          ),
          Expanded(
            child: AppStreamBuilder<Resource<List<List<VoucherItem>>>>(
                initialData: Resource.none(),
                stream: model.voucherItemFilterResponseStream,
                dataBuilder: (context, categoryVouchers) {
                  switch (categoryVouchers?.status) {
                    case Status.SUCCESS:
                      return ((categoryVouchers?.data ?? []).isNotEmpty)
                          ? ListView.separated(
                              itemBuilder: (context, index) {
                                return EVoucherCategoryListWidget(
                                  imageUrl: categoryVouchers?.data?[index].first.cardFaceImage ?? '',
                                  onTap: () {
                                    Navigator.pushNamed(context, RoutePaths.SelectRegionAmountPage,
                                        arguments: SelectRegionAmountPageArgument(
                                            voucherItems: categoryVouchers?.data?[index] ?? []));
                                  },
                                  categoryVoucherName: categoryVouchers?.data?[index].first.brand,
                                );
                              },
                              separatorBuilder: (context, int) {
                                return AppDivider();
                              },
                              itemCount: categoryVouchers?.data?.length ?? 0,
                            )
                          : Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                S.of(context).noDataFound,
                                style: TextStyle(color: Theme.of(context).primaryColorDark),
                              ),
                            );

                    default:
                      return SizedBox();
                  }
                }),
          )
        ],
      ),
    );
  }
}
