import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/evoucher/evoucher_category_list_widget.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

import '../../../ui/molecules/stream_builder/app_stream_builder.dart';

class EVoucherCategoryListingPageView extends BasePageViewWidget<EVoucherCategoryListingPageViewModel> {
  EVoucherCategoryListingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, EVoucherCategoryListingPageViewModel model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsetsDirectional.only(start: 24, end: 24, top: 40),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
      child: AppStreamBuilder<Resource<List<VoucherItem>>>(
          initialData: Resource.none(),
          stream: model.voucherByCategoryResponseStream,
          dataBuilder: (context, categoryVouchers) {
            if (categoryVouchers?.status != Status.SUCCESS) {
              return const SizedBox();
            }
            return ListView.separated(
              itemBuilder: (context, index) {
                return EVoucherCategoryListWidget(
                  categoryVoucher: categoryVouchers!.data![index],
                );
              },
              separatorBuilder: (context, int) {
                return AppDivider();
              },
              itemCount: categoryVouchers?.data?.length ?? 0,
            );
          }),
    );
  }
}
