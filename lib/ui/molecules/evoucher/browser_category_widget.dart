import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

import 'my_voucher_text_widget.dart';

class BrowserByCategoryItemWidget extends StatelessWidget {
  const BrowserByCategoryItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          child: _buildListItem(),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: 1.0),
    );
  }

  Widget _buildListItem() {
    return Card(
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        height: 103,
        width: 103.66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetUtils.top_brand_adidas,
            ),
            EVoucherTextWidget(
              alignment: Alignment.center,
              text: 'Games',
              textSize: 14,
              textWeight: FontWeight.w600,
              textColor: AppColor.gray_black,
            ),
          ],
        ),
      ),
    );
  }
}
