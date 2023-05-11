// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:neo_bank/base/base_widget.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget_model.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ManageLimitsWidget extends StatelessWidget {
  final String title;
  final String maxAmount;
  final String amountSet;
  final bool isLast;
  final bool readOnly;
  final bool noToggle;
  final bool initialValue;
  final Function(bool)? onToggle;
  final ProviderBase providerBase;
  final Function(String value) onDone;
  final Function(String value) onChange;

  const ManageLimitsWidget({
    Key? key,
    this.title: "",
    required this.providerBase,
    this.isLast = false,
    this.maxAmount: "",
    this.amountSet: "",
    this.initialValue: true,
    this.noToggle: false,
    this.readOnly: false,
    required this.onToggle,
    required this.onDone,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ManageLimitsWidgetViewModel>(
      providerBase: providerBase,
      onModelReady: (model) {
        if (model.amountSet.isEmpty) {
          model.controller.text = amountSet;
        }

        model.error.listen((event) {
          _showTopError(
              ErrorParser.getLocalisedStringError(
                error: event,
                localisedHelper: S.of(context),
              ),
              context);
        });
      },
      builder: (context, model, widget) {
        return AppStreamBuilder<bool>(
          initialData: initialValue,
          stream: model!.switchValue,
          dataBuilder: (context, isActive) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
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
                                fontFamily: StringUtils.appFont,
                                color: noToggle
                                    ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                    : Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.t),
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        IgnorePointer(
                          ignoring: noToggle,
                          child: FlutterSwitch(
                            value: isActive!,
                            onToggle: (value) {
                              onToggle?.call(value);
                              model.updateSwitchValue(value);
                            },
                            width: 70.w,
                            height: 40.h,
                            padding: 8,
                            activeText: S.of(context).yes.toUpperCase(),
                            activeTextColor: AppColor.white,
                            inactiveTextColor: AppColor.darkGray,
                            activeTextFontWeight: FontWeight.w500,
                            showOnOff: true,
                            valueFontSize: 10.t,
                            activeToggleColor: AppColor.white,
                            inactiveText: S.of(context).no.toUpperCase(),
                            inactiveToggleColor: AppColor.lightGrayishMagenta,
                            inactiveTextFontWeight: FontWeight.w500,
                            inactiveSwitchBorder: Border.all(color: AppColor.gray_2),
                            activeColor: Theme.of(context).textTheme.bodyMedium!.color!,
                            inactiveColor: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isActive,
                    child: ClipRRect(
                      borderRadius: isLast
                          ? BorderRadius.vertical(bottom: Radius.circular(16))
                          : BorderRadius.vertical(),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 13.h),
                        color: Theme.of(context).backgroundColor,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).dailyLimit,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.t),
                                  ),
                                  Text(
                                    S.of(context).maximumLimit(maxAmount),
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).inputDecorationTheme.hintStyle!.color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.t),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: model.controller,
                                  textAlign: TextAlign.end,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                  ],
                                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                                  textInputAction: TextInputAction.done,
                                  readOnly: readOnly,
                                  cursorColor: Theme.of(context).textTheme.bodyMedium!.color!,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).textTheme.bodyMedium!.color!),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      isCollapsed: true,
                                      hintText: amountSet,
                                      suffixIconConstraints: BoxConstraints.tightForFinite(),
                                      suffixIcon: Padding(
                                        padding: EdgeInsetsDirectional.only(start: 5.0.w),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                            fontFamily: StringUtils.appFont,
                                            fontSize: 14.t,
                                            color: Theme.of(context).textTheme.bodyMedium!.color!,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      )),
                                  onChanged: (value) {
                                    if ((num.tryParse(maxAmount) ?? 0) < (num.tryParse(value) ?? 0)) {
                                      model.showErrorToast();
                                    }
                                    onChange.call(value);
                                  },
                                  onFieldSubmitted: (value) {
                                    if ((num.tryParse(maxAmount) ?? 0) < (num.tryParse(value) ?? 0)) {
                                      model.showErrorToast();
                                    }
                                    onDone.call(value);
                                  },
                                ),
                              ),
                            ],
                          ),
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

  _showTopError(String message, BuildContext context) {
    showTopSnackBar(
        Overlay.of(context)!,
        Material(
          color: AppColor.white.withOpacity(0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
              decoration: BoxDecoration(color: AppColor.dark_brown, borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).error,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.light_grayish_violet,
                              fontWeight: FontWeight.w400,
                              fontSize: 10.0.t),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4.0.h, right: 16.0.w),
                          child: Text(message,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  // fontFamily: "Montserrat",
                                  color: AppColor.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0.t)),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.close,
                    size: 16,
                  )
                ],
              ),
            ),
          ),
        ),
        displayDuration: Duration(milliseconds: 1500),
        animationDuration: Duration(milliseconds: 500),
        reverseAnimationDuration: Duration(milliseconds: 700));
  }
}
