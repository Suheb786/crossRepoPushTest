import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/get_bill_payments_categories.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../app_divider.dart';

class PostPaidSettingTitleWidget extends StatelessWidget {

  final String tileIcon;
  final String? title;
  final Function()? onTap;

  const PostPaidSettingTitleWidget(
      {Key? key, required this.tileIcon, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap == null ? null : () => onTap!(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 26.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 40.w,
                  height: 40.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.vividYellow,
                  ),
                  child: Image.asset(
                    GetBillPaymentsCategories.path(this.tileIcon),
                    matchTextDirection: false,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: AppColor.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        AppDivider()
      ],
    );
  }
}
