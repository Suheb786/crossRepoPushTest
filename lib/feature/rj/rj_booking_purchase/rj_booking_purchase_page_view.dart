import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../../../utils/color_utils.dart';

class RjBookingPurchasePageView extends BasePageViewWidget<RjBookingPurchasePageViewModel> {
  RjBookingPurchasePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          // Navigator.pushNamed(context, RoutePaths.RJBookingConfirmedInAppWebViewPage);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AssetUtils.line,
                    color: Theme.of(context).colorScheme.outlineVariant,
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Center(child: AppSvg.asset(AssetUtils.right)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 11.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // model.arguments.amount.toStringAsFixed(3),
                      "1,099.000",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 32.t),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h, left: 5.0.w),
                      child: Text(
                        S.of(context).JOD,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.silver_gray,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.t),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0.h),
                child: Text(
                  S.of(context).purchaseFor,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.t),
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 24.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).rjFrom,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                    Text(
                                      S.of(context).aMM,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32.t),
                                    ),
                                    Text(
                                      S.of(context).jordan,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).to.toUpperCase(),
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                    Text(
                                      S.of(context).nRT,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32.t),
                                    ),
                                    Text(
                                      S.of(context).japan,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: Theme.of(context).primaryColorDark,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.t),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.onTertiary,
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 16.h),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).departOnForPurchasePage,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 16.h),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).returnOnForPurchasePage,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 16.h),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).purchaseDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).colorScheme.inversePrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w, top: 16.h, bottom: 24.h),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).refTitle,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.t),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).refNoDummyData,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.t),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: EdgeInsets.only(top: 76.h),
              //   child: AnimatedButton(
              //     buttonText: S.of(context).swipeToProceed,
              //     borderColor: Theme.of(context).colorScheme.secondary,
              //     textColor: Theme.of(context).colorScheme.secondary,
              //   ),
              // ),
            ],
          ),
          Spacer(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 24..w, end: 24.w),
                  child: AppPrimaryButton(
                    text: S.of(context).done,
                    onPressed: () {},
                    activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                    textColor: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                SizedBox(
                  height: 56.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
