import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/registerselection/register_selection_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/button/app_icon_button.dart';
import 'package:neo_bank/ui/molecules/register/notify_me_widget.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RegisterSelectionPageView extends BasePageViewWidget<RegisterSelectionViewModel> {
  RegisterSelectionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        if (!details.primaryDelta!.isNegative && details.primaryDelta != 0) {
          ProviderScope.containerOf(context)
              .read(onBoardingViewModelProvider)
              .onBoardingPageController
              .previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        }
      },
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 128.0.w, right: 128.0.w, bottom: 8.0.h, top: 44.0.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
              child: Container(
                height: 4.0.h,
                width: 128.0.w,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: AppColor.whiteGray),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ClampingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.only(top: 74.0.h),
                  width: 295.0.w,
                  child: Column(
                    children: [
                      Text(
                        S.of(context).letsCreateYourProfile,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 32.0.t,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 41.0.h),
                        child: NotifyMeWidget(
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.NonJordanianRegister);
                          },
                          title: S.of(context).accountOpeningDescription,
                          labelText: S.of(context).notifyMeExC,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 56.h),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutePaths.AccountRegistration,
                                arguments: AccountRegistrationParams());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context).textTheme.bodyMedium!.color!,
                            ),
                            child: Center(
                              child: Text(S.of(context).registerViaEmail,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                      color: Theme.of(context).colorScheme.secondary)),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: AppDivider(
                                  color: Theme.of(context).colorScheme.secondary,
                                  indent: 0,
                                  endIndent: 12.w,
                                ),
                              ),
                              Text(
                                S.of(context).orContinueWith,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    color: Theme.of(context).colorScheme.secondary,
                                    fontSize: 12.t),
                              ),
                              Expanded(
                                child: AppDivider(
                                  color: Theme.of(context).colorScheme.secondary,
                                  endIndent: 0,
                                  indent: 12.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: false,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: AppIconButton(
                                icon: AssetUtils.apple,
                                iconSize: 28,
                              )),
                              Container(width: 16.w),
                              Expanded(
                                child: AppIconButton(
                                  icon: AssetUtils.google,
                                  iconSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 25.h),
              child: Text(
                S.of(context).swipeDownToLogin,
                style: TextStyle(
                    fontFamily: StringUtils.appFont,
                    fontSize: 14.t,
                    color: Theme.of(context).colorScheme.secondary,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
