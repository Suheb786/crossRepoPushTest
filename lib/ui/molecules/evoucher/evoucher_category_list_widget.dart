import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/evoucher/evoucher_category_listing/evoucher_category_listing_page_view_model.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EVoucherCategoryListWidget extends StatelessWidget {
  final CategoryModel? categoryModel;

  const EVoucherCategoryListWidget({Key? key, this.categoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RoutePaths.EVouchersPurchase);
      },
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///TODO:use category image here
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 56,
                width: 56,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Flexible(
              child: Text(
                categoryModel!.categoryName ?? '',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Theme.of(context).indicatorColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
