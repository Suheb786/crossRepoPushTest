import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/ui/molecules/profile/profile_item_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ProfileRowItem extends StatelessWidget {
  final String title;
  final ProviderBase providerBase;
  final Function(bool)? onToggle;
  final String activeText;
  final bool initialValue;
  final Color labelColor;
  final String inactiveText;

  const ProfileRowItem(
      {Key? key,
      required this.title,
      required this.activeText,
      required this.inactiveText,
      required this.initialValue,
      required this.providerBase,
      this.labelColor: AppColor.text_color,
      this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileItemViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: initialValue,
          stream: model!.switchState,
          dataBuilder: (context, isActive) {
            return Container(
              padding: EdgeInsets.only(top: 12.0.h, bottom: 12.0.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.0.t,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryTextTheme.bodyText1!.color!,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.0.w),
                        child: FlutterSwitch(
                          value: isActive!,
                          onToggle: (value) {
                            model.updateState(value);
                          },
                          width: 70.0.w,
                          height: 40.0.h,
                          padding: 8,
                          activeText: activeText,
                          activeTextColor: AppColor.white,
                          inactiveTextColor: AppColor.darkGray,
                          activeTextFontWeight: FontWeight.w500,
                          showOnOff: true,
                          valueFontSize: 10.0.t,
                          activeToggleColor: AppColor.white,
                          inactiveText: inactiveText,
                          inactiveToggleColor: AppColor.lightGrayishMagenta,
                          inactiveTextFontWeight: FontWeight.w500,
                          inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
                          activeColor: Theme.of(context).accentTextTheme.bodyText1!.color!,
                          inactiveColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  onToggle?.call(isActive)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
