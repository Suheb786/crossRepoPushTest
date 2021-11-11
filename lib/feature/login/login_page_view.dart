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
import 'package:neo_bank/ui/molecules/blur_card.dart';
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
                    padding: EdgeInsets.only(top: 57.0),
                    child: Text(
                      S.of(context).welcomeToNeuBank,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 32,
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
                              if (data.status == Status.SUCCESS) {
                                model.emailKey.currentState!.isValid = true;
                                Navigator.pushReplacementNamed(
                                    context, RoutePaths.AccountRegistration);
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
                                  padding: EdgeInsets.only(top: 15),
                                  child: Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: 16,
                                            right: 24,
                                            left: 24,
                                            top: 25),
                                        padding: EdgeInsets.only(top: 235),
                                        clipBehavior: Clip.antiAlias,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    AssetUtils.circle),
                                                fit: BoxFit.fitWidth,
                                                alignment: Alignment.topCenter),
                                            backgroundBlendMode:
                                                BlendMode.difference,
                                            gradient: LinearGradient(
                                                colors: [
                                                  AppColor.dark_violet,
                                                  AppColor.dark_moderate_blue
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColor.black
                                                      .withOpacity(0.32),
                                                  blurRadius: 24,
                                                  offset: Offset(0, 8)),
                                            ]),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 24, right: 24, top: 25),
                                              child: AppTextField(
                                                  labelText: S
                                                      .of(context)
                                                      .emailAddress,
                                                  hintText:
                                                      S.of(context).pleaseEnter,
                                                  key: model.emailKey,
                                                  controller:
                                                      model.emailController,
                                                  inputType: TextInputType
                                                      .emailAddress,
                                                  inputAction:
                                                      TextInputAction.next,
                                                  onSaved: (value) {
                                                    model.validateEmail();
                                                  },
                                                  suffixIcon: (_, __) {
                                                    return AppSvg.asset(
                                                        AssetUtils.fingerPrint);
                                                  },
                                                  suffixIconSize: 24,
                                                  onChanged: (value) =>
                                                      model.validate()),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 16, left: 24, right: 24),
                                              child: AppTextField(
                                                labelText:
                                                    S.of(context).password,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                key: model.passwordKey,
                                                controller:
                                                    model.passwordController,
                                                inputAction:
                                                    TextInputAction.done,
                                                onSaved: (value) {
                                                  model.validateEmail();
                                                },
                                                onChanged: (value) =>
                                                    model.validate(),
                                                obscureText: true,
                                              ),
                                            ),
                                            Container(
                                              height: 2,
                                              margin: EdgeInsets.only(
                                                  top: 64,
                                                  bottom: 8,
                                                  left: 96,
                                                  right: 96),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      width: 1,
                                                      color: AppColor.white),
                                                  borderRadius:
                                                      BorderRadius.circular(1),
                                                  color: AppColor.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Center(child: BlurCard()),
                                      AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: Positioned(
                                                bottom: 24,
                                                right: 94,
                                                child: AnimatedButton(
                                                  buttonText:
                                                      "Swipe to proceed",
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
            child: Container(
                padding: EdgeInsets.only(bottom: 32, top: 16),
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: AppColor.very_dark_blue1.withOpacity(0.2),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 17.5, horizontal: 24),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      border: Border.all(
                        width: 2,
                        color: AppColor.dark_grayish_violet1,
                      )),
                  child: Text(
                    S.of(context).swipeUpToRegister,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColor.dark_grayish_violet1,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
