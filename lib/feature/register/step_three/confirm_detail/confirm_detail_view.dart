import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ConfirmDetailView extends BasePageViewWidget<ConfirmDetailViewModel> {
  ConfirmDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ConfirmDetailViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Text(
            S.of(context).personalDetails,
            style: TextStyle(
                color: AppColor.dark_gray,
                fontSize: 10,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0, bottom: 32),
            child: Text(
              S.of(context).confirmDetailsHeader,
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
                        stream: model.confirmDetailResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            model.nameKey.currentState!.isValid = true;
                            model.idNumberKey.currentState!.isValid = true;
                            model.dobKey.currentState!.isValid = true;
                            model.nationalityKey.currentState!.isValid = true;
                            model.expiryDateKey.currentState!.isValid = true;
                            model.genderKey.currentState!.isValid = true;
                            model.motherNameKey.currentState!.isValid = true;
                            ProviderScope.containerOf(context)
                                .read(registerStepThreeViewModelProvider)
                                .registrationStepThreePageController
                                .nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          }
                          if (data.status == Status.ERROR) {
                            if (data.appError!.type == ErrorType.EMPTY_NAME) {
                              model.nameKey.currentState!.isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_ID_NUMBER) {
                              model.idNumberKey.currentState!.isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_DATE_OF_BIRTH) {
                              model.dobKey.currentState!.isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_NATIONALITY) {
                              model.nationalityKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_EXPIRY_DATE) {
                              model.expiryDateKey.currentState!.isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_MOTHER_NAME) {
                              model.motherNameKey.currentState!.isValid = false;
                            } else {
                              model.genderKey.currentState!.isValid = false;
                            }
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.confirmDetail();
                              } else {
                                ProviderScope.containerOf(context)
                                    .read(registerStepThreeViewModelProvider)
                                    .registrationStepThreePageController
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
                                        labelText: S.of(context).name,
                                        hintText: S.of(context).nameHint,
                                        inputType: TextInputType.text,
                                        controller: model.nameController,
                                        key: model.nameKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).idNumber,
                                        hintText: S.of(context).idHint,
                                        inputType: TextInputType.text,
                                        controller: model.idNumberController,
                                        key: model.idNumberKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).dob,
                                        hintText: S.of(context).dobHint,
                                        inputType: TextInputType.text,
                                        controller: model.dobController,
                                        key: model.dobKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).nationality,
                                        hintText: S.of(context).nationalityHint,
                                        inputType: TextInputType.text,
                                        controller: model.nationalityController,
                                        key: model.nationalityKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).expiryDate,
                                        hintText: S.of(context).expiryDateHint,
                                        inputType: TextInputType.text,
                                        controller: model.expiryDateController,
                                        key: model.expiryDateKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).gender,
                                        hintText: S.of(context).genderHint,
                                        inputType: TextInputType.text,
                                        controller: model.genderController,
                                        key: model.genderKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      AppTextField(
                                        labelText: S.of(context).motherName,
                                        hintText: S.of(context).motherNameHint,
                                        inputType: TextInputType.text,
                                        controller: model.motherNameController,
                                        key: model.motherNameKey,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        textHintWidget:
                                            (hasFocus, isValid, value) {
                                          return Visibility(
                                            visible: !isValid,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Text(
                                                ErrorParser
                                                    .getLocalisedStringError(
                                                        error: data!.appError,
                                                        localisedHelper:
                                                            S.of(context)),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor.vivid_red),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom,
                                      ),
                                      SizedBox(
                                        height: 32,
                                      ),
                                      AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 45, right: 45),
                                                child: AnimatedButton(
                                                    buttonText: S
                                                        .of(context)
                                                        .swipeToProceed),
                                              ),
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              ),
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
