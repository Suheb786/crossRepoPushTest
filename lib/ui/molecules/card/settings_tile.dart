import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../app_divider.dart';

class SettingTile extends StatelessWidget {
  final String tileIcon;
  final String? title;
  final Widget? trailing;
  final Function() onTap;
  final bool isEnabled;
  final bool isCardActivated;
  final isLastTile;
  final isNotify;

  const SettingTile(
      {Key? key,
      required this.tileIcon,
      required this.title,
      this.trailing,
      required this.onTap,
      this.isEnabled: true,
      this.isCardActivated: true,
      this.isNotify: false,
      this.isLastTile: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? (isCardActivated ? onTap : null) : null,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 26.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(children: [
                  AppSvg.asset(tileIcon,
                      height: 24.h,
                      width: 24.w,
                      color: isCardActivated
                          ? Theme.of(context).primaryColorDark
                          : Theme.of(context).inputDecorationTheme.hintStyle!.color),
                  Visibility(
                    visible: isNotify && isCardActivated,
                    child: PositionedDirectional(
                      end: 0,
                      top: 0,
                      child: Container(
                        width: 8.0.w,
                        height: 8.0.h,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.brightRed,
                            border: Border.all(width: 1, color: AppColor.white)),
                      ),
                    ),
                  )
                ]),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.0.w),
                    child: Text(
                      title!,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: isEnabled
                            ? (isCardActivated
                                ? Theme.of(context).primaryColorDark
                                : Theme.of(context).inputDecorationTheme.hintStyle!.color ?? AppColor.gray1)
                            : Theme.of(context).inputDecorationTheme.hintStyle!.color ?? AppColor.gray1,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0.w,
                      ),
                    ),
                  ),
                ),
                trailing ?? Container()
              ],
            ),
          ),
          AppDivider()
        ],
      ),
    );
  }
}
