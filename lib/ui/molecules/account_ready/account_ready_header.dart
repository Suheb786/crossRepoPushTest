import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class AccountReadyHeader extends StatelessWidget {
  final String? title;
  final String? subTitle;

  AccountReadyHeader({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(title!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: Theme.of(context).accentColor,
                    fontSize: 24.t,
                    fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0.w),
            child: Text(
              subTitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  fontWeight: FontWeight.w400,
                  fontSize: 14.t,
                  color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
    );
  }
}
