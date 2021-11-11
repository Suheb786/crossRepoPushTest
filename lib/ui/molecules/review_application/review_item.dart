import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewApplicationItem extends StatelessWidget {
  final String title;
  final String details;

  const ReviewApplicationItem(
      {Key? key, required this.title, required this.details})
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
              title,
              softWrap: true,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.very_dark_gray),
            ),
          ),
          Flexible(
            child: TextFormField(
              initialValue: details,
              maxLines: 2,
              textAlign: TextAlign.end,
              cursorColor: AppColor.dark_violet2,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.dark_violet2),
              decoration: InputDecoration.collapsed(
                border: InputBorder.none,
                hintText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
