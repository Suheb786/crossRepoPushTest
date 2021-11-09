import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/ui/molecules/profile/profile_item_view_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:flutter_switch/flutter_switch.dart';

class ProfileRowItem extends StatelessWidget {
  final String title;
  final ProviderBase providerBase;
  final Function(bool)? onToggle;
  final String activeText;
  final String inactiveText;

  const ProfileRowItem(
      {Key? key,
      required this.title,
      required this.activeText,
      required this.inactiveText,
      required this.providerBase,
      this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileItemViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.switchState,
          dataBuilder: (context, isActive) {
            return Container(
              padding: EdgeInsets.only(top: 12, bottom: 12),
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
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColor.text_color),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left:10.0),
                        child: FlutterSwitch(
                          value: isActive!,
                          onToggle: (value) {
                            model.updateState(value);
                          },
                          activeText: activeText,
                          activeTextColor: AppColor.vivid_orange,
                          activeSwitchBorder:
                              Border.all(color: AppColor.border_color),
                          activeTextFontWeight: FontWeight.w500,
                          showOnOff: true,
                          valueFontSize: 10,
                          activeToggleColor: AppColor.vivid_orange,
                          inactiveText: inactiveText,
                          inactiveToggleColor: AppColor.white,
                          inactiveTextFontWeight: FontWeight.w500,
                          inactiveSwitchBorder:
                              Border.all(color: AppColor.border_color),
                          activeColor: AppColor.dark_violet_4,
                          inactiveColor: AppColor.dark_violet_4,
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
