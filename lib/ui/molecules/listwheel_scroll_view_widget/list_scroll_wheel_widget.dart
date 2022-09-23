import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ListScrollWheelListWidget extends StatelessWidget {
  final Color? textColor;
  final Color? widgetColor;
  final String label;
  final Function? onTap;

  const ListScrollWheelListWidget(
      {Key? key, required this.label, this.onTap, this.textColor, this.widgetColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        padding: EdgeInsetsDirectional.only(top: 23.0.h, start: 32.0.w, bottom: 21.0.h),
        margin: EdgeInsets.symmetric(horizontal: 16.0.w),
        height: 64.0.h,
        width: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: widgetColor),
        child: Text(
          label,
          style: TextStyle(
              fontFamily: StringUtils.appFont,
              color: textColor,
              fontSize: 14.0.t,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
