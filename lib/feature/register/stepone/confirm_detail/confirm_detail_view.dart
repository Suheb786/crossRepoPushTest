import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/user/save_id_info_response.dart';
import 'package:domain/model/user/scanned_document_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/date_picker.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';
import 'package:neo_bank/utils/time_utils.dart';

class ConfirmDetailView extends BasePageViewWidget<ConfirmDetailViewModel> {
  ConfirmDetailView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, ConfirmDetailViewModel model) {
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
              child: AppStreamBuilder<Resource<SaveIdInfoResponse>>(
                  stream: model.confirmDetailResponseStream,
                  initialData: Resource.none(),
                  onData: (data) async {
                    if (data.status == Status.SUCCESS) {
                      model.nameKey.currentState!.isValid = true;
                      model.idNumberKey.currentState!.isValid = true;
                      model.dobKey.currentState!.isValid = true;
                      model.nationalityKey.currentState!.isValid = true;
                      model.expiryDateKey.currentState!.isValid = true;
                      model.genderKey.currentState!.isValid = true;
                      model.motherNameKey.currentState!.isValid = true;

                      final isImageUpload = await Navigator.pushNamed(context, RoutePaths.Capture);

                      if (isImageUpload != null && (isImageUpload as bool)) {
                        Future.delayed(Duration(milliseconds: 500), () {
                          ProviderScope.containerOf(context)
                              .read(registerStepOneViewModelProvider)
                              .nextPage();
                          // .next();
                        });
                      } else {
                        model.showToastWithError(AppError(
                          error: ErrorInfo(message: ''),
                          type: ErrorType.IMAGE_UPLOAD_ERROR,
                          cause: Exception(),
                        ));
                      }
                    } else if (data.status == Status.ERROR) {
                      if (data.appError!.type == ErrorType.EMPTY_NAME) {
                        model.nameKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.EMPTY_ID_NUMBER) {
                        model.idNumberKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.EMPTY_DATE_OF_BIRTH) {
                        model.dobKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.EMPTY_NATIONALITY) {
                        model.nationalityKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.EMPTY_EXPIRY_DATE) {
                        model.expiryDateKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.EMPTY_MOTHER_NAME) {
                        model.motherNameKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.INVALID_LEGAL_DOCUMENT) {
                        model.legalDocumentKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.INVALID_ISSUING_DATE) {
                        model.issuingDateKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.INVALID_ISSUING_PLACE) {
                        model.issuingPlaceKey.currentState!.isValid = false;
                      } else if (data.appError!.type == ErrorType.INVALID_DECLARATION_SELECTION) {
                        model.showErrorState();
                      } else if (data.appError!.type == ErrorType.EMPTY_GENDER) {
                        model.genderKey.currentState!.isValid = false;
                      }
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, data) {
                    return AppStreamBuilder<Resource<ScannedDocumentInformation>>(
                      stream: model.scanUserDocumentStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.scannedDocumentResult = data.data!;
                          model.setData(model.scannedDocumentResult);
                        }
                      },
                      dataBuilder: (context, scannedData) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(registerStepOneViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                1.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.confirmDetail();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.confirmDetail();
                                }
                              }
                            }
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                      ? 0
                                      : MediaQuery.of(context).viewInsets.bottom - 48.h),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                child: Column(
                                  children: [
                                    AppTextField(
                                      labelText: S.of(context).name,
                                      hintText: S.of(context).nameHint,
                                      inputType: TextInputType.text,
                                      controller: model.nameController,
                                      key: model.nameKey,
                                      textColor: model.isNameReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      readOnly: model.isNameReadOnly,
                                      maxLength: 25,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).nationalId,
                                      hintText: S.of(context).pleaseEnter,
                                      inputType: TextInputType.text,
                                      controller: model.idNumberController,
                                      key: model.idNumberKey,
                                      readOnly: model.isIdNoReadOnly,
                                      textColor: model.isIdNoReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).dob,
                                      hintText: S.of(context).dobHint,
                                      inputType: TextInputType.datetime,
                                      controller: model.dobController,
                                      readOnly: model.isDobReadOnly,
                                      textColor: model.isDobReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      key: model.dobKey,
                                      onChanged: (value) => model.validateDetails(),
                                      suffixIcon: (isvalid, value) {
                                        return IgnorePointer(
                                          ignoring: model.isDobReadOnly,
                                          child: InkWell(
                                              onTap: () {
                                                DatePicker.show(context, initialDate: DateTime.now(),
                                                    onSelected: (date) {
                                                  model.selectedDobDate = date.toString();
                                                  model.dobController.text =
                                                      TimeUtils.getFormattedDOB(date.toString());
                                                  model.validateDetails();
                                                }, onCancelled: () {
                                                  Navigator.pop(context);
                                                }, title: S.of(context).dateOfBirthSmall);
                                              },
                                              child: Container(
                                                  height: 16.h,
                                                  width: 16.w,
                                                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                  child: AppSvg.asset(AssetUtils.calendar,
                                                      color: Theme.of(context).primaryColorDark))),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).placeOfBirth.toUpperCase(),
                                      hintText: S.of(context).pleaseSelect,
                                      inputType: TextInputType.text,
                                      readOnly: true,
                                      controller: model.nationalityController,
                                      key: model.nationalityKey,
                                      onPressed: () {
                                        Future.delayed(Duration(milliseconds: 200), () {
                                          CountryDialog.show(context, title: S.of(context).placeOfBirth,
                                              onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.nationalityController.text = value.countryName!;
                                            model.selectedPlaceOfBirth = value;
                                            model.validateDetails();
                                          });
                                        });
                                      },
                                      suffixIcon: (value, data) {
                                        return Container(
                                            height: 16.h,
                                            width: 16.w,
                                            padding: EdgeInsetsDirectional.only(end: 8.w),
                                            child: AppSvg.asset(AssetUtils.downArrow,
                                                color: AppColor.dark_gray_1));
                                      },
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).gender,
                                      hintText: S.of(context).genderHint,
                                      inputType: TextInputType.text,
                                      controller: model.genderController,
                                      readOnly: model.isGenderReadOnly,
                                      textColor: model.isGenderReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      key: model.genderKey,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).motherName,
                                      hintText: S.of(context).motherNameHint,
                                      inputType: TextInputType.text,
                                      readOnly: model.isMotherNameReadOnly,
                                      textColor: model.isMotherNameReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      controller: model.motherNameController,
                                      key: model.motherNameKey,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).legalDocumentNo,
                                      hintText: S.of(context).pleaseEnter,
                                      inputType: TextInputType.text,
                                      readOnly: model.isLegalDocumentReadOnly,
                                      textColor: model.isLegalDocumentReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      controller: model.legalDocumentController,
                                      key: model.legalDocumentKey,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).issuingDate.toUpperCase(),
                                      hintText: S.of(context).dobHint,
                                      inputType: TextInputType.datetime,
                                      controller: model.issuingDateController,
                                      textColor: model.isIssuingDateReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      readOnly: model.isIssuingDateReadOnly,
                                      key: model.issuingDateKey,
                                      onChanged: (value) => model.validateDetails(),
                                      suffixIcon: (isvalid, value) {
                                        return IgnorePointer(
                                          ignoring: model.isIssuingDateReadOnly,
                                          child: InkWell(
                                              onTap: () {
                                                DatePicker.show(context, initialDate: DateTime.now(),
                                                    onSelected: (date) {
                                                  model.selectedIssuingDate = date.toString();
                                                  model.issuingDateController.text =
                                                      TimeUtils.getFormattedDOB(date.toString());
                                                  model.validateDetails();
                                                }, onCancelled: () {
                                                  Navigator.pop(context);
                                                }, title: S.of(context).issuingDate);
                                              },
                                              child: Container(
                                                  height: 16.h,
                                                  width: 16.w,
                                                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                  child: AppSvg.asset(AssetUtils.calendar,
                                                      color: Theme.of(context).primaryColorDark))),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).expiryDate,
                                      hintText: S.of(context).dobHint,
                                      inputType: TextInputType.text,
                                      controller: model.expiryDateController,
                                      readOnly: model.isExpiryDateReadOnly,
                                      textColor: model.isExpiryDateReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      key: model.expiryDateKey,
                                      onChanged: (value) => model.validateDetails(),
                                      suffixIcon: (isvalid, value) {
                                        return IgnorePointer(
                                          ignoring: model.isExpiryDateReadOnly,
                                          child: InkWell(
                                              onTap: () {
                                                DatePicker.show(context,
                                                    initialDate: DateTime.now(),
                                                    lastDate: DateTime.now(), onSelected: (date) {
                                                  model.selectedExpiryDate = date.toString();
                                                  model.expiryDateController.text =
                                                      TimeUtils.getFormattedDOB(date.toString());
                                                  model.validateDetails();
                                                }, onCancelled: () {
                                                  Navigator.pop(context);
                                                }, title: S.of(context).expiryDate);
                                              },
                                              child: Container(
                                                  height: 16.h,
                                                  width: 16.w,
                                                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                                                  child: AppSvg.asset(AssetUtils.calendar,
                                                      color: Theme.of(context).primaryColorDark))),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).issuingPlace.toUpperCase(),
                                      hintText: S.of(context).pleaseEnter,
                                      maxLines: 5,
                                      inputType: TextInputType.text,
                                      readOnly: true,
                                      textColor: model.isIssuingPlaceReadOnly
                                          ? Theme.of(context).inputDecorationTheme.hintStyle!.color
                                          : Theme.of(context).primaryColorDark,
                                      onPressed: !model.isIssuingPlaceReadOnly
                                          ? () {
                                              Future.delayed(Duration(milliseconds: 200), () {
                                                CountryDialog.show(context,
                                                    title: S.of(context).residentCountrySmall,
                                                    onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.issuingPlaceController.text = value.countryName!;
                                                  model.selectedIssuingPlace = value;
                                                  model.validateDetails();
                                                });
                                              });
                                            }
                                          : () {},
                                      suffixIcon: (value, data) {
                                        return Container(
                                            height: 16.h,
                                            width: 16.w,
                                            padding: EdgeInsetsDirectional.only(end: 8.w),
                                            child: AppSvg.asset(AssetUtils.downArrow,
                                                color: AppColor.dark_gray_1));
                                      },
                                      controller: model.issuingPlaceController,
                                      key: model.issuingPlaceKey,
                                      onChanged: (value) => model.validateDetails(),
                                    ),
                                    SizedBox(
                                      height: 24.h,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          model.fetchAllowedIssuers();
                                        },
                                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                                        child: Text(
                                          S.of(context).scanIDAgain,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: StringUtils.appFont,
                                              fontSize: 14.t,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).textTheme.bodyMedium!.color!),
                                        )),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    Row(
                                      children: [
                                        AppStreamBuilder<bool>(
                                            stream: model.declarationSelectedStream,
                                            initialData: false,
                                            dataBuilder: (context, isChecked) {
                                              return InkWell(
                                                onTap: () {
                                                  model.updateDeclarationValue(!(isChecked!));
                                                  model.validateDetails();
                                                },
                                                child: Container(
                                                  height: 40.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: isChecked!
                                                          ? Theme.of(context).canvasColor
                                                          : Colors.transparent,
                                                      border: Border.all(
                                                          color: Theme.of(context)
                                                              .inputDecorationTheme
                                                              .hintStyle!
                                                              .color!)),
                                                  child: isChecked
                                                      ? Container(
                                                          height: 16.h,
                                                          width: 16.w,
                                                          padding: EdgeInsets.symmetric(
                                                              horizontal: 10.w, vertical: 10.h),
                                                          child: AppSvg.asset(
                                                            AssetUtils.checkIcon,
                                                            color: Theme.of(context).primaryColorDark,
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                              );
                                            }),
                                        SizedBox(
                                          width: 16.h,
                                        ),
                                        Expanded(
                                          child: Text(
                                            S.of(context).confirmDetailsConfirmation,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.t),
                                          ),
                                        )
                                      ],
                                    ),
                                    AppStreamBuilder<bool>(
                                        stream: model.showButtonStream,
                                        initialData: false,
                                        dataBuilder: (context, isValid) {
                                          return Padding(
                                            padding: EdgeInsets.only(top: 26.0.h),
                                            child: Visibility(
                                              visible: isValid!,
                                              child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
                                            ),
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
    );
  }
}
