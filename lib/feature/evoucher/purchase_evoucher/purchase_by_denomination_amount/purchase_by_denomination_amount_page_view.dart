import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_by_denomination_amount/purchase_by_denomination_amount_page_view_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_page.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/evoucher/voucher_search_filter_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../generated/l10n.dart';

class PurchaseByDenominationAmountPageView
    extends BasePageViewWidget<PurchaseByDenominationAmountPageViewModel> {
  PurchaseByDenominationAmountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PurchaseByDenominationAmountPageViewModel model) {
    return AppKeyBoardHide(
      child: Container(
        color: Theme.of(context).primaryColorDark,
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(height: 54.h),
                Row(
                  children: [
                    SizedBox(width: 24.w),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: AppSvg.asset(
                        AssetUtils.back,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          model.argument.category,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.t,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    )
                  ],
                ),
                SizedBox(height: 34.h),
              ],
            ),
            Expanded(
              child: Card(
                color: Theme.of(context).colorScheme.secondary,
                child: Container(
                  color: Theme.of(context).colorScheme.secondary,
                  margin: EdgeInsetsDirectional.only(top: 40.h, bottom: 24.h, start: 24.w, end: 24.w),
                  child: Column(
                    children: [
                      AppTextField(
                        labelText: "",
                        controller: model.textController,
                        hintText: S.of(context).eVoucherSearchLabel,
                        hintTextColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
                        containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        onChanged: (value) {
                          model.searchItems();
                        },
                        suffixIcon: (value, data) {
                          return Container(
                              height: 16.0.h,
                              width: 16.0.w,
                              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                              child:
                                  AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark));
                        },
                      ),
                      AppStreamBuilder<List<VoucherItem>>(
                          stream: model.voucherFilterResponseStream,
                          initialData: [],
                          dataBuilder: (context, data) {
                            return VoucherSearchAndFilterWidget(data ?? [],
                                onSelectSelectedVoucher: (voucherItems) {
                              Navigator.pushNamed(context, RoutePaths.PurchaseNowDetail,
                                  arguments: PurchaseNowArgument(selectedVoucherItem: voucherItems));
                            });
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
