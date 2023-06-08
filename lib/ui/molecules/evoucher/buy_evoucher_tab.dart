import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/evoucher/widgets/top_brand_widget.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'widgets/browser_category_widget.dart';
import 'evoucher_text_widget.dart';
import 'favourite_brand_widget.dart';

class BuyEvoucherTab extends StatefulWidget {
  const BuyEvoucherTab({Key? key}) : super(key: key);

  @override
  State<BuyEvoucherTab> createState() => _BuyEvoucherTabState();
}

class _BuyEvoucherTabState extends State<BuyEvoucherTab> {
  @override
  Widget build(BuildContext context) {
    return AppKeyBoardHide(
      child: ListView(
        children: [
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24, end: 24),
            child: AppTextField(
              labelText: "",
              hintText: S.of(context).eVoucherSearchLabel,
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
            textColor: AppColor.gray5,
          ),
          const SizedBox(height: 4),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).buyVoucherTitle,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          const SizedBox(height: 40),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).favouriteBrand,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          const SizedBox(height: 16),
          FavouriteBrandGridItemWidget(),
          const SizedBox(height: 40),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).topBrand,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24.0),
            child: TopBrandListItemWidget(),
          ),
          const SizedBox(height: 25),
          EVoucherTextWidget(
            alignment: AlignmentDirectional.topStart,
            text: S.of(context).browserByCatgy,
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 24.0, end: 24, bottom: 48, top: 0),
            child: BrowserByCategoryItemWidget(),
          )
        ],
      ),
    );
  }
}
