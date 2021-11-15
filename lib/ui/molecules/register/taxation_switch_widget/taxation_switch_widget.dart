import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final Function(bool)? onToggle;
  final ProviderBase providerBase;
  final Function? onSecondaryTextTap;
  final String? secondaryText;

  const TaxationSwitchWidget(
      {Key? key,
      this.title: "",
      required this.providerBase,
      this.hintText: "",
      required this.onToggle,
      this.onSecondaryTextTap,
      this.secondaryText: ""})
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
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      FlutterSwitch(
                        value: isActive!,
                        onToggle: (value) {
                          onToggle?.call(value);
                          model.updateSwitchValue(value);
                        },
                        width: 70,
                        height: 40,
                        padding: 8,
                        activeText: S.of(context).yes,
                        activeTextColor: AppColor.white,
                        inactiveTextColor: AppColor.darkGray,
                        activeTextFontWeight: FontWeight.w500,
                        showOnOff: true,
                        valueFontSize: 10,
                        activeToggleColor: AppColor.white,
                        inactiveText: S.of(context).no,
                        inactiveToggleColor: AppColor.lightGrayishMagenta,
                        inactiveTextFontWeight: FontWeight.w500,
                        inactiveSwitchBorder:
                            Border.all(color: AppColor.gray_2),
                        activeColor:
                            Theme.of(context).accentTextTheme.bodyText1!.color!,
                        inactiveColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: secondaryText!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                          onTap: () {
                            onSecondaryTextTap?.call();
                          },
                          child: Text(
                            secondaryText!,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .accentTextTheme
                                    .bodyText1!
                                    .color,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  Visibility(
                    visible: secondaryText!.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: InkWell(
                          onTap: () {
                            onSecondaryTextTap?.call();
                          },
                          child: Text(
                            secondaryText!,
                            style: TextStyle(
                                color: AppColor.vivid_orange,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ),
                  Text(
                    hintText,
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
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
