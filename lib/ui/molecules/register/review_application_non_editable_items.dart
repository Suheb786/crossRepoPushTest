import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ReviewApplicationNonEditableItem extends StatelessWidget {
  final String? title;
  final String? value;

  const ReviewApplicationNonEditableItem({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              title!,
              softWrap: true,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.very_dark_gray),
            ),
          ),
          Flexible(
            child: Text(
              value!,
              softWrap: true,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.dark_gray_1),
            ),
          ),
        ],
      ),
    );
  }
}
