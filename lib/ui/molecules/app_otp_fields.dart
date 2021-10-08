import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  const AppOtpFields(
      {Key? key,
      @required this.length,
      this.fieldHeight: 52,
      this.fieldWidth: 39.72,
      this.onCompleted,
      this.controller,
      this.onChanged,
      this.selectedFillColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PinCodeTextField(
        appContext: context,
        length: length!,
        onChanged: (value) {
          onChanged?.call(value);
        },
        onCompleted: (value) {
          onCompleted?.call(value);
        },
        controller: controller,
        animationType: AnimationType.fade,
        keyboardType: TextInputType.number,
        blinkWhenObscuring: true,
        errorTextSpace: 20,
        showCursor: false,
        pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: fieldHeight,
            fieldWidth: fieldWidth,
            selectedFillColor: selectedFillColor,
            activeFillColor: AppColor.white,
            inactiveColor: AppColor.very_pale_blue.withOpacity(0.4),
            borderWidth: 1,
            disabledColor: AppColor.very_pale_blue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(8),
            activeColor: AppColor.very_pale_blue,
            selectedColor: AppColor.very_pale_blue),
        obscureText: true,
        obscuringWidget: Container(
          height: 18.92,
          width: 6.62,
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: AppColor.very_pale_blue),
        ),
        textStyle: TextStyle(
            color: AppColor.very_pale_blue,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            fontSize: 19),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
