import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/notify_success/notify_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class NotifySuccessPageView extends BasePageViewWidget<NotifySuccessPageViewModel> {
  NotifySuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, NotifySuccessPageViewModel model) {
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
                        Image.asset(AssetUtils.line),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 111.37.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.vividYellow,
                            ),
                            child: Center(child: AppSvg.asset(AssetUtils.right)),
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
                          S.of(context).awesome,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 24.t,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          S.of(context).thankYouForInterestWillSendUpdate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.t,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(16)),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child:
                        AccountDetails(title: S.of(context).refTitle, value: model.arguments.referenceNo),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppPrimaryButton(
                    text: S.of(context).swipeToProceed,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, RoutePaths.OnBoarding, (route) => false);
                    },
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 32.h,
                  ),
                  child: Center(
                    child: Text(
                      S.of(context).toWelcomePage,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.t,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
