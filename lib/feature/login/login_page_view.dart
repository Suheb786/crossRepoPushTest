import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/app_icon_button.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class LoginPageView extends BasePageViewWidget<LoginViewModel> {
  LoginPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 84.0),
              child: Text(
                S.of(context).welcomeToNeuBank,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 32, right: 24, left: 24),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                        color: AppColor.black.withOpacity(0.32),
                        blurRadius: 24,
                        offset: Offset(0, 8)),
                  ]),
              child: Stack(
                children: [
                  Image.asset(AssetUtils.loginCard),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: AppTextField(
                            labelText: S.of(context).emailAddress,
                            hintText: S.of(context).pleaseEnter,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AppDivider(
                                color: AppColor.white.withOpacity(0.3),
                                indent: 24,
                                endIndent: 12,
                              ),
                              Text(
                                S.of(context).orContinueWith,
                                style: TextStyle(
                                    color: AppColor.dark_grayish_violet1,
                                    fontSize: 12),
                              ),
                              AppDivider(
                                color: AppColor.white.withOpacity(0.3),
                                endIndent: 24,
                                indent: 12,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 40, left: 24, right: 24),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: AppIconButton(
                                  icon: AssetUtils.apple,
                                  iconSize: 28,
                                ),
                              ),
                              Container(width: 16),
                              Expanded(
                                child: AppIconButton(
                                  icon: AssetUtils.google,
                                  iconSize: 20,
                                ),
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
            Padding(
              padding: EdgeInsets.only(bottom: 64),
              child: Text(
                S.of(context).iHaveAnAccount,
                style: TextStyle(
                    fontSize: 16,
                    color: AppColor.white,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
