import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaymentScrollWheelWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final Function? onTap;

  const PaymentScrollWheelWidget(
      {Key? key, required this.label, this.onTap, this.textColor, this.widgetColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0.w),
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: widgetColor),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 32.0.w, end: 32.w),
            child: Text(
              label,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: textColor,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
