import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RjBookingPurchasePageView extends BasePageViewWidget<RjBookingPurchasePageViewModel> {
  RjBookingPurchasePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {}
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(AssetUtils.line),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 111.37,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.vividYellow,
                      ),
                      child: Center(child: AppSvg.asset(AssetUtils.right)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 11.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.arguments.amount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 32),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8, left: 5.0),
                      child: Text(
                        S.of(context).JOD,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: AppColor.very_light_red,
                            fontWeight: FontWeight.w700,
                            fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Text(
                  S.of(context).purchaseFor,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 24, end: 24),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).rjFrom,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      S.of(context).aMM,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32),
                                    ),
                                    Text(
                                      S.of(context).jordan,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
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
                                      S.of(context).to,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                    Text(
                                      S.of(context).nRT,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 32),
                                    ),
                                    Text(
                                      S.of(context).japan,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        color: AppColor.light_grayish_violet,
                        height: 1,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 16),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).departOnForPurchasePage,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.gray5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 16),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).returnOnForPurchasePage,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.gray5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 16),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).purchaseDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).purchaseDummyDate,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                            Text(
                              S.of(context).purchaseDummyTime,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.gray5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 24, end: 24, top: 16, bottom: 24),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).refTitle,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                            Spacer(),
                            Text(
                              S.of(context).refNoDummyData,
                              style: TextStyle(
                                  fontFamily: StringUtils.appFont,
                                  color: AppColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 76),
                child: AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  borderColor: Theme.of(context).accentColor,
                  textColor: Theme.of(context).accentColor,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text(
                    S.of(context).toBookingSummary,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
