import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PayMyPrepPaidBillListItemWidget extends StatelessWidget {
  final String icon;
  final String nickname;
  final String billName;

  const PayMyPrepPaidBillListItemWidget({
    Key? key,
    required this.icon,
    required this.nickname,
    required this.billName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.0.h, horizontal: 24.0.w),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.vividYellow,
            ),
            child: AppSvg.asset(icon),
          ),
          SizedBox(
            width: 8.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nickname,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0.t),
              ),
              Text(
                billName,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.veryDarkGray2,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0.t),
              ),
            ],
          ),
          Spacer(),
          AppSvg.asset(AssetUtils.rightChevron)
        ],
      ),
    );
  }
}
