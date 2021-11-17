import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_five/account_ready/account_ready_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_ready_header.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AccountReadyView extends BasePageViewWidget<AccountReadyViewModel> {
  AccountReadyView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, AccountReadyViewModel model) {
    return AppKeyBoardHide(
      child: Container(
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
                      padding: EdgeInsets.only(top: 92),
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: Image.asset(AssetUtils.line),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 111.37,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow,
                              ),
                              child:
                                  Center(child: AppSvg.asset(AssetUtils.right)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    AccountReadyHeader(
                        title: S.of(context).accountCreated,
                        subTitle: S.of(context).accountReady),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 104,
                      width: 327,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16)),
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
                            value: S.of(context).ibanNumber,
                            showIcon: true,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 96.0),
                    child: AnimatedButton(
                      buttonText: S.of(context).swipeToProceed,
                      textColor: Theme.of(context).accentColor,
                      borderColor: Theme.of(context).accentColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 14.0),
                    child: Text(
                      S.of(context).cardDelivery,
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  )
                ],
              )
            ],
          )),
    );
  }
}
