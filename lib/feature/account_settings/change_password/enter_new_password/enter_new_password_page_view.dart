import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_settings/change_password/enter_new_password/enter_new_password_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/register/password_hint_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../../ui/molecules/button/app_primary_button.dart';

class EnterNewPasswordPageView extends BasePageViewWidget<EnterNewPasswordPageViewModel> {
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
                child: AppStreamBuilder<Resource<bool>>(
                    stream: model.createPasswordStream,
                    initialData: Resource.none(),
                    onData: (passwordData) {
                      if (passwordData.status == Status.SUCCESS) {
                        Navigator.pop(context);
                        model.showSuccessToast(S.of(context).passwordUpdate);
                      } else if (passwordData.status == Status.ERROR) {
                        if (passwordData.appError!.type == ErrorType.EMPTY_PASSWORD) {
                          model.currentPasswordKey.currentState!.isValid = false;
                        } else if (passwordData.appError!.type == ErrorType.EMPTY_NEW_PASSWORD) {
                          model.newPasswordKey.currentState!.isValid = false;
                        } else if (passwordData.appError!.type == ErrorType.PASSWORD_NOT_MEET_CRITERIA) {
                          model.newPasswordKey.currentState!.isValid = false;
                        } else if (passwordData.appError!.type == ErrorType.CURRENT_PASSWORD_INVALID) {
                          model.currentPasswordKey.currentState!.isValid = false;
                        } else if (passwordData.appError!.type ==
                            ErrorType.CONFIRM_PASSWORD_NOT_MATCH_WITH_NEW_PASSWORD) {
                          model.confirmNewPasswordKey.currentState!.isValid = false;
                        }

                        model.showToastWithError(passwordData.appError!);
                      }
                    },
                    dataBuilder: (context, data) {
                      return GestureDetector(
                        onHorizontalDragEnd: (details) {
                          FocusScope.of(context).unfocus();
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              model.createPassword();
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              model.createPassword();
                            }
                          }
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                                    ? 0
                                    : MediaQuery.of(context).viewInsets.bottom - 48.h),
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppTextField(
                                              key: model.currentPasswordKey,
                                              labelText: S.of(context).currentPassword,
                                              obscureText: true,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              controller: model.currentPasswordController,
                                              onChanged: (value) {
                                                model.validateAllFields();
                                                model.validateCurrentPassword();
                                              },
                                              suffixIcon: (isChecked, value) {
                                                return InkWell(
                                                  onTap: () {
                                                    model.currentPasswordKey.currentState!.secureText =
                                                        !model.currentPasswordKey.currentState!.secureText;
                                                  },
                                                  child: model.currentPasswordKey.currentState!.secureText
                                                      ? Container(
                                                          width: 16.w,
                                                          height: 16.h,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 4.0.w, vertical: 4.h),
                                                          child: AppSvg.asset(AssetUtils.eye,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .labelStyle!
                                                                  .color!
                                                                  .withOpacity(0.3)),
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
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              key: model.newPasswordKey,
                                              labelText: S.of(context).newPassword,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              obscureText: true,
                                              onChanged: (value) {
                                                model.validatePassword();
                                                model.validateAllFields();
                                              },
                                              controller: model.newPasswordController,
                                              suffixIcon: (isChecked, value) {
                                                return InkWell(
                                                  onTap: () {
                                                    model.newPasswordKey.currentState!.secureText =
                                                        !model.newPasswordKey.currentState!.secureText;
                                                  },
                                                  child: model.newPasswordKey.currentState!.secureText
                                                      ? Container(
                                                          width: 16.w,
                                                          height: 16.h,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 4.0.w, vertical: 4.h),
                                                          child: AppSvg.asset(AssetUtils.eye,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .labelStyle!
                                                                  .color!
                                                                  .withOpacity(0.3)),
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
                                              key: model.confirmNewPasswordKey,
                                              labelText: S.of(context).confirmPassword,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              obscureText: true,
                                              onChanged: (value) {
                                                model.validatePassword();
                                                model.validateAllFields();
                                              },
                                              controller: model.confirmNewPasswordController,
                                              suffixIcon: (isChecked, value) {
                                                return InkWell(
                                                  onTap: () {
                                                    model.confirmNewPasswordKey.currentState!.secureText =
                                                        !model.confirmNewPasswordKey.currentState!.secureText;
                                                  },
                                                  child: model.confirmNewPasswordKey.currentState!.secureText
                                                      ? Container(
                                                          width: 16.w,
                                                          height: 16.h,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 4.0.w, vertical: 4.h),
                                                          child: AppSvg.asset(AssetUtils.eye,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .labelStyle!
                                                                  .color!
                                                                  .withOpacity(0.3)),
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
                                      padding: EdgeInsets.only(top: 16.h),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return AppPrimaryButton(
                                              text: S.of(context).next,
                                              isDisabled: !isValid!,
                                              onPressed: () {
                                                model.createPassword();
                                              },
                                            );
                                          }),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      );
                    }));
          }),
    );
  }
}
