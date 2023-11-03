import 'package:domain/constants/enum/flight_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_confirmed_in_app_web_view/rj_booking_confirmed_in_app_web_view_page.dart';
import 'package:neo_bank/feature/rj/rj_booking_purchase/rj_booking_purchase_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../../../utils/color_utils.dart';

class RjBookingPurchasePageView extends BasePageViewWidget<RjBookingPurchasePageViewModel> {
  RjBookingPurchasePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
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
              padding: EdgeInsets.only(top: 24.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    double.parse(
                            model.arguments.flightDetailResponse.flightDetailContent?.paymentAmount ?? '-')
                        .toStringAsFixed(3),
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
                                    model.arguments.flightDetailResponse.flightDetailContent
                                            ?.flightDetails?[0].origin ??
                                        '',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.t),
                                  ),
                                  Text(
                                    "-",
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
                                    model.arguments.flightDetailResponse.flightDetailContent
                                            ?.flightDetails?[0].destination ??
                                        '',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32.t),
                                  ),
                                  Text(
                                    "-",
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
                            S.of(context).cabinClass,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.t),
                          ),
                          Spacer(),
                          Text(
                            '-',
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
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
                            S.of(context).departOnForPurchasePage,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.t),
                          ),
                          Spacer(),
                          Text(
                            (model.arguments.flightDetailResponse.flightDetailContent?.flightDetails?[0]
                                            .flightDate ??
                                        '')
                                    .isNotEmpty
                                ? TimeUtils.getFormattedDateForCreditCard(model.arguments.flightDetailResponse
                                        .flightDetailContent?.flightDetails?[0].flightDate ??
                                    '')
                                : '-',
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.t),
                          ),
                          Text(
                            (model.arguments.flightDetailResponse.flightDetailContent?.flightDetails?[0]
                                            .flightDate ??
                                        '')
                                    .isNotEmpty
                                ? ' - ${TimeUtils.getFormattedTimeForTransaction(model.arguments.flightDetailResponse.flightDetailContent?.flightDetails?[0].flightDate ?? '')}'
                                : '-',
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).colorScheme.inversePrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.t),
                          ),
                        ],
                      ),
                    ),
                    (model.arguments.flightDetailResponse.flightDetailContent?.flightDetails ?? []).length > 1
                        ? Visibility(
                            visible: model.arguments.flightDetailResponse.flightDetailContent?.flightType ==
                                FlightTypeEnum.RoundTrip,
                            child: Padding(
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
                                    (model.arguments.flightDetailResponse.flightDetailContent
                                                    ?.flightDetails?[1].flightDate ??
                                                '')
                                            .isNotEmpty
                                        ? TimeUtils.getFormattedDateForCreditCard(model
                                                .arguments
                                                .flightDetailResponse
                                                .flightDetailContent
                                                ?.flightDetails?[1]
                                                .flightDate ??
                                            '')
                                        : '-',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).primaryColorDark,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.t),
                                  ),
                                  Text(
                                    (model.arguments.flightDetailResponse.flightDetailContent
                                                    ?.flightDetails?[1].flightDate ??
                                                '')
                                            .isNotEmpty
                                        ? ' - ${TimeUtils.getFormattedTimeForTransaction(model.arguments.flightDetailResponse.flightDetailContent?.flightDetails?[1].flightDate ?? '')}'
                                        : '-',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        color: Theme.of(context).colorScheme.inversePrimary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.t),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
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
                            TimeUtils.getFormattedDateForCreditCard(DateTime.now().toString()),
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.t),
                          ),
                          Text(
                            ' - ${TimeUtils.getFormattedDateForCreditCard(DateTime.now().toString())}',
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
                            S.of(context).bookingRefNo,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.w400,
                                fontSize: 12.t),
                          ),
                          Spacer(),
                          Text(
                            model.arguments.flightDetailResponse.flightDetailContent?.requestReference ?? '-',
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
          ],
        ),
        Spacer(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                child: AppPrimaryButton(
                  text: S.of(context).done,
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, RoutePaths.RJBookingConfirmedInAppWebViewPage,
                        arguments: RJBookingConfirmedInAppWebViewPageArguments(
                            url: model.arguments.flightDetailResponse.flightDetailContent?.confirmationUrl ??
                                ''));
                  },
                  activeBackgroundColor: Theme.of(context).colorScheme.secondary,
                  textColor: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
            ],
          ),
        )
      ],
    );
  }
}
