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
import 'package:neo_bank/ui/molecules/evoucher/favourite_brand_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';

class BuyEvoucherView extends BasePageViewWidget<EvoucherViewModel> {
  BuyEvoucherView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: ListView(
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
            child: Focus(
              child: AppTextField(
                labelText: "",
                controller: model.buyVoucherSearchController,
                hintText: S.of(context).eVoucherSearchLabel,
                hintTextColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
                containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                suffixIcon: (value, data) {
                  return InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                        height: 16.0.h,
                        width: 16.0.w,
                        padding: const EdgeInsets.all(6),
                        child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                  );
                },
              ),
              onFocusChange: (focus) {
                model.toggleSearch(focus);
              },
            ),
          ),
          const SizedBox(height: 32),
          ValueListenableBuilder<bool>(
            valueListenable: model.categoriesDisplayToggleNotifier,
            builder: (context, bool isShowingCategories, child) {
              return isShowingCategories

                  /// categories listing...
                  ? AppStreamBuilder<Resource<List<VoucherCategories>>>(
                      initialData: Resource.none(),
                      stream: model.voucherCategoriesResponseStream,
                      dataBuilder: (context, categoryData) {
                        if (categoryData?.status != Status.SUCCESS) {
                          return const SizedBox();
                        }
                        return Column(
                          children: [
                            EVoucherTextWidget(
                              alignment: AlignmentDirectional.topStart,
                              text: S.of(context).browserByCatgy,
                              textSize: 14,
                              textWeight: FontWeight.w600,
                              textColor: Theme.of(context).colorScheme.shadow,
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.only(start: 24.0, end: 24, bottom: 48, top: 0),
                              child: BrowserByCategoryItemWidget(
                                categoryData!.data!,
                                onSelectCategory: (category) {
                                  model.setSelectedCategory(category);
                                  Navigator.pushNamed(context, RoutePaths.EVouchersListing);
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    )

                  ///search data as per filter
                  : AppStreamBuilder<Resource<List<VoucherItem>>>(
                      initialData: Resource.none(),
                      stream: model.voucherByFilterAndSearchResponseStream,
                      dataBuilder: (context, voucherItems) {
                        if (voucherItems?.status != Status.SUCCESS) {
                          return const SizedBox();
                        }
                        return Padding(
                          padding: EdgeInsetsDirectional.only(start: 24.0, end: 24, bottom: 48, top: 0),
                          child: VoucherSearchAndFilterWidget(voucherItems!.data!),
                        );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }
}
