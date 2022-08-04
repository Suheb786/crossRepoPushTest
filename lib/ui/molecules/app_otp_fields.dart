import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/color_utils.dart';

class AppOtpFields extends StatelessWidget {
  final Function(String)? onCompleted;
  final Function(String)? onChanged;
  final int? length;
  final TextEditingController? controller;
  final double? fieldHeight;
  final double? fieldWidth;
  final Color? selectedFillColor;
  final bool? autoFocus;

  const AppOtpFields(
      {Key? key,
      @required this.length,
      this.fieldHeight: 50,
      this.fieldWidth: 35,
      this.onCompleted,
      this.controller,
      this.onChanged,
      this.selectedFillColor,
      this.autoFocus: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: PinCodeTextField(
          appContext: context,
          length: length!,
          autoFocus: autoFocus!,
          onChanged: (value) {
            onChanged?.call(value);
          },
          onCompleted: (value) {
            onCompleted?.call(value);
          },
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
          controller: controller,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.phone,
          blinkWhenObscuring: true,
          errorTextSpace: 20,
          useHapticFeedback: true,
          showCursor: false,
          pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              fieldHeight: fieldHeight,
              fieldWidth: fieldWidth,
              selectedFillColor: selectedFillColor,
              activeFillColor: AppColor.white,
              inactiveColor: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
              borderWidth: 1,
              disabledColor: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
              borderRadius: BorderRadius.circular(8),
              activeColor: Theme.of(context).inputDecorationTheme.enabledBorder!.borderSide.color,
              selectedColor: Theme.of(context).inputDecorationTheme.focusedBorder!.borderSide.color),
          obscureText: true,
          obscuringWidget: Container(
            height: 18.92,
            width: 6.62,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          textStyle: TextStyle(
              fontFamily: StringUtils.appFont,
              // color: AppColor.very_pale_blue,
              fontWeight: FontWeight.w600,
              fontSize: 19),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
