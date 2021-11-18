import 'dart:ui';

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/login/login_page_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class LoginPageView extends BasePageViewWidget<LoginViewModel> {
  LoginPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: model.scrollController,
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 112.0),
                      child: Image.asset(
                        AssetUtils.blink,
                        width: 195,
                        height: 91.14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.0),
                      child: Text(
                        S.of(context).enterLoginDetails,
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    AppStreamBuilder<bool>(
                        initialData: false,
                        stream: model.errorDetectorStream,
                        dataBuilder: (context, isError) {
                          return ShakeAnimatedWidget(
                            enabled: isError ?? false,
                            duration: Duration(milliseconds: 100),
                            shakeAngle: Rotation.deg(z: 1),
                            curve: Curves.easeInOutSine,
                            child: AppStreamBuilder<Resource<bool>>(
                              stream: model.loginStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                Navigator.pushReplacementNamed(
                                    context, RoutePaths.Registration);
                                if (data.status == Status.SUCCESS) {
                                  model.emailKey.currentState!.isValid = true;

                                  /// TODO: Uncomment when we get success response
                                  // Navigator.pushReplacementNamed(
                                  //     context, RoutePaths.Registration);
                                } else if (data.status == Status.ERROR) {
                                  model.emailKey.currentState!.isValid = false;
                                  model.showToastWithError(data.appError!);
                                }
                              },
                              dataBuilder: (context, data) {
                                return GestureDetector(
                                  onHorizontalDragUpdate: (details) {
                                    if (details.primaryDelta!.isNegative) {
                                      model.validateEmail();
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 40, right: 40, top: 25),
                                    child: Column(
                                      children: [
                                        // Center(child: BlurCard()),
                                        AppTextField(
                                            textFieldBorderColor:
                                                AppColor.whiteGray,
                                            textFieldFocusBorderColor:
                                                Theme.of(context)
                                                    .primaryColorDark,
                                            labelText:
                                                S.of(context).emailAddress,
                                            hintText: S.of(context).pleaseEnter,
                                            key: model.emailKey,
                                            controller: model.emailController,
                                            inputType:
                                                TextInputType.emailAddress,
                                            inputAction: TextInputAction.next,
                                            onSaved: (value) {
                                              model.validateEmail();
                                            },
                                            suffixIcon: (_, __) {
                                              return Visibility(
                                                visible: false,
                                                child: AppSvg.asset(
                                                    AssetUtils.fingerPrint),
                                              );
                                            },
                                            suffixIconSize: 24,
                                            onChanged: (value) =>
                                                model.validate()),
                                        Padding(
                                          padding: EdgeInsets.only(top: 16),
                                          child: AppTextField(
                                            textFieldBorderColor:
                                                AppColor.whiteGray,
                                            textFieldFocusBorderColor:
                                                Theme.of(context)
                                                    .primaryColorDark,
                                            labelText: S.of(context).password,
                                            hintText: S.of(context).pleaseEnter,
                                            key: model.passwordKey,
                                            controller:
                                                model.passwordController,
                                            inputAction: TextInputAction.done,
                                            onSaved: (value) {
                                              model.validateEmail();
                                            },
                                            onChanged: (value) =>
                                                model.validate(),
                                            obscureText: true,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 24),
                                          child: Text(
                                            S.of(context).forgotPassword,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .accentColor),
                                          ),
                                        ),
                                        AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return Visibility(
                                                visible: isValid!,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 24, right: 52),
                                                  child: AnimatedButton(
                                                    buttonText:
                                                        "Swipe to proceed",
                                                    borderColor:
                                                        Theme.of(context)
                                                            .accentColor,
                                                    textColor: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta!.isNegative
                    // &&
                    // model.scrollController.offset >=
                    //     model.scrollController.position.maxScrollExtent - 100 &&
                    // !model.scrollController.position.outOfRange &&
                    // details.primaryDelta != 0
                    ) {
                  ProviderScope.containerOf(context)
                      .read(onBoardingViewModelProvider)
                      .onBoardingPageController
                      .nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                } else {
                  // model.scrollController.animateTo(details.localPosition.dx,
                  //     duration: Duration(milliseconds: 350), curve: Curves.ease);
                }
              },
              child: Column(
                children: [
                  Container(
                    height: 4,
                    width: 128,
                    margin: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: AppColor.whiteGray),
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 25, top: 19),
                      width: double.maxFinite,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(16))),
                      child: Text(
                        S.of(context).swipeUpToRegister,
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context)
                                .accentTextTheme
                                .bodyText1
                                ?.color,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
