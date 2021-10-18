import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/job_and_income/job_and_income_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class JobAndIncomePageView
    extends BasePageViewWidget<JobAndIncomePageViewModel> {
  JobAndIncomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Text(
          S.of(context).jobAndIncome,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).tellUsHowDoMakeLiving,
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
                  stream: model.jobAndIncomeStream,
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
                          model.validateJobAndIncomeDetails();
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
                                    labelText: S.of(context).occupation,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.occupationController,
                                    key: model.occupationKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).mainSourceOfIncome,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.sourceController,
                                    inputType: TextInputType.text,
                                    inputAction: TextInputAction.go,
                                    key: model.sourceKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
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
                                    labelText: S.of(context).mainAnnualIncome,
                                    hintText: '',
                                    controller: model.annualIncomeController,
                                    key: model.annualIncomeKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
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
                                    labelText: S.of(context).employerName,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.employerNameController,
                                    inputType: TextInputType.text,
                                    inputAction: TextInputAction.go,
                                    key: model.employerNameKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
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
                                    labelText: S.of(context).employerCountry,
                                    hintText: S.of(context).pleaseSelect,
                                    controller: model.employerCountryController,
                                    readOnly: true,
                                    key: model.employerCountryKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
                                            ),
                                          ),
                                        ),
                                      );
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
                                            model.updateEmployerCountry(value);
                                            model.isValid();
                                          });
                                        },
                                        child: Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.only(right: 8),
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
                                    controller: model.employerCityController,
                                    inputType: TextInputType.text,
                                    inputAction: TextInputAction.go,
                                    key: model.employerCityKey,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
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
                                    labelText: S.of(context).employerContact,
                                    hintText: S.of(context).pleaseEnter,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    textHintWidget: (hasFocus, isValid, value) {
                                      return Visibility(
                                        visible: !isValid,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 8),
                                            child: Text(
                                              ErrorParser
                                                  .getLocalisedStringError(
                                                      error: response!.appError,
                                                      localisedHelper:
                                                          S.of(context)),
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColor.vivid_red),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    controller: model.employerContactController,
                                    key: model.employerContactKey,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  AppStreamBuilder<bool>(
                                    stream: model.switchValue,
                                    initialData: false,
                                    dataBuilder: (context, isActive) {
                                      return Column(
                                        children: [
                                          AppSwitchLabelWidget(
                                            label: S
                                                .of(context)
                                                .doYouHaveAdditionalSourceOfIncome,
                                            inActiveText: S.of(context).no,
                                            activeText: S.of(context).yes,
                                            onToggle: (value) {
                                              model.updateSwitchValue(value);
                                            },
                                            isActive: isActive,
                                          ),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Visibility(
                                              visible: isActive!,
                                              child: InkWell(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color: AppColor
                                                              .soft_violet,
                                                          width: 1)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        S.of(context).addIncome,
                                                        style: TextStyle(
                                                            color: AppColor
                                                                .vivid_orange,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Icon(
                                                        Icons.add,
                                                        size: 16,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ))
                                        ],
                                      );
                                    },
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(top: 32, right: 32),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.allFieldValidatorStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
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
    ));
  }
}
