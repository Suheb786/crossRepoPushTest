import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/country/state_list/state_city_data.dart';
import 'package:domain/model/country/state_list/state_list_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/button/app_primary_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaUSRelevantW8AddressDetailsPageView
    extends BasePageViewWidget<FatcaUSRelevantW8AddressDetailsPageViewModel> {
  FatcaUSRelevantW8AddressDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
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
                child: AppStreamBuilder<Resource<CityListResponse>>(
                    stream: model.getCityListResponseStream,
                    initialData: Resource.none(),
                    dataBuilder: (context, cityResponse) {
                      return AppStreamBuilder<Resource<StateListResponse>>(
                          stream: model.getStateListResponseStream,
                          initialData: Resource.none(),
                          dataBuilder: (context, stateResponse) {
                            return AppStreamBuilder<Resource<bool>>(
                              stream: model.fatcaUSRelevantW8AddressDetailsStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  model.updateData(context);
                                  Future.delayed(Duration(milliseconds: 500), () {
                                    ProviderScope.containerOf(context)
                                        .read(registerStepFourViewModelProvider)
                                        .nextPage();
                                    // .next();
                                  });
                                } else if (data.status == Status.ERROR) {
                                  model.showToastWithError(data.appError!);
                                }
                              },
                              dataBuilder: (context, response) {
                                return Card(
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
                                            AppTextField(
                                              labelText:
                                                  S.of(context).permanentResidentAddressLine.toUpperCase(),
                                              hintText: S.of(context).pleaseEnter,
                                              controller: model.permanentAddressController,
                                              key: model.permanentAddressKey,
                                              inputAction: TextInputAction.go,
                                              onChanged: (value) {
                                                model.isValid();
                                              },
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).country,
                                              hintText: S.of(context).pleaseSelect,
                                              controller: model.countryController,
                                              key: model.countryKey,
                                              readOnly: true,
                                              onPressed: () {
                                                FocusScope.of(context).unfocus();
                                                Future.delayed(Duration(milliseconds: 200), () {
                                                  CountryDialog.show(context,
                                                      title: S.of(context).taxCountrySmall, onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.countryController.text = value.countryName!;
                                                    model.stateController.clear();
                                                    model.cityController.clear();
                                                    model.getStateList(value.isoCode3!);
                                                    model.isValid();
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
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).state,
                                              hintText: S.of(context).pleaseSelect,
                                              controller: model.stateController,
                                              key: model.stateKey,
                                              readOnly: true,
                                              onPressed: () {
                                                if (model.countryController.text.isEmpty) {
                                                  model.countryKey.currentState!.isValid = false;
                                                  model.showToastWithError(AppError(
                                                      cause: Exception(),
                                                      error: ErrorInfo(message: ''),
                                                      type: ErrorType.INVALID_COUNTRY));
                                                } else {
                                                  StateCityDialog.show(context,
                                                      title: S.of(context).stateSmall, onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.stateController.text = value.stateName!;
                                                    model.cityController.clear();
                                                    model.getCityList(value.countryId!, value.stateId!);
                                                    model.isValid();
                                                  },
                                                      stateCityTypeEnum: StateCityTypeEnum.STATE,
                                                      stateCityData:
                                                          stateResponse!.data!.stateContent!.stateData!);
                                                }
                                              },
                                              suffixIcon: (value, data) {
                                                return Container(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    padding: EdgeInsetsDirectional.only(end: 8.w),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: AppColor.dark_gray_1));
                                              },
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).city,
                                              hintText: S.of(context).pleaseSelect,
                                              controller: model.cityController,
                                              key: model.cityKey,
                                              readOnly: true,
                                              onPressed: () {
                                                if (model.stateController.text.isEmpty) {
                                                  model.stateKey.currentState!.isValid = false;
                                                  model.showToastWithError(AppError(
                                                      cause: Exception(),
                                                      error: ErrorInfo(message: ''),
                                                      type: ErrorType.INVALID_STATE));
                                                } else {
                                                  StateCityDialog.show(context,
                                                      title: S.of(context).citySmall, onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.cityController.text = value.cityName!;
                                                    model.permanentSelectedStateCity = value;
                                                    model.isValid();
                                                  },
                                                      stateCityTypeEnum: StateCityTypeEnum.CITY,
                                                      stateCityData:
                                                          cityResponse!.data!.cityContent!.stateData!);
                                                }
                                              },
                                              suffixIcon: (value, data) {
                                                return Container(
                                                    height: 16.h,
                                                    width: 16.w,
                                                    padding: EdgeInsetsDirectional.only(end: 8.w),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: AppColor.dark_gray_1));
                                              },
                                            ),
                                            SizedBox(
                                              height: 16.h,
                                            ),
                                            AppTextField(
                                              labelText: S.of(context).postCode,
                                              hintText: S.of(context).pleaseEnter,
                                              controller: model.postCodeController,
                                              key: model.postCodeKey,
                                              inputType: TextInputType.number,
                                              inputAction: TextInputAction.go,
                                              onChanged: (value) {
                                                model.isValid();
                                              },
                                            ),
                                            AppStreamBuilder<bool>(
                                              stream: model.mailingAddressDifferentStream,
                                              initialData: false,
                                              dataBuilder: (context, isActive) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(vertical: 32.0.h),
                                                  child: Column(
                                                    children: [
                                                      AppSwitchLabelWidget(
                                                        label: S
                                                            .of(context)
                                                            .mailingAddressDifferentFromResidence,
                                                        inActiveText: S.of(context).no.toUpperCase(),
                                                        activeText: S.of(context).yes.toUpperCase(),
                                                        onToggle: (value) {
                                                          if (!value) {
                                                            model.differentMailingStateController.clear();
                                                            model.differentMailingCityController.clear();
                                                            model.differentMailingCountryController.clear();
                                                            model.differentMailingPostCodeController.clear();
                                                            model.differentMailingAddressController.clear();
                                                            model.mailingAddressDifferentSelectedStateCity =
                                                                StateCityData();
                                                          }
                                                          model.updateSwitchValue(value);
                                                          model.isValid();
                                                        },
                                                        isActive: isActive,
                                                      ),
                                                      SizedBox(
                                                        height: 16.h,
                                                      ),
                                                      Visibility(
                                                          visible: isActive!,
                                                          child: Column(
                                                            children: [
                                                              AppTextField(
                                                                labelText: S
                                                                    .of(context)
                                                                    .mailingAddressLine
                                                                    .toUpperCase(),
                                                                hintText: S.of(context).pleaseEnter,
                                                                controller:
                                                                    model.differentMailingAddressController,
                                                                key: model.differentMailingAddressKey,
                                                                inputAction: TextInputAction.go,
                                                                onChanged: (value) {
                                                                  model.isValid();
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                              AppTextField(
                                                                labelText: S.of(context).country,
                                                                hintText: S.of(context).pleaseSelect,
                                                                controller:
                                                                    model.differentMailingCountryController,
                                                                key: model.differentMailingCountryKey,
                                                                readOnly: true,
                                                                onPressed: () {
                                                                  FocusScope.of(context).unfocus();
                                                                  Future.delayed(Duration(milliseconds: 200),
                                                                      () {
                                                                    CountryDialog.show(context,
                                                                        title: S.of(context).taxCountrySmall,
                                                                        onDismissed: () {
                                                                      Navigator.pop(context);
                                                                    }, onSelected: (value) {
                                                                      Navigator.pop(context);
                                                                      model.differentMailingCountryController
                                                                          .text = value.countryName!;
                                                                      model.differentMailingCityController
                                                                          .clear();
                                                                      model.differentMailingStateController
                                                                          .clear();
                                                                      model.getStateList(value.isoCode3!);
                                                                      model.isValid();
                                                                    });
                                                                  });
                                                                },
                                                                suffixIcon: (value, data) {
                                                                  return Container(
                                                                      height: 16.h,
                                                                      width: 16.w,
                                                                      padding: EdgeInsetsDirectional.only(
                                                                          end: 8.w),
                                                                      child: AppSvg.asset(
                                                                          AssetUtils.downArrow,
                                                                          color: AppColor.dark_gray_1));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                              AppTextField(
                                                                labelText: S.of(context).state,
                                                                hintText: S.of(context).pleaseSelect,
                                                                controller:
                                                                    model.differentMailingStateController,
                                                                key: model.differentMailingStateKey,
                                                                readOnly: true,
                                                                onPressed: () {
                                                                  if (model.differentMailingCountryController
                                                                      .text.isEmpty) {
                                                                    model.differentMailingCountryKey
                                                                        .currentState!.isValid = false;
                                                                    model.showToastWithError(AppError(
                                                                        cause: Exception(),
                                                                        error: ErrorInfo(message: ''),
                                                                        type: ErrorType.INVALID_COUNTRY));
                                                                  } else {
                                                                    StateCityDialog.show(context,
                                                                        title: S.of(context).stateSmall,
                                                                        onDismissed: () {
                                                                      Navigator.pop(context);
                                                                    }, onSelected: (value) {
                                                                      Navigator.pop(context);
                                                                      model.differentMailingStateController
                                                                          .text = value.stateName!;
                                                                      model.differentMailingCityController
                                                                          .clear();
                                                                      model.getCityList(
                                                                          value.countryId!, value.stateId!);
                                                                      model.isValid();
                                                                    },
                                                                        stateCityTypeEnum:
                                                                            StateCityTypeEnum.STATE,
                                                                        stateCityData: stateResponse!
                                                                            .data!.stateContent!.stateData!);
                                                                  }
                                                                },
                                                                suffixIcon: (value, data) {
                                                                  return Container(
                                                                      height: 16.h,
                                                                      width: 16.w,
                                                                      padding: EdgeInsetsDirectional.only(
                                                                          end: 8.w),
                                                                      child: AppSvg.asset(
                                                                          AssetUtils.downArrow,
                                                                          color: AppColor.dark_gray_1));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                              AppTextField(
                                                                labelText: S.of(context).city,
                                                                hintText: S.of(context).pleaseSelect,
                                                                controller:
                                                                    model.differentMailingCityController,
                                                                key: model.differentMailingCityKey,
                                                                readOnly: true,
                                                                onPressed: () {
                                                                  if (model.differentMailingStateController
                                                                      .text.isEmpty) {
                                                                    model.differentMailingStateKey
                                                                        .currentState!.isValid = false;
                                                                    model.showToastWithError(AppError(
                                                                        cause: Exception(),
                                                                        error: ErrorInfo(message: ''),
                                                                        type: ErrorType.INVALID_STATE));
                                                                  } else {
                                                                    StateCityDialog.show(context,
                                                                        title: S.of(context).citySmall,
                                                                        onDismissed: () {
                                                                      Navigator.pop(context);
                                                                    }, onSelected: (value) {
                                                                      Navigator.pop(context);
                                                                      model.differentMailingCityController
                                                                          .text = value.cityName!;
                                                                      model.mailingAddressDifferentSelectedStateCity =
                                                                          value;
                                                                      model.isValid();
                                                                    },
                                                                        stateCityTypeEnum:
                                                                            StateCityTypeEnum.CITY,
                                                                        stateCityData: cityResponse!
                                                                            .data!.cityContent!.stateData!);
                                                                  }
                                                                },
                                                                suffixIcon: (value, data) {
                                                                  return Container(
                                                                      height: 16.h,
                                                                      width: 16.w,
                                                                      padding: EdgeInsetsDirectional.only(
                                                                          end: 8.w),
                                                                      child: AppSvg.asset(
                                                                          AssetUtils.downArrow,
                                                                          color: AppColor.dark_gray_1));
                                                                },
                                                              ),
                                                              SizedBox(
                                                                height: 16.h,
                                                              ),
                                                              AppTextField(
                                                                labelText: S.of(context).postCode,
                                                                hintText: S.of(context).pleaseEnter,
                                                                controller:
                                                                    model.differentMailingPostCodeController,
                                                                key: model.differentMailingPostCodeKey,
                                                                inputAction: TextInputAction.go,
                                                                onChanged: (value) {
                                                                  model.isValid();
                                                                },
                                                              ),
                                                            ],
                                                          ))
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            Center(
                                              child: Padding(
                                                padding: EdgeInsets.only(top: 24.h),
                                                child: AppStreamBuilder<bool>(
                                                    stream: model.allFieldValidatorStream,
                                                    initialData: false,
                                                    dataBuilder: (context, isValid) {
                                                      return AppPrimaryButton(
                                                        onPressed: () {
                                                          model.validateFatcaUSRelevantW8AddressDetails();
                                                        },
                                                        isDisabled: !isValid!,
                                                      );
                                                    }),
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                );
                              },
                            );
                          });
                    }),
              );
            },
          ),
        ),
      ],
    ));
  }
}
