import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../ui/molecules/button/app_secondary_button.dart';

class CreditCardApplySuccessPageView extends BasePageViewWidget<CreditCardApplySuccessPageViewModel> {
  CreditCardApplySuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreditCardApplySuccessPageViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 92.h),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          AssetUtils.line,
                          color: AppColor.softRed,
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
                                child: AppSvg.asset(AssetUtils.right,
                                    color: Theme.of(context).primaryColorDark)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56.h,
                  ),
                  Text(
                    model.getTitle(context, model.creditCardApplySuccessArguments.creditSuccessState),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.t,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Text(
                      model.description(context, model.creditCardApplySuccessArguments.creditSuccessState),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.t,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                  child: AppSecondaryButton(
                    text: S.of(context).done,
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                      ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
