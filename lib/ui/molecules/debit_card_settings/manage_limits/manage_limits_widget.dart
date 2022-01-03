import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ManageLimitsWidget extends StatelessWidget {
  final String title;
  final String maxAmount;
  final String amountSet;
  final Function(bool)? onToggle;
  final ProviderBase providerBase;

  const ManageLimitsWidget({
    Key? key,
    this.title: "",
    required this.providerBase,
    this.maxAmount: "",
    this.amountSet: "",
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ManageLimitsWidgetViewModel>(
      providerBase: providerBase,
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: false,
          stream: model!.switchValue,
          dataBuilder: (context, isActive) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 24),
                    child: Row(
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
                          activeColor: Theme.of(context)
                              .accentTextTheme
                              .bodyText1!
                              .color!,
                          inactiveColor: Theme.of(context).accentColor,
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isActive,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      color: Theme.of(context).backgroundColor,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).dailyLimit,
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                Text(
                                  S.of(context).maximumLimit(maxAmount),
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .hintStyle!
                                          .color,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                            Text(
                              '$amountSet JOD',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .accentTextTheme
                                      .bodyText1!
                                      .color,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
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
