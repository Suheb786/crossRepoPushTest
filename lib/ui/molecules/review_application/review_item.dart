import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ReviewApplicationEditableItem extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? prefixWidget;
  final TextInputType? textInputType;

  const ReviewApplicationEditableItem(
      {Key? key,
      required this.title,
      this.initialValue,
      this.textInputType,
      this.prefixWidget,
      this.controller})
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
              controller: controller,
              initialValue: initialValue,
              maxLines: 2,
              textAlign: TextAlign.end,
              keyboardType: textInputType,
              cursorColor: Theme.of(context).primaryColorDark,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColorDark),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintText: '',
                  prefixIconConstraints: BoxConstraints.tightForFinite(),
                  prefixIcon: this.prefixWidget),
            ),
          ),
        ],
      ),
    );
  }
}
