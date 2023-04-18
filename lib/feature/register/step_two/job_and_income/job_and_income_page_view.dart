import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/information_dialog/information_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog.dart';
import 'package:neo_bank/ui/molecules/register/add_income_widget.dart';
import 'package:neo_bank/ui/molecules/register/additional_income_source_widget.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class JobAndIncomePageView extends BasePageViewWidget<JobAndIncomePageViewModel> {
  JobAndIncomePageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: AppStreamBuilder<bool>(
      stream: model.errorDetectorStream,
      initialData: false,
      dataBuilder: (context, error) {
        return ShakeAnimatedWidget(
          enabled: error ?? false,
          duration: Duration(milliseconds: 100),
          shakeAngle: Rotation.deg(z: 1),
          curve: Curves.easeInOutSine,
          child: AppStreamBuilder<Resource<SaveJobDetailsResponse>>(
            stream: model.jobAndIncomeStream,
            initialData: Resource.none(),
            onData: (data) {
              if (data.status == Status.SUCCESS) {
                Future.delayed(Duration(milliseconds: 500), () {
                  ProviderScope.containerOf(context)
                      .read(registerViewModelProvider)
                      .registrationStepsController
                      .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                });
              } else if (data.status == Status.ERROR) {
                model.showToastWithError(data.appError!);
              }
            },
            dataBuilder: (context, response) {
              return GestureDetector(
                onHorizontalDragEnd: (details) {
                  FocusScope.of(context).unfocus();
                  if (StringUtils.isDirectionRTL(context)) {
                    if (!details.primaryVelocity!.isNegative) {
                      model.validateJobAndIncomeDetails();
                    }
                  } else {
                    if (details.primaryVelocity!.isNegative) {
                      model.validateJobAndIncomeDetails();
                    }
                  }
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom - 50.h <= 0
                            ? 0
                            : MediaQuery.of(context).viewInsets.bottom - 48.h),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Visibility(
                            visible: model.employmentStatusEnum == EmploymentStatusEnum.FULL_TIME_EMPLOYEE ||
                                model.employmentStatusEnum == EmploymentStatusEnum.PART_TIME_EMPLOYEE ||
                                model.employmentStatusEnum == EmploymentStatusEnum.OTHER,
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText: S.of(context).occupation,
                                  hintText: S.of(context).pleaseEnter,
                                  controller: model.occupationController,
                                  inputType: TextInputType.text,
                                  inputAction: TextInputAction.go,
                                  // readOnly: true,
                                  key: model.occupationKey,
                                  // onPressed: () {
                                  //   OccupationDialog.show(context,
                                  //       employmentStatusEnum:
                                  //           model.employmentStatusEnum,
                                  //       title: S.of(context).occupationSmall,
                                  //       onDismissed: () {
                                  //     Navigator.pop(context);
                                  //   }, onSelected: (data) {
                                  //     Navigator.pop(context);
                                  //     model.occupationController.text = data;
                                  //     model.isValid();
                                  //   },
                                  //       businessTypeList:
                                  //           model.businessTypeList);
                                  // },
                                  // suffixIcon: (value, data) {
                                  //   return Container(
                                  //       height: 16,
                                  //       width: 16,
                                  //       padding: EdgeInsets.only(right: 8),
                                  //       child: AppSvg.asset(
                                  //           AssetUtils.downArrow,
                                  //           color: AppColor.dark_gray_1));
                                  // },
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: model.employmentStatusEnum == EmploymentStatusEnum.BUSINESS_OWNER,
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText: S.of(context).businessType.toUpperCase(),
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.businessTypeController,
                                  readOnly: true,
                                  key: model.businessTypeKey,
                                  onPressed: () {
                                    OccupationDialog.show(context,
                                        employmentStatusEnum: model.employmentStatusEnum,
                                        title: S.of(context).businessType, onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (data, englishValue) {
                                      Navigator.pop(context);
                                      model.businessTypeEnglishValue = englishValue;
                                      model.businessTypeController.text = data;
                                      model.updateBusinessTypeOtherVisibility();
                                      model.isValid();
                                    }, businessTypeList: model.businessTypeList);
                                  },
                                  suffixIcon: (value, data) {
                                    return Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsetsDirectional.only(end: 8.w),
                                        child:
                                            AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                  },
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                              ],
                            ),
                          ),
                          AppStreamBuilder<bool>(
                            stream: model.businessTypeOtherVisibilityStream,
                            initialData: false,
                            dataBuilder: (context, isVisible) {
                              return Visibility(
                                visible: isVisible!,
                                child: Column(
                                  children: [
                                    AppTextField(
                                      labelText: S.of(context).pleaseSpecify,
                                      hintText: S.of(context).pleaseEnter,
                                      controller: model.businessTypeOtherController,
                                      inputType: TextInputType.text,
                                      inputAction: TextInputAction.go,
                                      key: model.businessTypeOtherKey,
                                      onChanged: (value) {
                                        model.isValid();
                                      },
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppTextField(
                            labelText: S.of(context).monthlyIncome,
                            hintText: '',
                            controller: model.annualIncomeController,
                            key: model.annualIncomeKey,
                            inputType: TextInputType.numberWithOptions(decimal: true),
                            inputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                            ],
                            prefixIcon: () {
                              return Padding(
                                padding: EdgeInsetsDirectional.only(top: 8.0.h, end: 8.w),
                                child: Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontFamily: StringUtils.appFont,
                                      fontSize: 14.t,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryTextTheme.bodyText1!.color!),
                                ),
                              );
                            },
                            onChanged: (value) {
                              model.isValid();
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerName,
                            hintText: S.of(context).pleaseEnter,
                            controller: model.employerNameController,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.go,
                            key: model.employerNameKey,
                            onChanged: (value) {
                              model.isValid();
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerCountry,
                            hintText: S.of(context).pleaseSelect,
                            controller: model.employerCountryController,
                            readOnly: true,
                            key: model.employerCountryKey,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              Future.delayed(Duration(milliseconds: 500), () {
                                CountryDialog.show(context, title: S.of(context).employerCountrySmall,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updateEmployerCountry(
                                      value.countryName!, value.countryEnglishName ?? '');
                                  model.getCitiesByCountry(isoCode: value.isoCode3 ?? "");
                                  model.isValid();
                                });
                              });
                            },
                            suffixIcon: (value, data) {
                              return Container(
                                  height: 16.h,
                                  width: 16.w,
                                  padding: EdgeInsetsDirectional.only(end: 8.w),
                                  child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),

                          AppStreamBuilder<Resource<CityListResponse>>(
                              initialData: Resource.none(),
                              stream: model.getCitiesByCountryResponseStream,
                              dataBuilder: (context, cityList) {
                                return AppTextField(
                                  labelText: S.of(context).employerCity,
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.employerCityController,
                                  readOnly: true,
                                  key: model.employerCityKey,
                                  onPressed: () {
                                    if (model.employerCountryController.text.isEmpty) {
                                      model.employerCountryKey.currentState!.isValid = false;
                                      model.showToastWithError(AppError(
                                          cause: Exception(),
                                          error: ErrorInfo(message: ''),
                                          type: ErrorType.INVALID_COUNTRY));
                                    } else {
                                      FocusScope.of(context).unfocus();
                                      Future.delayed(Duration(milliseconds: 500), () {
                                        StateCityDialog.show(context, title: S.of(context).employerCitySmall,
                                            onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: (value) {
                                          Navigator.pop(context);
                                          model.employerCityController.text = value.cityName!;
                                          model.currentCity = value;
                                          model.isValid();
                                        },
                                            stateCityTypeEnum: StateCityTypeEnum.CITY,
                                            stateCityData: cityList!.status == Status.SUCCESS
                                                ? cityList.data!.cityContent!.stateData!
                                                : []);
                                      });
                                    }
                                  },
                                  suffixIcon: (value, data) {
                                    return Container(
                                        height: 16.h,
                                        width: 16.w,
                                        padding: EdgeInsetsDirectional.only(end: 8.w),
                                        child:
                                            AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                                  },
                                );
                              }),

                          //*OLD EMPLOYER_CITY FIELD

                          // AppTextField(
                          //   labelText: S.of(context).employerCity,
                          //   hintText: S.of(context).pleaseEnter,
                          //   controller: model.employerCityController,
                          //   inputFormatters: [
                          //     LengthLimitingTextInputFormatter(60),
                          //   ],
                          //   inputType: TextInputType.text,
                          //   inputAction: TextInputAction.go,
                          //   key: model.employerCityKey,
                          //   onChanged: (value) {
                          //     model.isValid();
                          //   },
                          // ),

                          SizedBox(
                            height: 16.h,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerContact,
                            hintText: S.of(context).pleaseEnter,
                            inputType: TextInputType.phone,
                            inputAction: TextInputAction.done,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(14),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: model.employerContactController,
                            key: model.employerContactKey,
                            onChanged: (value) {
                              model.isValid();
                            },
                          ),
                          AppStreamBuilder<bool>(
                            stream: model.switchValue,
                            initialData: false,
                            dataBuilder: (context, isActive) {
                              return Padding(
                                padding: EdgeInsets.only(top: 32.0.h),
                                child: Column(
                                  children: [
                                    AppSwitchLabelWidget(
                                      label: S.of(context).doYouHaveAdditionalSourceOfIncome,
                                      inActiveText: S.of(context).no.toUpperCase(),
                                      activeText: S.of(context).yes.toUpperCase(),
                                      onToggle: (value) {
                                        model.updateSwitchValue(value);
                                      },
                                      isActive: isActive,
                                    ),
                                    Visibility(
                                      visible: isActive!,
                                      child: AppStreamBuilder<List<AdditionalIncomeType>>(
                                        stream: model.additionalSourceIncomeListStream,
                                        initialData: [],
                                        dataBuilder: (context, dataList) {
                                          if (dataList!.isNotEmpty) {
                                            return ListView.builder(
                                                itemCount: dataList.length + 1,
                                                physics: ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  if (index == dataList.length) {
                                                    return AddIncomeWidget(
                                                      label: S.of(context).addIncome,
                                                      onTap: () {
                                                        AdditionalIncomeSourceDialog.show(context,
                                                            onDismissed: () {
                                                          Navigator.pop(context);
                                                        }, onSelected: (value) {
                                                          if (value.totalIncome!.isEmpty) {
                                                            model.showToastWithError(AppError(
                                                                type: ErrorType.EMPTY_INCOME,
                                                                cause: Exception(),
                                                                error: ErrorInfo(message: '')));
                                                          } else if (!(num.parse(value.totalIncome!) > 0)) {
                                                            model.showToastWithError(AppError(
                                                                type: ErrorType
                                                                    .INVALID_ADDITIONAL_SOURCE_INCOME_VALUE,
                                                                cause: Exception(),
                                                                error: ErrorInfo(message: '')));
                                                          } else {
                                                            Navigator.pop(context);
                                                            model.addAdditionalIncomeList(value);
                                                          }
                                                        });
                                                      },
                                                    );
                                                  }
                                                  return AdditionalIncomeSourceWidget(
                                                    additionalIncomeSourceParams: dataList[index],
                                                    onTap: () {
                                                      model.removeAdditionalItem(index);
                                                    },
                                                  );
                                                });
                                          } else {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 16.0.h),
                                              child: AddIncomeWidget(
                                                label: S.of(context).addIncome,
                                                onTap: () {
                                                  InformationDialog.show(context,
                                                      title: S.of(context).additionalIncome,
                                                      isSwipeToCancel: false, onSelected: () {
                                                    Navigator.pop(context);
                                                    AdditionalIncomeSourceDialog.show(context,
                                                        onDismissed: () {
                                                      Navigator.pop(context);
                                                    }, onSelected: (value) {
                                                      if (value.totalIncome!.isEmpty) {
                                                        model.showToastWithError(AppError(
                                                            type: ErrorType.EMPTY_INCOME,
                                                            cause: Exception(),
                                                            error: ErrorInfo(message: '')));
                                                      } else if (!(num.parse(value.totalIncome!) > 0)) {
                                                        model.showToastWithError(AppError(
                                                            type: ErrorType
                                                                .INVALID_ADDITIONAL_SOURCE_INCOME_VALUE,
                                                            cause: Exception(),
                                                            error: ErrorInfo(message: '')));
                                                      } else {
                                                        Navigator.pop(context);
                                                        model.addAdditionalIncomeList(value);
                                                      }
                                                    });
                                                  },
                                                      descriptionWidget: Text.rich(TextSpan(
                                                          text: S.of(context).additionalIncomePopUpDesc1,
                                                          style: TextStyle(
                                                              fontFamily: StringUtils.appFont,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 14.t,
                                                              height: 1.4,
                                                              color: Theme.of(context)
                                                                  .inputDecorationTheme
                                                                  .focusedBorder!
                                                                  .borderSide
                                                                  .color),
                                                          children: [
                                                            TextSpan(
                                                                text: S.of(context).annual,
                                                                style: TextStyle(
                                                                    fontFamily: StringUtils.appFont,
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 14.t,
                                                                    color: Theme.of(context)
                                                                        .inputDecorationTheme
                                                                        .focusedBorder!
                                                                        .borderSide
                                                                        .color),
                                                                children: [
                                                                  TextSpan(
                                                                    text: S
                                                                        .of(context)
                                                                        .additionalIncomePopUpDesc2,
                                                                    style: TextStyle(
                                                                        fontFamily: StringUtils.appFont,
                                                                        fontWeight: FontWeight.w400,
                                                                        fontSize: 14.t,
                                                                        color: Theme.of(context)
                                                                            .inputDecorationTheme
                                                                            .focusedBorder!
                                                                            .borderSide
                                                                            .color),
                                                                  )
                                                                ])
                                                          ])));
                                                },
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 32.h),
                              child: AppStreamBuilder<bool>(
                                  stream: model.allFieldValidatorStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return (isValid!)
                                        ? AnimatedButton(
                                            buttonText: S.of(context).swipeToProceed,
                                            buttonHeight: 50,
                                          )
                                        : Container();
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ));
  }
}
