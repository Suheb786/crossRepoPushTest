import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page.dart';
import 'package:neo_bank/feature/onboarding/registerselection/register_selection_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/register/notify_me_widget.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RegisterSelectionPageView extends BasePageViewWidget<RegisterSelectionViewModel> {
  RegisterSelectionPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(top: 128.0.h, left: 40.w, right: 40.w, bottom: 64.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
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
                margin: EdgeInsets.only(top: 40.0.h),
                child: NotifyMeWidget(
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.NonJordanianRegister);
                  },
                  title: S.of(context).accountOpeningDescription,
                  labelText: S.of(context).notifyMeExC,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.h),
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
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                    child: Center(
                      child: Text(S.of(context).openYourAccountNow,
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
              SizedBox(
                height: 34,
              ),
              GestureDetector(
                onTap: () {
                  ProviderScope.containerOf(context)
                      .read(onBoardingViewModelProvider)
                      .onBoardingPageController
                      .previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                },
                child: Text(
                  S.of(context).goBack,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.t,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
