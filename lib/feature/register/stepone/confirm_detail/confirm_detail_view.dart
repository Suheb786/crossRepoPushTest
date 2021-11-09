import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/confirm_detail/confirm_detail_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/bottom_sheet/date_picker_bottom_sheet/date_picker_bottom_sheet.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_one/calendar_dialog/calendar_dialog.dart';
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
                                ErrorType.INVALID_DECLARATION_SELECTION) {
                              model.showErrorState();
                            } else {
                              model.genderKey.currentState!.isValid = false;
                            }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.confirmDetail();
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
                              elevation: 2,
                              margin: EdgeInsets.zero,
                              shadowColor: AppColor.black.withOpacity(0.32),
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
                                                DatePickerBottomSheet.show(
                                                    context,
                                                    onDateSelected: (date) {
                                                  Navigator.pop(context);
                                                  model.dobController.text =
                                                      TimeUtils.getFormattedDOB(
                                                          date);
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: AppSvg.asset(
                                                      AssetUtils.calendar)));
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
                                        readOnly: true,
                                        onChanged: (value) =>
                                            model.validateDetails(),
                                        suffixIcon: (isvalid, value) {
                                          return InkWell(
                                              onTap: () {
                                                CalendarDialog.show(context,
                                                    initialDateTime: model
                                                        .selectedExpiryDate,
                                                    title: S
                                                        .of(context)
                                                        .dateOfBirthSmall,
                                                    onSelected: (date) {
                                                  Navigator.pop(context);
                                                  model.selectedExpiryDate =
                                                      date;
                                                  model.expiryDateController
                                                          .text =
                                                      TimeUtils
                                                          .getFormattedDate(
                                                              date.toString());
                                                }, onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onHeaderTapped: (date) {});
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: AppSvg.asset(
                                                      AssetUtils.calendar)));
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
                                                color: AppColor.vivid_orange),
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
                                                  child: isChecked == false
                                                      ? AppSvg.asset(
                                                          AssetUtils.ellipse)
                                                      : AppSvg.asset(
                                                          AssetUtils.checkBox),
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
                                                  color: AppColor
                                                      .very_light_gray_white,
                                                  fontWeight: FontWeight.w600,
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
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(right: 45),
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
