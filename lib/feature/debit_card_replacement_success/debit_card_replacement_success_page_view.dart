import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/debit_card_replacement/debit_card_replacement_page.dart';
import 'package:neo_bank/feature/debit_card_replacement_success/debit_card_replacement_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/button/app_primary_button.dart';
import '../../main/navigation/route_paths.dart';

class DebitCardReplacementSuccessPageView
    extends BasePageViewWidget<DebitCardReplacementSuccessPageViewModel> {
  DebitCardReplacementSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, DebitCardReplacementSuccessPageViewModel model) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).canvasColor,
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
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Center(
                                child: AppSvg.asset(AssetUtils.right,
                                    color: Theme.of(context).colorScheme.secondary)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 34.7.h,
                  ),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).yourCardReady,
                          style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.w500,
                            fontSize: 24.t,
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 48.0.w),
                          child: Text(
                            S.of(context).youCanAddMoney,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.t,
                                color: Theme.of(context).textTheme.bodyMedium?.color),
                          ),
                        ),
                      ],
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
                  child: AppPrimaryButton(
                    text: S.of(context).backToDashboard,
                    onPressed: () {
                      if (model.debitCardReplacementArguments.type == DebitReplacementEnum.Normal) {
                        Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .showSettingPage(false);
                        ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                      } else {
                        Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .showSettingPage(false);
                        ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            )
          ],
        ));
  }
}
