import 'package:flutter/cupertino.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppSwitchLabelWidget extends StatelessWidget {
  final String? label;
  final bool? isActive;
  final Function(bool)? onToggle;
  final String? activeText;
  final String? inActiveText;

  const AppSwitchLabelWidget(
      {Key? key,
      this.onToggle,
      this.label,
      this.isActive,
      this.activeText,
      this.inActiveText})
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
                fontFamily: "Montserrat",
                color: AppColor.very_light_gray_white,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ),
        SizedBox(width: 16,),
        FlutterSwitch(
          value: isActive!,
          onToggle: (value) {
            onToggle?.call(value);
          },
          activeText: activeText,
          activeTextColor: AppColor.vivid_orange,
          activeTextFontWeight: FontWeight.w700,
          activeToggleColor: AppColor.vivid_orange,
          inactiveTextColor: AppColor.white,
          showOnOff: true,
          valueFontSize: 10,
          switchBorder:
              Border.all(color: AppColor.mostly_desaturated_dark_violet),
          inactiveText: inActiveText,
          inactiveTextFontWeight: FontWeight.w500,
          activeColor: AppColor.dark_violet_4,
          inactiveColor: AppColor.dark_violet_4,
        ),
      ],
    );
  }
}
