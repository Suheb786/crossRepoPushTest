import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_videocall_verification/credit_card_videocall_complete/credit_card_videocall_complete_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';

class CreditCardVideoCallCompletePageView
    extends BasePageViewWidget<CreditCardVideoCallCompletePageViewModel> {
  CreditCardVideoCallCompletePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 56.0.h, start: 24.w, end: 24.w, bottom: 36.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).applyForCreditCard,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            S.of(context).verificationCallEnded,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20.t,
                color: Theme.of(context).colorScheme.secondary),
          ),
          SizedBox(
            height: 32.h,
          ),
          Expanded(
              child: Card(
            elevation: 10,
            shadowColor: Theme.of(context).primaryColorDark,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 35.0.h, bottom: 24.h),
                      child: Container(
                        // height: 78,
                        // width: 78,
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                        decoration: BoxDecoration(
                          color: AppColor.vividYellow,
                          shape: BoxShape.circle,
                        ),
                        child: AppSvg.asset(AssetUtils.ccAgent,
                            width: 32.w, height: 32.h, color: Theme.of(context).primaryColorDark),
                      ),
                    ),
                    Text(
                      S.of(context).verificationCallEndedDesc,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 20.t,
                          color: Theme.of(context).primaryColorDark),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
                  child: Center(
                    child: AppPrimaryButton(
                      text: S.of(context).next,
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                        ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
