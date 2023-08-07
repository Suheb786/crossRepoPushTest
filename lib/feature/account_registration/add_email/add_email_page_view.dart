import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/check_username.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infobip_mobilemessaging/infobip_mobilemessaging.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/add_email/add_email_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../ui/molecules/register/password_hint_widget.dart';

class AddEmailPageView extends BasePageViewWidget<AddEmailViewModel> {
  AddEmailPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          initialData: false,
          stream: model.errorDetectorStream,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<bool>>(
                stream: model.createPasswordStream,
                initialData: Resource.none(),
                onData: (passwordData) {
                  print("data.status ${passwordData.status}");
                  if (passwordData.status == Status.SUCCESS) {
                    var event = {
                      "definitionId": "UserEvents",
                      "properties": {
                        "emailId": model.emailController.text,
                      }
                    };
                    InfobipMobilemessaging.submitEventImmediately(event);
                    ProviderScope.containerOf(context)
                        .read(accountRegistrationViewModelProvider)
                        .updateEmail(model.emailController.text);
                    ProviderScope.containerOf(context).read(accountRegistrationViewModelProvider).nextPage();
                  } else if (passwordData.status == Status.ERROR) {
                    if (passwordData.appError!.type == ErrorType.PASSWORD_MISMATCH) {
                      model.passwordKey.currentState!.isValid = false;
                      model.confirmPasswordKey.currentState!.isValid = false;
                    } else if (passwordData.appError!.type == ErrorType.EMPTY_PASSWORD) {
                      model.passwordKey.currentState!.isValid = false;
                    } else if (passwordData.appError!.type == ErrorType.EMPTY_CONFIRM_PASSWORD) {
                      model.confirmPasswordKey.currentState!.isValid = false;
                    } else if (passwordData.appError!.type == ErrorType.PASSWORD_NOT_MEET_CRITERIA) {}
                    model.showToastWithError(passwordData.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return Card(
                    margin: EdgeInsets.zero,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  AppStreamBuilder<Resource<CheckUsername>>(
                                    initialData: Resource.none(),
                                    stream: model.checkUserNameStream,
                                    onData: (data) {
                                      if (data.status == Status.ERROR) {
                                        if (data.appError!.type == ErrorType.EMAIL_ALREADY_EXIST) {
                                          model.isEmailExist = 1;
                                        }
                                        model.showToastWithError(data.appError!);
                                        model.showErrorState();
                                      }
                                    },
                                    dataBuilder: (context, data) {
                                      return AppTextField(
                                        labelText: S.of(context).emailAddress,
                                        hintText: S.of(context).pleaseEnter,
                                        controller: model.emailController,
                                        key: model.emailKey,
                                        inputAction: TextInputAction.go,
                                        inputType: TextInputType.emailAddress,
                                        onChanged: (value) {
                                          model.validateEmail();
                                          model.validate();
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  AppTextField(
                                    key: model.passwordKey,
                                    labelText: S.of(context).createPassword,
                                    obscureText: true,
                                    hintText: S.of(context).pleaseEnter,
                                    inputType: TextInputType.text,
                                    controller: model.createPasswordController,
                                    onChanged: (value) {
                                      model.validatePassword();
                                      model.validate();
                                    },
                                    suffixIcon: (isChecked, value) {
                                      return InkWell(
                                        onTap: () {
                                          model.passwordKey.currentState!.secureText =
                                              !model.passwordKey.currentState!.secureText;
                                        },
                                        child: model.passwordKey.currentState!.secureText
                                            ? Container(
                                                width: 16.w,
                                                height: 16.h,
                                                padding: EdgeInsets.all(4),
                                                child: AppSvg.asset(AssetUtils.eye,
                                                    color: Theme.of(context)
                                                        .inputDecorationTheme
                                                        .labelStyle!
                                                        .color),
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                                color:
                                                    Theme.of(context).inputDecorationTheme.labelStyle!.color,
                                              ),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0.h),
                                    child: Wrap(
                                      runSpacing: 10,
                                      spacing: 8,
                                      children: [
                                        PasswordHintWidget(
                                          label: S.of(context).eightCharacters,
                                          isValid: model.minimumEightCharacters,
                                        ),
                                        PasswordHintWidget(
                                          label: S.of(context).oneUpperCaseLetter,
                                          isValid: model.hasUpperCase,
                                        ),
                                        PasswordHintWidget(
                                          label: S.of(context).oneNumber,
                                          isValid: model.containsDigit,
                                        ),
                                        PasswordHintWidget(
                                          label: S.of(context).oneSymbol,
                                          isValid: model.hasSymbol,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  AppTextField(
                                    key: model.confirmPasswordKey,
                                    labelText: S.of(context).confirmPassword,
                                    hintText: S.of(context).pleaseEnter,
                                    inputType: TextInputType.text,
                                    obscureText: true,
                                    onChanged: (value) => model.validate(),
                                    controller: model.confirmPasswordController,
                                    suffixIcon: (isChecked, value) {
                                      return InkWell(
                                        onTap: () {
                                          model.confirmPasswordKey.currentState!.secureText =
                                              !model.confirmPasswordKey.currentState!.secureText;
                                        },
                                        child: model.confirmPasswordKey.currentState!.secureText
                                            ? Container(
                                                width: 16.w,
                                                height: 16.h,
                                                padding: EdgeInsets.all(4),
                                                child: AppSvg.asset(AssetUtils.eye,
                                                    color: Theme.of(context)
                                                        .inputDecorationTheme
                                                        .labelStyle!
                                                        .color),
                                              )
                                            : Icon(
                                                Icons.visibility_off,
                                                color:
                                                    Theme.of(context).inputDecorationTheme.labelStyle!.color,
                                              ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SliverFillRemaining(
                              fillOverscroll: true,
                              hasScrollBody: false,
                              child: Container(
                                margin: EdgeInsets.only(top: 80.h, bottom: 40.h),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        S.of(context).backToRegistration,
                                        style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          color: AppColor.brightBlue,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.0.h),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: AppPrimaryButton(
                                                text: S.of(context).next,
                                                onPressed: () {
                                                  model.createPassword();

                                                  /*  ProviderScope.containerOf(context)
                                                    .read(accountRegistrationViewModelProvider)
                                                    .previousPage();*/
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                },
              ),
            );
          }),
    );
  }
}
