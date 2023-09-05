import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'apple_pay_success_and_error_page_view_model.dart';

class ApplePaySuccessAndErrorPageView extends BasePageViewWidget<ApplePaySuccessAndErrorPageViewModel> {
  ApplePaySuccessAndErrorPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ApplePaySuccessAndErrorPageViewModel model) {
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
                    padding: EdgeInsets.only(
                      top: 92.h,
                    ),
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
                                child: AppSvg.asset(model.arguments.successOrErrorIcon!,
                                    color: Theme.of(context).primaryColorDark)),
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                          child: Text(
                            model.arguments.title!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w500,
                                fontSize: 24.t,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0.w),
                          child: Text(
                            model.arguments.titleDescription!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                fontWeight: FontWeight.w400,
                                fontSize: 14.t,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                        ),
                        Visibility(
                          visible: model.arguments.isSuccess,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 24.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(AssetUtils.wifiPay,
                                      height: 60.h, color: Theme.of(context).colorScheme.secondary),
                                  SizedBox(
                                    width: 26.w,
                                  ),
                                  Image.asset(
                                    AssetUtils.applePayButtonS,
                                    height: 60.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
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
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.w),
                  child: AppPrimaryButton(
                    text: S.of(context).backToDashboard,
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName(RoutePaths.AppHome));
                      model.getAntelopCardsList();
                      if (model.arguments.isSuccess) {
                        ProviderScope.containerOf(context)
                            .read(appHomeViewModelProvider)
                            .showAnotherAppToApplePayPupUp(true);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
