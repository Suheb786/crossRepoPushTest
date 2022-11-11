import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/apple_pay/add_other_card_to_apple_wallet_page_dialog/add_other_card_to_apple_wallet_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import 'apple_pay_success_and_error_page.dart';
import 'apple_pay_success_and_error_page_view_model.dart';

class ApplePaySuccessAndErrorPageView extends BasePageViewWidget<ApplePaySuccessAndErrorPageViewModel> {
  ApplePaySuccessAndErrorPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ApplePaySuccessAndErrorPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          AddOtherCardToAppleWalletDialog.show(context,
              image: AssetUtils.applePayIcon,
              title: S.of(context).addOtherCardToAppleWallet,
              descriptionWidget: Text(
                S.of(context).addOtherCardToAppleWalletDialogDescription,
                style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14, fontWeight: FontWeight.w400),
              ), onDismissed: () {
            Navigator.pop(context);
          }, onSelected: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, RoutePaths.ApplePaySuccessAndErrorPage,
                arguments: ApplePaySuccessAndErrorPageArguments(
                    title: S.of(context).applePaySetUpFailed,
                    titleDescription: S.of(context).errorSettingUpApplePay,
                    successOrErrorIcon: AssetUtils.cancel));

            // model.sendOtpTokenMobile();
          });
        }
      },
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
                                  color: Theme.of(context).accentColor),
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
                                  color: Theme.of(context).accentColor),
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
                  AnimatedButton(
                    buttonText: S.of(context).swipeToProceed,
                    textColor: Theme.of(context).accentColor,
                    borderColor: Theme.of(context).accentColor,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 56.h,
                    ),
                    child: Center(
                      child: Text(
                        S.of(context).toDashboard,
                        style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.t,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
