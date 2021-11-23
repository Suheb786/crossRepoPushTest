import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';

class ConfirmDetailView extends BasePageViewWidget<ConfirmDetailViewModel> {
  ConfirmDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ConfirmDetailViewModel model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
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
                    child: AppStreamBuilder<Resource<SaveIdInfoResponse>>(
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
                                .read(registerStepOneViewModelProvider)
                                .pageController
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
                            } else if (data.appError!.type ==
                                ErrorType.INVALID_LEGAL_DOCUMENT) {
                              model.legalDocumentKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.INVALID_ISSUING_DATE) {
                              model.issuingDateKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.INVALID_ISSUING_PLACE) {
                              model.issuingPlaceKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.INVALID_DECLARATION_SELECTION) {
                              model.showErrorState();
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_GENDER) {
                              model.genderKey.currentState!.isValid = false;
                            }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return AppStreamBuilder<
                              Resource<ScannedDocumentInformation>>(
                            stream: model.scanUserDocumentStream,
                            initialData: Resource.none(),
                            onData: (data) {
                              if (data.status == Status.SUCCESS) {
                                model.scannedDocumentResult = data.data!;
                              }
                            },
                            dataBuilder: (context, scannedData) {
                              return GestureDetector(
                                onHorizontalDragEnd: (details) {
                                  if (details.primaryVelocity!.isNegative) {
                                    model.confirmDetail();
                                  } else {
                                    ProviderScope.containerOf(context)
                                        .read(registerStepOneViewModelProvider)
                                        .pageController
                                        .previousPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeInOut);
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 2,
                                  color: Theme.of(context)
                                      .cardTheme
                                      .copyWith(color: AppColor.white)
                                      .color,
                                  margin: EdgeInsets.zero,
                                  shadowColor: Theme.of(context)
                                      .primaryColorDark
                                      .withOpacity(0.32),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 32, horizontal: 24),
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
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S.of(context).nationalId,
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.idNumberController,
                                            key: model.idNumberKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
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
                                            suffixIcon: (isvalid, value) {
                                              return InkWell(
                                                  onTap: () {
                                                    DatePicker.show(context,
                                                        onSelected: (date) {
                                                      model.selectedDobDate =
                                                          date;
                                                      model.dobController.text =
                                                          TimeUtils
                                                              .getFormattedDOB(
                                                                  date);
                                                      model.validateDetails();
                                                    }, onCancelled: () {
                                                      Navigator.pop(context);
                                                    },
                                                        title: S
                                                            .of(context)
                                                            .dateOfBirthSmall);
                                                  },
                                                  child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7),
                                                      child: AppSvg.asset(
                                                          AssetUtils.calendar,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark)));
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S
                                                .of(context)
                                                .placeOfBirth
                                                .toUpperCase(),
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.nationalityController,
                                            key: model.nationalityKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
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
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S.of(context).motherName,
                                            hintText:
                                                S.of(context).motherNameHint,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.motherNameController,
                                            key: model.motherNameKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText:
                                                S.of(context).legalDocumentNo,
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.legalDocumentController,
                                            key: model.legalDocumentKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S
                                                .of(context)
                                                .issuingDate
                                                .toUpperCase(),
                                            hintText: S.of(context).dobHint,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.issuingDateController,
                                            key: model.issuingDateKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
                                            suffixIcon: (isvalid, value) {
                                              return InkWell(
                                                  onTap: () {
                                                    DatePicker.show(context,
                                                        onSelected: (date) {
                                                      model.selectedIssuingDate =
                                                          date;
                                                      model.issuingDateController
                                                              .text =
                                                          TimeUtils
                                                              .getFormattedDOB(
                                                                  date);
                                                      model.validateDetails();
                                                    }, onCancelled: () {
                                                      Navigator.pop(context);
                                                    },
                                                        title: S
                                                            .of(context)
                                                            .issuingDate);
                                                  },
                                                  child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7),
                                                      child: AppSvg.asset(
                                                          AssetUtils.calendar,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark)));
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S.of(context).expiryDate,
                                            hintText: S.of(context).dobHint,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.expiryDateController,
                                            key: model.expiryDateKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
                                            suffixIcon: (isvalid, value) {
                                              return InkWell(
                                                  onTap: () {
                                                    DatePicker.show(context,
                                                        onSelected: (date) {
                                                      model.selectedExpiryDate =
                                                          date;
                                                      model.expiryDateController
                                                              .text =
                                                          TimeUtils
                                                              .getFormattedDOB(
                                                                  date);
                                                      model.validateDetails();
                                                    }, onCancelled: () {
                                                      Navigator.pop(context);
                                                    },
                                                        title: S
                                                            .of(context)
                                                            .expiryDate);
                                                  },
                                                  child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7),
                                                      child: AppSvg.asset(
                                                          AssetUtils.calendar,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColorDark)));
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText: S
                                                .of(context)
                                                .issuingPlace
                                                .toUpperCase(),
                                            hintText: S.of(context).pleaseEnter,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.issuingPlaceController,
                                            key: model.issuingPlaceKey,
                                            onChanged: (value) =>
                                                model.validateDetails(),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          SizedBox(
                                            height: 24,
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                S.of(context).scanIDAgain,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .accentTextTheme
                                                        .bodyText1!
                                                        .color!),
                                              )),
                                          SizedBox(
                                            height: 34,
                                          ),
                                          Row(
                                            children: [
                                              AppStreamBuilder<bool>(
                                                  stream: model
                                                      .declarationSelectedStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isChecked) {
                                                    return InkWell(
                                                      onTap: () {
                                                        model
                                                            .updateDeclarationValue(
                                                                !(isChecked!));
                                                        model.validateDetails();
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: isChecked!
                                                                ? Theme.of(
                                                                        context)
                                                                    .accentTextTheme
                                                                    .bodyText1!
                                                                    .color!
                                                                : Colors
                                                                    .transparent,
                                                            border: Border.all(
                                                                color: !isChecked
                                                                    ? Theme.of(
                                                                            context)
                                                                        .accentTextTheme
                                                                        .bodyText1!
                                                                        .color!
                                                                    : Colors
                                                                        .transparent)),
                                                        child: isChecked
                                                            ? Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                child: AppSvg
                                                                    .asset(
                                                                  AssetUtils
                                                                      .checkIcon,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .accentColor,
                                                                ),
                                                              )
                                                            : Container(),
                                                      ),
                                                    );
                                                  }),
                                              SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  S
                                                      .of(context)
                                                      .confirmDetailsConfirmation,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                              )
                                            ],
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
                                                  child: AnimatedButton(
                                                      buttonText: S
                                                          .of(context)
                                                          .swipeToProceed),
                                                );
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
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
