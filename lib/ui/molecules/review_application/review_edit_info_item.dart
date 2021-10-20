import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import '../app_svg.dart';

class ReviewEditInfoItem extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const ReviewEditInfoItem({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: AppColor.white_gray),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 24.0),
                child: Container(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      title,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.vivid_orange),
                    ),
                  ),
                ),
              ),
            ),
            // !isActive!
            //     ?
            InkWell(
              onTap: () {
                onTap?.call();
              },
              child: Padding(
                padding: EdgeInsets.only(right: 17),
                child: Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: AppSvg.asset(AssetUtils.edit,
                          width: 16, height: 16),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
