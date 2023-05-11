import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AppSwitchLabelWidget extends StatelessWidget {
  final String? label;
  final bool? isActive;
  final Function(bool)? onToggle;
  final String? activeText;
  final String? inActiveText;

  const AppSwitchLabelWidget(
      {Key? key, this.onToggle, this.label, this.isActive, this.activeText, this.inActiveText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label!,
            maxLines: 5,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.w600,
                fontSize: 14.t),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        FlutterSwitch(
          value: isActive!,
          onToggle: (value) {
            onToggle?.call(value);
          },
          width: 70.w,
          height: 40.h,
          padding: 8,
          activeText: activeText,
          activeTextColor: AppColor.white,
          inactiveTextColor: AppColor.darkGray,
          activeTextFontWeight: FontWeight.w500,
          showOnOff: true,
          valueFontSize: 10.t,
          activeToggleColor: AppColor.white,
          inactiveText: inActiveText!,
          inactiveToggleColor: AppColor.lightGrayishMagenta,
          inactiveTextFontWeight: FontWeight.w500,
          inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
          activeColor: Theme.of(context).textTheme.bodyMedium!.color!,
          inactiveColor: Theme.of(context).colorScheme.secondary,
        ),
      ],
    );
  }
}
