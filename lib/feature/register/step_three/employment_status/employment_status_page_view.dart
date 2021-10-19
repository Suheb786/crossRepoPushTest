import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EmploymentStatusPageView
    extends BasePageViewWidget<EmploymentStatusPageViewModel> {
  EmploymentStatusPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.animatedStream,
        initialData: false,
        dataBuilder: (context, isAnimated) {
          return Column(
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
                  S.of(context).tellUsAboutYourJob,
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
                  dataBuilder: (context, error) {
                    return ShakeAnimatedWidget(
                      enabled: error ?? false,
                      duration: Duration(milliseconds: 100),
                      shakeAngle: Rotation.deg(z: 1),
                      curve: Curves.easeInOutSine,
                      child: AppStreamBuilder<Resource<bool>>(
                        stream: model.employmentDetailsStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            ProviderScope.containerOf(context)
                                .read(registerStepThreeViewModelProvider)
                                .registrationStepThreePageController
                                .nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          }
                        },
                        dataBuilder: (context, response) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.validateEmploymentDetails();
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
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText:
                                              S.of(context).employmentStatus,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.employmentStatusController,
                                          key: model.employmentStatusKey,
                                          readOnly: true,
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                model.updateAnimatedValue(true);
                                                EmploymentStatusDialog.show(
                                                    context, onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.updateAnimatedValue(
                                                      false);
                                                  model.updateEmploymentStatus(
                                                      value);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).occupation,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.occupationController,
                                          key: model.occupationKey,
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                OccupationDialog.show(context,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.updateOccupation(value);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          readOnly: true,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText:
                                              S.of(context).mainSourceOfIncome,
                                          hintText: S.of(context).pleaseEnter,
                                          controller: model.sourceController,
                                          inputType: TextInputType.text,
                                          key: model.sourceKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          labelIcon: () {
                                            return InkWell(
                                              onTap: () async {},
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Container(
                                                    height: 14,
                                                    width: 14,
                                                    child: AppSvg.asset(
                                                        AssetUtils.info)),
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText:
                                              S.of(context).monthlyIncome,
                                          hintText: '',
                                          controller:
                                              model.monthlyIncomeController,
                                          inputType: TextInputType.number,
                                          key: model.monthlyIncomeKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          prefixIcon: () {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 8),
                                              child: Text(
                                                S.of(context).JOD,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor
                                                        .very_light_gray_white),
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).annualIncome,
                                          hintText: '',
                                          controller:
                                              model.annualIncomeController,
                                          key: model.annualIncomeKey,
                                          inputType: TextInputType.number,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          prefixIcon: () {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 8),
                                              child: Text(
                                                S.of(context).JOD,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor
                                                        .very_light_gray_white),
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .purposeOfAccountOpening,
                                          hintText: S.of(context).pleaseSelect,
                                          controller: model
                                              .purposeOfAccountOpeningController,
                                          key: model.purposeOfAccountOpeningKey,
                                          readOnly: true,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                PurposeOfAccountOpeningDialog
                                                    .show(context,
                                                        onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model
                                                      .updatePurposeOfAccountOpening(
                                                          value);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).employerName,
                                          hintText: S.of(context).pleaseEnter,
                                          controller:
                                              model.employerNameController,
                                          inputType: TextInputType.text,
                                          key: model.employerNameKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText:
                                              S.of(context).employerCountry,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.employerCountryController,
                                          readOnly: true,
                                          key: model.employerCountryKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                CountryDialog.show(context,
                                                    title: S
                                                        .of(context)
                                                        .employerCountrySmall,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.updateEmployerCountry(
                                                      value);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S.of(context).employerCity,
                                          hintText: S.of(context).pleaseEnter,
                                          controller:
                                              model.employerCityController,
                                          inputType: TextInputType.text,
                                          key: model.employerCityKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText:
                                              S.of(context).employerContact,
                                          hintText: S.of(context).pleaseEnter,
                                          inputType: TextInputType.number,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          controller:
                                              model.employerContactController,
                                          key: model.employerContactKey,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .additionalSourceOfIncome,
                                          hintText: S.of(context).pleaseSelect,
                                          controller: model
                                              .additionalSourceIncomeController,
                                          readOnly: true,
                                          key: model.additionalSourceIncomeKey,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
                                                AdditionalIncomeSourceDialog
                                                    .show(context,
                                                        onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.updateAdditionalIncome(
                                                      value);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .totalAdditionalIncome,
                                          hintText: '',
                                          controller: model
                                              .totalAdditionalIncomeController,
                                          key: model.totalAdditionalIncomeKey,
                                          inputType: TextInputType.number,
                                          textHintWidget:
                                              (hasFocus, isValid, value) {
                                            return Visibility(
                                              visible: !isValid,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 8),
                                                  child: Text(
                                                    ErrorParser
                                                        .getLocalisedStringError(
                                                            error: response!
                                                                .appError,
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
                                              ),
                                            );
                                          },
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                          prefixIcon: () {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, right: 8),
                                              child: Text(
                                                S.of(context).JOD,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColor
                                                        .very_light_gray_white),
                                              ),
                                            );
                                          },
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 32, right: 32),
                                            child: AppStreamBuilder<bool>(
                                                stream: model
                                                    .allFieldValidatorStream,
                                                initialData: false,
                                                dataBuilder:
                                                    (context, isValid) {
                                                  return (isValid!)
                                                      ? AnimatedButton(
                                                          buttonText: S
                                                              .of(context)
                                                              .swipeToProceed,
                                                          buttonHeight: 50,
                                                        )
                                                      : Container();
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}