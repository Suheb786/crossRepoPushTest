import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/password_hint_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CreatePasswordView extends BasePageViewWidget<CreatePasswordViewModel> {
  CreatePasswordView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreatePasswordViewModel model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
          stream: model.errorDetectorStream,
          initialData: false,
          dataBuilder: (context, isError) {
            return ShakeAnimatedWidget(
              enabled: isError ?? false,
              duration: Duration(milliseconds: 100),
              shakeAngle: Rotation.deg(z: 1),
              curve: Curves.easeInOutSine,
              child: AppStreamBuilder<Resource<User>>(
                stream: model.registerUserStream,
                initialData: Resource.none(),
                onData: (registerData) {
                  if (registerData.status == Status.SUCCESS) {
                    // var event = {
                    //   "definitionId": "ChangePasswordEvent",
                    //   "properties": {"completed": true}
                    // };
                    // InfobipMobilemessaging.submitEventImmediately(event);
                    // ProviderScope.containerOf(context)
                    //     .read(appViewModel)
                    //     .getToken();
                    // ProviderScope.containerOf(context)
                    //     .read(validateOtpViewModelProvider)
                    //     .initiateSmsListener();
                    ///LOGGING EVENT TO APP FLYER
                    model.logEventsForAppFlyer(
                        eventName: 'account_registration', eventValue: {"account_register": true});
                    ProviderScope.containerOf(context).read(accountRegistrationViewModelProvider).nextPage();
                  } else if (registerData.status == Status.ERROR) {
                    model.showToastWithError(registerData.appError!);
                  }
                },
                dataBuilder: (context, data) {
                  return AppStreamBuilder<Resource<bool>>(
                      stream: model.createPasswordStream,
                      initialData: Resource.none(),
                      onData: (passwordData) {
                        if (passwordData.status == Status.SUCCESS) {
                          model.passwordKey.currentState!.isValid = true;
                          model.confirmPasswordKey.currentState!.isValid = true;
                          model.registerUser(
                            email: ProviderScope.containerOf(context)
                                .read(addNumberViewModelProvider)
                                .emailController
                                .text,
                            country: "Jordan",
                            phone: ProviderScope.containerOf(context)
                                .read(addNumberViewModelProvider)
                                .mobileNumberController
                                .text,
                            mobileCode: ProviderScope?.containerOf(context)
                                    .read(addNumberViewModelProvider)
                                    .countryData
                                    .phoneCode ??
                                '',
                          );
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
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(accountRegistrationViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                1.0) {
                              FocusScope.of(context).unfocus();

                              if (StringUtils.isDirectionRTL(context)) {
                                if (details.primaryVelocity!.isNegative) {
                                  ProviderScope.containerOf(context)
                                      .read(accountRegistrationViewModelProvider)
                                      .previousPage();
                                } else {
                                  model.createPassword();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.createPassword();
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(accountRegistrationViewModelProvider)
                                      .previousPage();
                                }
                              }
                            }
                          },
                          child: Card(
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            AppTextField(
                                              key: model.passwordKey,
                                              labelText: S.of(context).createPassword,
                                              obscureText: true,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              controller: model.createPasswordController,
                                              onChanged: (value) {
                                                model.validatePassword();
                                                model.validateAllFields();
                                              },
                                              suffixIcon: (isChecked, value) {
                                                return InkWell(
                                                  onTap: () {
                                                    model.passwordKey.currentState!.secureText =
                                                        !model.passwordKey.currentState!.secureText;
                                                  },
                                                  child: model.passwordKey.currentState!.secureText
                                                      ? Container(
                                                          width: 16,
                                                          height: 16,
                                                          padding: EdgeInsets.all(4),
                                                          child: AppSvg.asset(AssetUtils.eye,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .labelStyle!
                                                                  .color),
                                                        )
                                                      : Icon(
                                                          Icons.visibility_off,
                                                          color: Theme.of(context)
                                                              .inputDecorationTheme
                                                              .labelStyle!
                                                              .color,
                                                        ),
                                                );
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10.0),
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
                                              height: 16,
                                            ),
                                            AppTextField(
                                              key: model.confirmPasswordKey,
                                              labelText: S.of(context).confirmPassword,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              obscureText: true,
                                              onChanged: (value) => model.validateAllFields(),
                                              controller: model.confirmPasswordController,
                                              suffixIcon: (isChecked, value) {
                                                return InkWell(
                                                  onTap: () {
                                                    model.confirmPasswordKey.currentState!.secureText =
                                                        !model.confirmPasswordKey.currentState!.secureText;
                                                  },
                                                  child: model.confirmPasswordKey.currentState!.secureText
                                                      ? Container(
                                                          width: 16,
                                                          height: 16,
                                                          padding: EdgeInsets.all(4),
                                                          child: AppSvg.asset(AssetUtils.eye,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .labelStyle!
                                                                  .color),
                                                        )
                                                      : Icon(
                                                          Icons.visibility_off,
                                                          color: Theme.of(context)
                                                              .inputDecorationTheme
                                                              .labelStyle!
                                                              .color,
                                                        ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).viewInsets.bottom,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 16),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            if (isValid!) {
                                              return AnimatedButton(buttonText: S.of(context).swipeToProceed);
                                            } else {
                                              return Container();
                                            }
                                          }),
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                },
              ),
            );
          }),
    );
  }
}
