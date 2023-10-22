import 'package:domain/model/rj/destinations.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ToSelectedCountryListWidget extends StatelessWidget {
  final Destinations item;

  const ToSelectedCountryListWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 24.0.w, end: 20.0.w, top: 20.0.h, bottom: 20.0.h),
      margin: EdgeInsets.symmetric(horizontal: 16.0.w),
      alignment: AlignmentDirectional.centerStart,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Text(
        item.airportName ?? '',
        softWrap: true,
        maxLines: 2,
        style: TextStyle(
            fontFamily: StringUtils.appFont,
            fontSize: 14.t,
            fontWeight: FontWeight.w400,
            color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.gray),
      ),
    );
  }
}
