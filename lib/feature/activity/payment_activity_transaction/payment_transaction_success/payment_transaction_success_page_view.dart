// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class PaymentTransationSuccessPageView extends BasePageViewWidget<PaymentTransationSuccessPageViewModel> {
  PaymentTransationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          // Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
          // ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();

        }
      },
      child: Padding(
        padding: EdgeInsets.only(top: 92.0.h),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AppSvg.asset(AssetUtils.line_white),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 111.37.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.brightRed,
                    ),
                    child: Center(child: AppSvg.asset(AssetUtils.right, color: AppColor.white)),
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
                    "10.000",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: AppColor.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 28.0.t),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, left: 5.0.w),
                    child: Text(
                      S.of(context).JOD,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: AppColor.gray_black,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0.t),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 6.0.h),
              child: Text(
                S.of(context).sentTo,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 24.0.t),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0.h),
              child: Text(
                "Shakila Naseem",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0.t),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.0.h),
              child: Text(
                "EFBKI000012341234123819241213",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    color: AppColor.gray_black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0.t),
              ),
            ),
            Visibility(
              visible: true,
              child: Padding(
                padding: EdgeInsets.only(top: 23.0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppSvg.asset(AssetUtils.share, color: Theme.of(context).accentTextTheme.bodyText1!.color),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 11.0.w),
                      child: Text(
                        S.of(context).shareMyReceipt,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.t,
                            color: Theme.of(context).accentTextTheme.bodyText1!.color),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(top: 76),
              child: AnimatedButton(
                buttonText: S.of(context).swipeToProceed,
                borderColor: Theme.of(context).colorScheme.secondary,
                textColor: Theme.of(context).colorScheme.secondary,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(top: 9.0.h),
                child: Text(
                  S.of(context).toDashboard,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 12.0.t,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Visibility(
              visible: false,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 33.0.h),
                    child: Text(
                      S.of(context).undoTransaction,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.0.t,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentTextTheme.bodyText1!.color),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4.0.h),
                    child: Text(
                      "0:07",
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 14.0.t,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40.0.h,
            )
          ],
        ),
      ),
    );
  }
}
