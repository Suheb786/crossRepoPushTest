import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';

class TaxationSwitchWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(bool) onToggle;
  final ProviderBase providerBase;

  const TaxationSwitchWidget(
      {Key? key,
      this.title: "",
      required this.providerBase,
      this.hintText: "",
      required this.onToggle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<TaxationSwitchWidgetViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.switchValue,
          dataBuilder: (context, isActive) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          title,
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
                      FlutterSwitch(
                        value: isActive!,
                        onToggle: (value) {
                          onToggle.call(value);
                          model.updateSwitchValue(value);
                        },
                        activeText: S.of(context).yes,
                        activeTextColor: AppColor.vivid_orange,
                        activeTextFontWeight: FontWeight.w700,
                        activeToggleColor: AppColor.vivid_orange,
                        inactiveTextColor: AppColor.white,
                        showOnOff: true,
                        valueFontSize: 10,
                        switchBorder: Border.all(
                            color: AppColor.mostly_desaturated_dark_violet),
                        inactiveText: S.of(context).no,
                        inactiveTextFontWeight: FontWeight.w500,
                        activeColor: AppColor.dark_violet_4,
                        inactiveColor: AppColor.dark_violet_4,
                      ),
                    ],
                  ),
                  Text(
                    hintText,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: AppColor.very_light_gray_white,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
