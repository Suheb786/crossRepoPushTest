import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_verification_success/debit_card_verification_success_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

class DebitCardVerificationSuccessPageView extends BasePageViewWidget<DebitCardVerificationSuccessViewModel> {
  DebitCardVerificationSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop();
            ProviderScope.containerOf(context).read(appHomeViewModelProvider).getDashboardData();
          }
        },
        child: Padding(
          padding: EdgeInsets.only(top: 92.0.h),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    AssetUtils.line,
                    color: Theme.of(context).colorScheme.secondary,
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
                          child: AppSvg.asset(
                        AssetUtils.right,
                      )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 34.0.h),
                child: Text(
                  S.of(context).debitCardVerified,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w800, fontSize: 24.t),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0.h),
                child: Text(
                  S.of(context).physicalCardUse,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontFamily: StringUtils.appFont, fontWeight: FontWeight.w500, fontSize: 16.t),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: AnimatedButton(
                  buttonText: S.of(context).swipeToProceed,
                  borderColor: Theme.of(context).primaryColorDark,
                  textColor: Theme.of(context).primaryColorDark,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 9.h),
                  child: Text(
                    S.of(context).toDashboard,
                    style: TextStyle(
                        fontFamily: StringUtils.appFont, fontSize: 12.t, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
