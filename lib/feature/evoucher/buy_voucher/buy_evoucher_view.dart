import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/app_keyboard_hide.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../ui/molecules/evoucher/browser_category_widget.dart';
import '../../../ui/molecules/evoucher/evoucher_text_widget.dart';
import '../../../ui/molecules/evoucher/favourite_brand_widget.dart';
import '../../../ui/molecules/evoucher/top_brand_widget.dart';
import '../../../ui/molecules/textfield/app_textfield.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../evoucher/evoucher_view_model.dart';

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
            child: AppTextField(
              labelText: "",
              controller: model.buyVoucherSearchController,
              hintText: S.of(context).eVoucherSearchLabel,
              hintTextColor: Theme.of(context).inputDecorationTheme.hintStyle?.color,
              containerPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              onChanged: (value) {
                // model.searchBillName(value);
              },
              suffixIcon: (value, data) {
                return InkWell(
                  onTap: () async {},
                  child: Container(
                      height: 16.0.h,
                      width: 16.0.w,
                      padding: EdgeInsets.all(6),
                      child: AppSvg.asset(AssetUtils.search, color: Theme.of(context).primaryColorDark)),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          Container(
              padding: const EdgeInsetsDirectional.only(
                start: 24,
              ),
              height: 211,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                padding: EdgeInsetsDirectional.only(end: 24),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.PurchaseNowDetail);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      child: Container(
                        color: Colors.yellow,
                        width: 327,
                        height: 211,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 8.0,
                  );
                },
              )),
          const SizedBox(height: 16),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).purchaseNowSubTitle,
            textSize: 12,
            textWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          const SizedBox(height: 4),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).buyVoucherTitle,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.shadow,
          ),
          const SizedBox(height: 40),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).browserByCatgy,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: Theme.of(context).colorScheme.shadow,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.0, end: 24, bottom: 48, top: 0),
            child: BrowserByCategoryItemWidget(),
          )

        ],
      ),
    );
  }
}
