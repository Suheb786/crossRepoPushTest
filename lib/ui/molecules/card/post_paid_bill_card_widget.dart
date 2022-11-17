import 'dart:ui';

import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pall_all_postpaid_bills_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PostPaidBillCardWidget extends StatelessWidget {
  const PostPaidBillCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
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
                  padding: EdgeInsets.only(top: 32.0.h, left: 24.0.w, right: 24.0.w, bottom: 38.0.h),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(S.of(context).myPostPaidBill,
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
                        height: 112.h,
                        width: 112.w,
                        child: AppSvg.asset(AssetUtils.logoeFawateerRed ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(/*S.of(context).howWouldLikeToPayYourBills*/"How would you like to\npay your postpaid bills?",
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
                          Navigator.pushNamed(context, RoutePaths.PayAllPostPaidBillsPage,
                              arguments:
                              PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS));
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
                          Navigator.pushNamed(context, RoutePaths.PayAllPostPaidBillsPage,
                              arguments:
                              PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.PAYALLBILLS));
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
        ),
        Positioned(
          bottom: 0,
          child: Column(
            children: [
              AppSvg.asset(AssetUtils.swipeUp),
              Padding(
                padding: EdgeInsets.only(top: 6.0.h),
                child: Text(
                  "Swipe up to pay new bill",
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0.t,
                      color: AppColor.dark_gray_1),
                ),
              )
            ],
          ),
        )

      ],

    );
  }
}
