import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewApplicationItem extends StatelessWidget {
  final String title;
  final String details;

  const ReviewApplicationItem(
      {Key? key,
        required this.title,
        required this.details})
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
                  color: AppColor.gray),
            ),
          ),
          Flexible(
            child: Text(
              details,
              softWrap: true,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColor.gray_black),
            ),
          ),
        ],
      ),
    );
  }
}
