import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_bill/paid_bills_success/paid_bills_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PaidBillsSuccessPageView
    extends BasePageViewWidget<PaidBillsSuccessPageViewModel> {
  PaidBillsSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PaidBillsSuccessPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop();
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 92.h,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AssetUtils.line,
                    color: AppColor.veryDarkGray1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Center(
                          child: AppSvg.asset(
                        AssetUtils.right,
                      )),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: '${double.parse(model.arguments.amt).toStringAsFixed(3)}',
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 32.0.t),
              ),
              TextSpan(
                text: S.of(context).JOD,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.gray5,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0.t),
              ),
            ])),
            Text(
              S.of(context).paidTo,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 24.0.t),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0.h, right: 24.w, left: 24.0.w),
              child: Card(
                  child: Padding(
                padding: EdgeInsetsDirectional.only(
                    start: 24.w, end: 24.w, top: 24.0.h, bottom: 24.0.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).billName,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.t),
                        ),
                        Text(
                          model.arguments.billName,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0.t),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).nickName,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.t),
                        ),
                        Text(
                          model.arguments.nickName,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0.t),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).refNo,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0.t),
                        ),
                        Text(
                          model.arguments.refNo,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              color: AppColor.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0.t),
                        )
                      ],
                    )
                  ],
                ),
              )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvg.asset(AssetUtils.share,
                      color: AppColor.light_acccent_blue),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    S.of(context).shareMyReceipt,
                    style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      color: AppColor.light_acccent_blue,
                      fontSize: 14.t,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 166.h,
            ),
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity!.isNegative) {
                  Navigator.of(context)
                    ..pop()
                    ..pop()
                    ..pop();
                }
              },
              child: AnimatedButton(
                buttonText: S.of(context).swipeToProceed,
                textColor: Theme.of(context).accentColor,
                borderColor: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 56.h,
              ),
              child: Center(
                child: Text(
                  S.of(context).toPayments,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.t,
                      color: AppColor.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
