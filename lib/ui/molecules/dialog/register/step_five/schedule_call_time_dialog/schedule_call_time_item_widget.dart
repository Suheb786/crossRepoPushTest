import 'package:domain/model/account/available_time_slots.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ScheduleCallItemWidget extends StatelessWidget {
  final AvailableTimeSlots item;

  const ScheduleCallItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 23, start: 32, bottom: 21),
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.transparent),
      child: Text(
        '${item.slot}',
        softWrap: true,
        maxLines: 2,
        style: TextStyle(
            fontFamily: StringUtils.appFont,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: item.isSelected ? Theme.of(context).primaryColorDark : AppColor.gray),
      ),
    );
  }
}
