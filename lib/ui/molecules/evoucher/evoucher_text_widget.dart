import 'package:flutter/cupertino.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class EVoucherTextWidget extends StatelessWidget {
  const EVoucherTextWidget(
      {Key? key,
      required this.alignment,
      required this.textSize,
      required this.textWeight,
      required this.text,
      required this.textColor})
      : super(key: key);
  final AlignmentDirectional alignment;
  final double textSize;
  final FontWeight textWeight;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 24.w),
      child: Align(
          alignment: this.alignment,
          child: Text(
            text,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                color: textColor,
                fontSize: textSize,
                fontWeight: textWeight),
          )),
    );
  }
}
