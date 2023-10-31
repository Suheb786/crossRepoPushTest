import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_registration/failure_scenarios/failure_scenarios_page_view_model.dart';
import 'package:neo_bank/ui/molecules/button/app_secondary_button.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../generated/l10n.dart';
import '../../../main/navigation/route_paths.dart';
import '../../../ui/molecules/app_svg.dart';
import '../../../utils/asset_utils.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/string_utils.dart';

class OnboardingFailureScenariosPageView extends BasePageViewWidget<OnboardingFailureScenariosPageViewModel> {
  OnboardingFailureScenariosPageView({
    required ProviderBase model,
  }) : super(model);

  @override
  Widget build(BuildContext context, OnboardingFailureScenariosPageViewModel model) {
    return Padding(
      padding: EdgeInsets.only(top: 92.h),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          AssetUtils.line,
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                          fit: BoxFit.contain,
                        ),
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
                              child:
                                  AppSvg.asset(AssetUtils.cancel, color: Theme.of(context).primaryColorDark)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.only(top: 47.h, start: 24.w),
                      child: Text(
                        model.argument.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 24.t,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      )),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 24.h, start: 24.w, end: 24.w),
                    child: Text(
                      model.argument.description,
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
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 24.w, vertical: 56.0.h),
            child: AppSecondaryButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
              },
              text: S.current.okay,
            ),
          )
        ],
      ),
    );
  }
}
