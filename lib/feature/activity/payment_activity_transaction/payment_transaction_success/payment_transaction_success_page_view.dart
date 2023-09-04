// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/activity/payment_activity_transaction/payment_transaction_success/payment_transaction_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class PaymentTransationSuccessPageView extends BasePageViewWidget<PaymentTransationSuccessPageViewModel> {
  PaymentTransationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
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
                  double.parse(model.paymentTransationSuccessArgument.ammount ?? '0.0').toStringAsFixed(3),
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
              model.paymentTransationSuccessArgument.statusInfo ?? "",
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
              model.paymentTransationSuccessArgument.name ?? "",
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
              model.paymentTransationSuccessArgument.iban ?? "",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: StringUtils.appFont,
                  color: AppColor.gray_black,
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0.t),
            ),
          ),
          Visibility(
            visible: false,
            child: Padding(
              padding: EdgeInsets.only(top: 23.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSvg.asset(AssetUtils.share, color: Theme.of(context).textTheme.bodyLarge!.color!),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 11.0.w),
                    child: Text(
                      S.of(context).shareMyReceipt,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0.t,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(top: 76, left: 24.w, right: 24.w, bottom: 24.h),
            child: AppPrimaryButton(
              text: S.of(context).done,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
              },
            ),
          ),
        ],
      ),
    );
  }
}
