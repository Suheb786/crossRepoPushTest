import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class NotifyMeWidget extends StatelessWidget {
  final Function()? onTap;
  final String? title;
  final String? labelText;

  const NotifyMeWidget({Key? key, this.onTap, this.title, this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.veryLightGray1),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            title!,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 17),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColor.veryLightGray1, width: 1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText!,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Montserrat',
                      color: AppColor.vivid_orange),
                ),
                InkWell(
                  onTap: () {
                    onTap?.call();
                  },
                  child: Container(
                      height: 16,
                      width: 16,
                      child: AppSvg.asset(AssetUtils.message)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
