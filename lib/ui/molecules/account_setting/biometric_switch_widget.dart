import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class BiometricSwitchWidget extends StatelessWidget {
  final String? image;
  final String? title;
  final String? subtitle;
  final Function()? onTap;
  final bool? isActive;
  final Function(bool)? onToggle;
  final String? activeText;
  final String? inActiveText;

  const BiometricSwitchWidget(
      {Key? key,
      this.image,
      this.title,
      this.subtitle: '',
      this.onTap,
      this.isActive: false,
      this.inActiveText,
      this.onToggle,
      this.activeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppSvg.asset(AssetUtils.email),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
              subtitle!.isNotEmpty
                  ? Text(
                      subtitle ?? '',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColor.gray),
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          width: 16,
        ),
        FlutterSwitch(
          value: isActive!,
          onToggle: (value) {
            onToggle?.call(value);
          },
          width: 70,
          height: 40,
          padding: 8,
          activeText: activeText,
          activeTextColor: AppColor.white,
          inactiveTextColor: AppColor.darkGray,
          activeTextFontWeight: FontWeight.w500,
          showOnOff: true,
          valueFontSize: 10,
          activeToggleColor: AppColor.white,
          inactiveText: inActiveText!,
          inactiveToggleColor: AppColor.lightGrayishMagenta,
          inactiveTextFontWeight: FontWeight.w500,
          inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
          activeColor: Theme.of(context).accentTextTheme.bodyText1!.color!,
          inactiveColor: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
