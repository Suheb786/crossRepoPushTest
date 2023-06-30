import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class NumberFormattingWidget extends StatelessWidget {
  final String title;
  final String desc;

  const NumberFormattingWidget({Key? key, this.title = '', this.desc = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 2.w,
          height: 2.w,
          margin: EdgeInsets.only(top: 5.h),
          decoration: BoxDecoration(
            color: AppColor.veryDarkGray1,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontSize: 14.t,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                desc,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.surface),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
