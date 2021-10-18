import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/createPassword/create_password_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class CreatePasswordView extends BasePageViewWidget<CreatePasswordViewModel> {
  CreatePasswordView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, CreatePasswordViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).accountRegistration,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 36.0, bottom: 32),
            child: Text(
              S.of(context).createPasswordHeader,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
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
                            model.confirmPasswordKey.currentState!.isValid =
                                true;

                            ProviderScope.containerOf(context)
                                .read(registerViewModelProvider)
                                .registrationStepsController
                                .animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          } else if (data.status == Status.ERROR) {
                            if (data.appError!.type ==
                                ErrorType.PASSWORD_MISMATCH) {
                              model.passwordKey.currentState!.isValid = false;
                              model.confirmPasswordKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_PASSWORD) {
                              model.passwordKey.currentState!.isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_CONFIRM_PASSWORD) {
                              model.confirmPasswordKey.currentState!.isValid =
                                  false;
                            }
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.createPassword();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(registerStepOneViewModelProvider)
                                    .pageController
                                    .previousPage(
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut);
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 32, horizontal: 24),
                                  decoration: BoxDecoration(
                                    color: AppColor.very_soft_violet,
                                    gradient: LinearGradient(
                                        colors: [
                                          AppColor.dark_violet,
                                          AppColor.dark_moderate_blue
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter),
                                  ),
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
                                          onChanged: (value) =>
                                              model.validatePassword(),
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
                                                  ? Image.asset(AssetUtils.eye)
                                                  : Icon(Icons.person),
                                            );
                                          },
                                          labelIcon: () => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.33),
                                            child: AppSvg.asset(AssetUtils.info,
                                                height: 13.33, width: 13.33),
                                          ),
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                child: Text(
                                                  ErrorParser
                                                      .getLocalisedStringError(
                                                          error: data!.appError,
                                                          localisedHelper:
                                                              S.of(context)),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.vivid_red),
                                                ),
                                              ),
                                            );
                                          },
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
                                              model.validatePassword(),
                                          controller:
                                              model.confirmPasswordController,
                                          suffixIcon: (isChecked, value) {
                                            return Image.asset(AssetUtils.eye);
                                          },
                                          labelIcon: () => Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.33),
                                            child: AppSvg.asset(AssetUtils.info,
                                                height: 13.33, width: 13.33),
                                          ),
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 8),
                                                child: Text(
                                                  ErrorParser
                                                      .getLocalisedStringError(
                                                          error: data!.appError,
                                                          localisedHelper:
                                                              S.of(context)),
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColor.vivid_red),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 67,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 45, right: 45),
                                          child: AppStreamBuilder<bool>(
                                              stream: model.showButtonStream,
                                              initialData: false,
                                              dataBuilder: (context, isValid) {
                                                if (isValid!) {
                                                  return AnimatedButton(
                                                      buttonText:
                                                          "Swipe to proceed");
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
