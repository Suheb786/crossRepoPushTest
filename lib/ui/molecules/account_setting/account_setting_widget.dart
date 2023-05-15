import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountSettingWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final Function()? onTap;

  const AccountSettingWidget({Key? key, this.image, this.title, this.subtitle = '', this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Row(
        children: [
          AppSvg.asset(image!, height: 24.h, width: 24.w),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.t,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color),
                ),
                SizedBox(
                  height: 2.h,
                ),
                subtitle!.isNotEmpty
                    ? Directionality(
                        textDirection: TextDirection.ltr,
                        child: Text(
                          subtitle ?? '',
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.gray),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Container(
              height: 24.h,
              width: 24.w,
              child: AppSvg.asset(AssetUtils.rightChevron,
                  matchTextDirection: true, color: Theme.of(context).inputDecorationTheme.hintStyle!.color))
        ],
      ),
    );
  }
}
