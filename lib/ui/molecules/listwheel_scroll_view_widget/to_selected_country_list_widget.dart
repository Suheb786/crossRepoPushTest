import 'package:domain/model/rj/destinations.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ToSelectedCountryListWidget extends StatelessWidget {
  final Destinations item;

  const ToSelectedCountryListWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsetsDirectional.only(start: 24, end: 20, top: 20, bottom: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                item.name ?? '',
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.gray),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
