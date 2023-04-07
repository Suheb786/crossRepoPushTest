// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/credit_confirmation/credit_confirmation_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreditConfirmationPaymentActivityPageView
    extends BasePageViewWidget<CreditConfirmationPaymentActivityViewModel> {
  CreditConfirmationPaymentActivityPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Container(
        margin: EdgeInsets.only(top: 52.h),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24.0.w),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.gray_black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 80.0.w),
                  child: Text(
                    S.of(context).creditConfirmation,
                    style: TextStyle(
                        color: AppColor.gray_black,
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0.t),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 35.h),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                    child: Column(
                      children: [
                        SizedBox(height: 32.h),
                        Column(
                          children: [
                            Container(
                                height: 64.0.h,
                                width: 64.0.h,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                                child: Center(
                                  child: Text(
                                    model.creditConfirmationArgument.crediterDP ?? "",
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).accentColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0.t),
                                  ),
                                )),
                            SizedBox(height: 16.0.h),
                            RichText(
                              text: TextSpan(
                                text:
                                    "-${double.parse(model.creditConfirmationArgument.amount?.replaceAll('-', '') ?? '0.0').toStringAsFixed(3)}",
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 24.t,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.black),
                                children: [
                                  TextSpan(text: " "),
                                  TextSpan(
                                    text: S.of(context).JOD,
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 12.t,
                                        color: AppColor.light_gray,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 8.0.h),
                            Text(
                              model.creditConfirmationArgument.crediterName ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 20.t,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              model.creditConfirmationArgument.accountNo ?? "",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  fontSize: 12.t,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(height: 31.h),
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.transactionType,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      model.creditConfirmationArgument.transactionType ?? "",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.date,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      model.creditConfirmationArgument.date ?? "",
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.time,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      model.creditConfirmationArgument.time ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.current.refID,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      model.creditConfirmationArgument.refID ?? "",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 12.t,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            // SizedBox(height: 32.h),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColor.skyblue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 24.0.w,
                                vertical: 16.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).share,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      color: AppColor.white,
                                      fontSize: 12.0.t,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  AppSvg.asset(AssetUtils.share, height: 16.h, width: 16.h)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 56.h),
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
