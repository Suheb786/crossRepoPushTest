import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/createPassword/create_password_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/password_hint_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

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
              child: AppStreamBuilder<Resource<bool>>(
                  stream: model.createPasswordStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      model.passwordKey.currentState!.isValid = true;
                      model.confirmPasswordKey.currentState!.isValid = true;

                      Navigator.pushReplacementNamed(
                          context, RoutePaths.Dashboard);
                    } else if (data.status == Status.ERROR) {
                      if (data.appError!.type == ErrorType.PASSWORD_MISMATCH) {
                        model.passwordKey.currentState!.isValid = false;
                        model.confirmPasswordKey.currentState!.isValid = false;
                      } else if (data.appError!.type ==
                          ErrorType.EMPTY_PASSWORD) {
                        model.passwordKey.currentState!.isValid = false;
                      } else if (data.appError!.type ==
                          ErrorType.EMPTY_CONFIRM_PASSWORD) {
                        model.confirmPasswordKey.currentState!.isValid = false;
                      }
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, data) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.createPassword();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(accountRegistrationViewModelProvider)
                              .pageController
                              .previous(animation: true);
                          // .previousPage(
                          //     duration: Duration(milliseconds: 500),
                          //     curve: Curves.easeInOut);
                        }
                      },
                      child: Card(
                        margin: EdgeInsets.zero,
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            // decoration: BoxDecoration(
                            //   color: AppColor.very_soft_violet,
                            //   gradient: LinearGradient(
                            //       colors: [
                            //         AppColor.dark_violet,
                            //         AppColor.dark_moderate_blue
                            //       ],
                            //       begin: Alignment.bottomCenter,
                            //       end: Alignment.topCenter),
                            // ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          key: model.passwordKey,
                                          labelText:
                                              S.of(context).createPassword,
                                          obscureText: true,
                                          hintText: S.of(context).pleaseEnter,
                                          inputType: TextInputType.text,
                                          controller:
                                              model.createPasswordController,
                                          onChanged: (value) {
                                            model.validatePassword();
                                            model.validateAllFields();
                                          },
                                          suffixIcon: (isChecked, value) {
                                            return InkWell(
                                              onTap: () {
                                                model.passwordKey.currentState!
                                                        .secureText =
                                                    !model
                                                        .passwordKey
                                                        .currentState!
                                                        .secureText;
                                              },
                                              child: model.passwordKey
                                                      .currentState!.secureText
                                                  ? Container(
                                                      width: 16,
                                                      height: 16,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: AppSvg.asset(
                                                          AssetUtils.eye,
                                                          color: Theme.of(
                                                                  context)
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
                                          padding:
                                              const EdgeInsets.only(top: 10.0),
                                          child: Wrap(
                                            runSpacing: 10,
                                            spacing: 8,
                                            children: [
                                              PasswordHintWidget(
                                                label: S
                                                    .of(context)
                                                    .eightCharacters,
                                                backgroundColor: !model
                                                        .minimumEightCharacters
                                                    ? Theme.of(context)
                                                        .inputDecorationTheme
                                                        .hintStyle!
                                                        .color
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                isValid: model
                                                    .minimumEightCharacters,
                                              ),
                                              PasswordHintWidget(
                                                label: S
                                                    .of(context)
                                                    .oneUpperCaseLetter,
                                                backgroundColor: !model
                                                        .hasUpperCase
                                                    ? Theme.of(context)
                                                        .inputDecorationTheme
                                                        .hintStyle!
                                                        .color
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                isValid: model.hasUpperCase,
                                              ),
                                              PasswordHintWidget(
                                                label: S.of(context).oneNumber,
                                                backgroundColor: !model
                                                        .containsDigit
                                                    ? Theme.of(context)
                                                        .inputDecorationTheme
                                                        .hintStyle!
                                                        .color
                                                    : Theme.of(context)
                                                        .primaryColorDark,
                                                isValid: model.containsDigit,
                                              ),
                                              PasswordHintWidget(
                                                label: S.of(context).oneSymbol,
                                                backgroundColor: !model
                                                        .hasSymbol
                                                    ? Theme.of(context)
                                                        .inputDecorationTheme
                                                        .hintStyle!
                                                        .color
                                                    : Theme.of(context)
                                                        .primaryColorDark,
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
                                          labelText:
                                              S.of(context).confirmPassword,
                                          hintText: S.of(context).pleaseEnter,
                                          inputType: TextInputType.text,
                                          obscureText: true,
                                          onChanged: (value) =>
                                              model.validateAllFields(),
                                          controller:
                                              model.confirmPasswordController,
                                          suffixIcon: (isChecked, value) {
                                            return InkWell(
                                              onTap: () {
                                                model
                                                        .confirmPasswordKey
                                                        .currentState!
                                                        .secureText =
                                                    !model
                                                        .confirmPasswordKey
                                                        .currentState!
                                                        .secureText;
                                              },
                                              child: model.confirmPasswordKey
                                                      .currentState!.secureText
                                                  ? Container(
                                                      width: 16,
                                                      height: 16,
                                                      padding:
                                                          EdgeInsets.all(4),
                                                      child: AppSvg.asset(
                                                          AssetUtils.eye,
                                                          color: Theme.of(
                                                                  context)
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
                                          height: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: 45, bottom: 0),
                                  child: AppStreamBuilder<bool>(
                                      stream: model.showButtonStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        if (isValid!) {
                                          return AnimatedButton(
                                              buttonText:
                                                  S.of(context).swipeToProceed);
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                              ],
                            )),
                      ),
                    );
                  }),
            );
          }),
    );
  }
}
