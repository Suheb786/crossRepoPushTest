import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page_view_model.dart';
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

class EnterNewPasswordPageView
    extends BasePageViewWidget<EnterNewPasswordPageViewModel> {
  EnterNewPasswordPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, EnterNewPasswordPageViewModel model) {
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
                child: AppStreamBuilder<
                        Resource<ProfileChangedSuccessResponse>>(
                    stream: model.createPasswordStream,
                    initialData: Resource.none(),
                    onData: (passwordData) {
                      if (passwordData.status == Status.SUCCESS) {
                        Navigator.pop(context);
                        model.showSuccessToast(passwordData.data!.data!.data!);
                      } else if (passwordData.status == Status.ERROR) {
                        if (passwordData.appError!.type ==
                            ErrorType.EMPTY_PASSWORD) {
                          model.currentPasswordKey.currentState!.isValid =
                              false;
                        } else if (passwordData.appError!.type ==
                            ErrorType.EMPTY_NEW_PASSWORD) {
                          model.newPasswordKey.currentState!.isValid = false;
                        }
                        model.showToastWithError(passwordData.appError!);
                      }
                    },
                    dataBuilder: (context, data) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.primaryVelocity!.isNegative) {
                            model.createPassword();
                          }
                        },
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 32, horizontal: 24),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AppTextField(
                                            key: model.currentPasswordKey,
                                            labelText:
                                                S.of(context).currentPassword,
                                            obscureText: true,
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.currentPasswordController,
                                            onChanged: (value) {
                                              model.validateAllFields();
                                            },
                                            suffixIcon: (isChecked, value) {
                                              return InkWell(
                                                onTap: () {
                                                  model
                                                          .currentPasswordKey
                                                          .currentState!
                                                          .secureText =
                                                      !model
                                                          .currentPasswordKey
                                                          .currentState!
                                                          .secureText;
                                                },
                                                child: model
                                                        .currentPasswordKey
                                                        .currentState!
                                                        .secureText
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
                                                                .color!
                                                                .withOpacity(
                                                                    0.3)),
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
                                            height: 16,
                                          ),
                                          AppTextField(
                                            key: model.newPasswordKey,
                                            labelText:
                                                S.of(context).newPassword,
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            obscureText: true,
                                            onChanged: (value) {
                                              model.validatePassword();
                                              model.validateAllFields();
                                            },
                                            controller:
                                                model.newPasswordController,
                                            suffixIcon: (isChecked, value) {
                                              return InkWell(
                                                onTap: () {
                                                  model
                                                          .newPasswordKey
                                                          .currentState!
                                                          .secureText =
                                                      !model
                                                          .newPasswordKey
                                                          .currentState!
                                                          .secureText;
                                                },
                                                child: model
                                                        .newPasswordKey
                                                        .currentState!
                                                        .secureText
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
                                                                .color!
                                                                .withOpacity(
                                                                    0.3)),
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
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Wrap(
                                              runSpacing: 10,
                                              spacing: 8,
                                              children: [
                                                PasswordHintWidget(
                                                  label: S
                                                      .of(context)
                                                      .eightCharacters,
                                                  isValid: model
                                                      .minimumEightCharacters,
                                                ),
                                                PasswordHintWidget(
                                                  label: S
                                                      .of(context)
                                                      .oneUpperCaseLetter,
                                                  isValid: model.hasUpperCase,
                                                ),
                                                PasswordHintWidget(
                                                  label:
                                                      S.of(context).oneNumber,
                                                  isValid: model.containsDigit,
                                                ),
                                                PasswordHintWidget(
                                                  label:
                                                      S.of(context).oneSymbol,
                                                  isValid: model.hasSymbol,
                                                ),
                                              ],
                                            ),
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
                                    padding: EdgeInsets.only(top: 16),
                                    child: AppStreamBuilder<bool>(
                                        stream: model.showButtonStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          if (isValid!) {
                                            return AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed);
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                ],
                              )),
                        ),
                      );
                    }));
          }),
    );
  }
}
