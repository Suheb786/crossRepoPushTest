import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_ready_header.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AccountReadyView extends BasePageViewWidget<AccountReadyViewModel> {
  AccountReadyView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountReadyViewModel model) {
    return AppKeyBoardHide(
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: AppColor.dark_blue1,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(24, 84, 24, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 53, right: 53),
                        child: Image.asset(AssetUtils.complete),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AccountReadyHeader(
                          title: S.of(context).awesome,
                          subTitle: S.of(context).accountReady),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 104,
                        width: 327,
                        decoration: BoxDecoration(
                            color: AppColor.white1.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          children: [
                            AccountDetails(
                                title: S.of(context).refTitle,
                                value: S.of(context).refNumber),
                            SizedBox(
                              height: 16,
                            ),
                            AccountDetails(
                                title: S.of(context).iban,
                                value: S.of(context).ibanNumber),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        S.of(context).cardLater,
                        style: TextStyle(
                            color: AppColor.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 80,
                left: 45,
                right: 45,
                child: Column(
                  children: [
                    AnimatedButton(
                      buttonText: "Swipe to proceed",
                      textColor: AppColor.white,
                      borderColor: AppColor.light_violet,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 14.0),
                      child: Text(
                        S.of(context).cardPersonalization,
                        style: TextStyle(
                          color: AppColor.very_light_violet1,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
