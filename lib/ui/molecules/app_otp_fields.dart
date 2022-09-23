import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
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
      this.fieldHeight,
      this.fieldWidth,
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
          enablePinAutofill: false,
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
              fieldHeight: fieldHeight ?? 50.0.h,
              fieldWidth: fieldWidth ?? 35.0.w,
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
            height: 18.92.h,
            width: 6.62.w,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          textStyle: TextStyle(
              fontFamily: StringUtils.appFont,
              // color: AppColor.very_pale_blue,
              fontWeight: FontWeight.w600,
              fontSize: 19.0.t),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}
