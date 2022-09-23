import 'package:domain/model/account/available_time_slots.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ScheduleCallItemWidget extends StatelessWidget {
  final AvailableTimeSlots item;

  const ScheduleCallItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(top: 23.h, start: 32.w, bottom: 21.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 64,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.w), color: Colors.transparent),
      child: Text(
        '${item.slot}',
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
