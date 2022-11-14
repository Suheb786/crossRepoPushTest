import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PrePaidBillCardWidget extends StatelessWidget {
  const PrePaidBillCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Container(
            color: Theme.of(context).primaryColorDark,
            child: Padding(
              padding: EdgeInsets.only(top: 32.0.h, left: 24.0.w, right: 24.0.w, bottom: 40.0.h),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(S.of(context).myPrePaidBills,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 12.0.t,
                            fontWeight: FontWeight.w600,
                            color: AppColor.white)),
                  ),
                  SizedBox(
                    height: 72.h,
                  ),
                  Container(
                    color: Colors.yellow,
                    height: 112.h,
                    width: 112.w,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(S.of(context).howWouldLikeToPayPrePaidYourBills,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.0.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white)),
                  SizedBox(
                    height: 40.h,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: AppColor.white_gray),
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          S.of(context).viewMyBills,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  InkWell(
                    onTap: () {
                      //
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 17.0.h),
                      decoration:
                          BoxDecoration(color: AppColor.brightBlue, borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          S.of(context).payAllBills,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 14.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
