import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/evoucher/top_brand_widget.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../app_svg.dart';
import 'browser_category_widget.dart';
import 'favourite_brand_widget.dart';
import 'evoucher_text_widget.dart';

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
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: AppTextField(
              labelText: "",
              hintText: S.of(context).eVoucherSearchLabel,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
              padding: const EdgeInsets.only(
                left: 24,
              ),
              height: 211,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.EvoucherDetail);
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
          SizedBox(
            height: 16,
          ),
          EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text: 'FIFA 22',
            textSize: 12,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray5,
          ),
          SizedBox(
            height: 4,
          ),
          EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text:
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula',
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          SizedBox(
            height: 40,
          ),
          EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text: 'Favourite Brand',
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          SizedBox(
            height: 16,
          ),
          FavouriteBrandGridItemWidget(),
          SizedBox(
            height: 40,
          ),
          EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text: 'Top Brands',
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: TopBrandListItemWidget(),
          ),
          SizedBox(
            height: 25,
          ),
          EVoucherTextWidget(
            alignment: Alignment.topLeft,
            text: 'Browse by Category',
            textSize: 14,
            textWeight: FontWeight.w600,
            textColor: AppColor.gray_black,
          ),
          SizedBox(
            height: 17,
          ),
          Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24, bottom: 48, top: 0),
            child: BrowserByCategoryItemWidget(),
          )
        ],
      ),
    );
  }
}
