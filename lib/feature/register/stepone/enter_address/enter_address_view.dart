import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/country/city_list/city_list_response.dart';
import 'package:domain/model/user/save_country_residence_info_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/enter_address/enter_address_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/home_address_dialog/home_address_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class EnterAddressView extends BasePageViewWidget<EnterAddressViewModel> {
  EnterAddressView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, EnterAddressViewModel model) {
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
                    child: AppStreamBuilder<Resource<CityListResponse>>(
                        stream: model.getCitiesByCountryResponseStream,
                        initialData: Resource.none(),
                        dataBuilder: (context, cityList) {
                          return AppStreamBuilder<
                                  Resource<SaveCountryResidenceInfoResponse>>(
                              stream: model.enterAddressResponseStream,
                              initialData: Resource.none(),
                              onData: (data) {
                                if (data.status == Status.SUCCESS) {
                                  model.residentCountryKey.currentState!
                                      .isValid = true;
                                  model.streetAddressKey.currentState!.isValid =
                                      true;
                                  model.buildingNameOrNumberKey.currentState!
                                      .isValid = true;
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
                                    ProviderScope.containerOf(context)
                                        .read(registerStepOneViewModelProvider)
                                        .pageController
                                        .next();
                                  });
                                } else if (data.status == Status.ERROR) {
                                  if (data.appError!.type ==
                                      ErrorType.EMPTY_RESIDENT_COUNTRY) {
                                    model.residentCountryKey.currentState!
                                        .isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType.EMPTY_CITY) {
                                    model.cityKey.currentState!.isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType.EMPTY_STREET_ADDRESS) {
                                    model.streetAddressKey.currentState!
                                        .isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER) {
                                    model.buildingNameOrNumberKey.currentState!
                                        .isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType
                                          .EMPTY_PERMANENT_RESIDENT_COUNTRY) {
                                    model.permanentResidentCountryKey
                                        .currentState!.isValid = false;
                                  } else if (data.appError!.type ==
                                      ErrorType.PERMANENT_EMPTY_CITY) {
                                    model.permanentCityKey.currentState!
                                        .isValid = false;
                                  }
                                  model.showToastWithError(data.appError!);
                                }
                              },
                              dataBuilder: (context, data) {
                                return GestureDetector(
                                    onHorizontalDragEnd: (details) {
                                      if (details.primaryVelocity!.isNegative) {
                                        model.enterAddress();
                                      } else {
                                        ProviderScope.containerOf(context)
                                            .read(
                                                registerStepOneViewModelProvider)
                                            .pageController
                                            .previous();
                                      }
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom -
                                                        50 <=
                                                    0
                                                ? 0
                                                : MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom -
                                                    48),
                                        child: SingleChildScrollView(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 32, horizontal: 24),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppTextField(
                                                labelText:
                                                    S.of(context).country,
                                                hintText: S
                                                    .of(context)
                                                    .pleaseSelect,
                                                readOnly: true,
                                                controller: model
                                                    .residentCountryController,
                                                onPressed: () {
                                                  CountryDialog.show(context,
                                                      title: S
                                                          .of(context)
                                                          .residentCountrySmall,
                                                      onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.residentCountryController
                                                            .text =
                                                        value.countryName!;
                                                    model.cityController
                                                        .clear();
                                                    model.currentCountry =
                                                        value;
                                                    model.getCitiesByCountry(
                                                        value.isoCode3 ?? '');

                                                    model
                                                        .updatePermanentAddressVisibility();
                                                    model.validateAddress();
                                                  });
                                                },
                                                suffixIcon: (value, data) {
                                                  return Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding:
                                                          EdgeInsets.only(
                                                              right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils
                                                              .downArrow,
                                                          color: AppColor
                                                              .dark_gray_1));
                                                },
                                                key: model.residentCountryKey,
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              AppTextField(
                                                labelText: S
                                                    .of(context)
                                                    .buildingNameOrNo,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                inputType: TextInputType.text,
                                                controller: model
                                                    .buildingNameOrNumberController,
                                                key: model
                                                    .buildingNameOrNumberKey,
                                                onChanged: (value) =>
                                                    model.validateAddress(),
                                                suffixIcon: (isValid,
                                                        value) =>
                                                    InkWell(
                                                        onTap: () =>
                                                            HomeAddressDialog
                                                                .show(context,
                                                                    onSelected:
                                                                        (value) {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              model.buildingNameOrNumberController
                                                                      .text =
                                                                  value;
                                                              model
                                                                  .validateAddress();
                                                            }, onDismissed:
                                                                        () {
                                                              Navigator.pop(
                                                                  context);
                                                            }),
                                                        child: Container(
                                                          height: 20,
                                                          width: 16,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4,
                                                                  top: 2),
                                                          child: AppSvg.asset(
                                                              AssetUtils
                                                                  .location_marker,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        )),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              AppTextField(
                                                labelText:
                                                    S.of(context).streetName,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                inputType: TextInputType.text,
                                                controller: model
                                                    .streetAddressController,
                                                key: model.streetAddressKey,
                                                onChanged: (value) =>
                                                    model.validateAddress(),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: AppTextField(
                                                  labelText: S
                                                      .of(context)
                                                      .area
                                                      .toUpperCase(),
                                                  hintText: S
                                                      .of(context)
                                                      .pleaseEnter,
                                                  inputType:
                                                      TextInputType.text,
                                                  controller: model
                                                      .districtController,
                                                  key: model.districtKey,
                                                  onChanged: (value) =>
                                                      model.validateAddress(),
                                                ),
                                              ),
                                              Visibility(
                                                visible: false,
                                                child: SizedBox(
                                                  height: 16,
                                                ),
                                              ),
                                              AppTextField(
                                                labelText: S.of(context).city,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                inputType: TextInputType.text,
                                                controller:
                                                    model.cityController,
                                                key: model.cityKey,
                                                readOnly: true,
                                                onPressed: () {
                                                  if (model
                                                      .residentCountryController
                                                      .text
                                                      .isEmpty) {
                                                    model
                                                        .residentCountryKey
                                                        .currentState!
                                                        .isValid = false;
                                                    model.showToastWithError(
                                                        AppError(
                                                            cause:
                                                                Exception(),
                                                            error: ErrorInfo(
                                                                message: ''),
                                                            type: ErrorType
                                                                .INVALID_COUNTRY));
                                                  } else {
                                                    StateCityDialog.show(
                                                        context,
                                                        title: S
                                                            .of(context)
                                                            .residentCountrySmall,
                                                        onDismissed: () {
                                                      Navigator.pop(context);
                                                    }, onSelected: (value) {
                                                      Navigator.pop(context);
                                                      model.cityController
                                                              .text =
                                                          value.cityName!;
                                                      model.currentCity =
                                                          value;
                                                      model.validateAddress();
                                                    },
                                                        stateCityTypeEnum:
                                                            StateCityTypeEnum
                                                                .CITY,
                                                        stateCityData: cityList!
                                                                    .status ==
                                                                Status.SUCCESS
                                                            ? cityList
                                                                .data!
                                                                .cityContent!
                                                                .stateData!
                                                            : []);
                                                  }
                                                },
                                                suffixIcon: (value, data) {
                                                  return Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding:
                                                          EdgeInsets.only(
                                                              right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils
                                                              .downArrow,
                                                          color: AppColor
                                                              .dark_gray_1));
                                                },
                                              ),
                                              AppStreamBuilder<bool>(
                                                stream: model
                                                    .permanentAddressVisibilityStream,
                                                initialData: false,
                                                dataBuilder:
                                                    (context, visibility) {
                                                  return Visibility(
                                                    visible: visibility!,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 32,
                                                        ),
                                                        Text(
                                                          S
                                                              .of(context)
                                                              .permanentAddress,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        AppTextField(
                                                          labelText: S
                                                              .of(context)
                                                              .country,
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseSelect,
                                                          readOnly: true,
                                                          controller: model
                                                              .permanentResidentCountryController,
                                                          onPressed: () {
                                                            CountryDialog.show(
                                                                context,
                                                                title: S
                                                                    .of(
                                                                        context)
                                                                    .residentCountrySmall,
                                                                onDismissed:
                                                                    () {
                                                              Navigator.pop(
                                                                  context);
                                                            }, onSelected:
                                                                    (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              model.permanentResidentCountryController
                                                                      .text =
                                                                  value
                                                                      .countryName!;
                                                              model
                                                                  .permanentCityController
                                                                  .clear();
                                                              model.permanentCountry =
                                                                  value;
                                                              model.getCitiesByCountry(
                                                                  value.isoCode3 ??
                                                                      '');
                                                              model
                                                                  .validateAddress();
                                                            });
                                                          },
                                                          suffixIcon:
                                                              (value, data) {
                                                            return Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child: AppSvg.asset(
                                                                    AssetUtils
                                                                        .downArrow,
                                                                    color: AppColor
                                                                        .dark_gray_1));
                                                          },
                                                          key: model
                                                              .permanentResidentCountryKey,
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        AppTextField(
                                                          labelText: S
                                                              .of(context)
                                                              .city,
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseEnter,
                                                          inputType:
                                                              TextInputType
                                                                  .text,
                                                          controller: model
                                                              .permanentCityController,
                                                          key: model
                                                              .permanentCityKey,
                                                          readOnly: true,
                                                          onPressed: () {
                                                            if (model
                                                                .permanentResidentCountryController
                                                                .text
                                                                .isEmpty) {
                                                              model
                                                                  .permanentResidentCountryKey
                                                                  .currentState!
                                                                  .isValid = false;
                                                              model.showToastWithError(AppError(
                                                                  cause:
                                                                      Exception(),
                                                                  error: ErrorInfo(
                                                                      message:
                                                                          ''),
                                                                  type: ErrorType
                                                                      .INVALID_COUNTRY));
                                                            } else {
                                                              StateCityDialog.show(
                                                                  context,
                                                                  title: S
                                                                      .of(
                                                                          context)
                                                                      .residentCountrySmall,
                                                                  onDismissed:
                                                                      () {
                                                                Navigator.pop(
                                                                    context);
                                                              }, onSelected:
                                                                      (value) {
                                                                Navigator.pop(
                                                                    context);
                                                                model.permanentCityController
                                                                        .text =
                                                                    value
                                                                        .cityName!;
                                                                model.permanentCity =
                                                                    value;
                                                                model
                                                                    .validateAddress();
                                                              },
                                                                  stateCityTypeEnum:
                                                                      StateCityTypeEnum
                                                                          .CITY,
                                                                  stateCityData: cityList!
                                                                      .data!
                                                                      .cityContent!
                                                                      .stateData!);
                                                            }
                                                          },
                                                          suffixIcon:
                                                              (value, data) {
                                                            return Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child: AppSvg.asset(
                                                                    AssetUtils
                                                                        .downArrow,
                                                                    color: AppColor
                                                                        .dark_gray_1));
                                                          },
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                height: 32,
                                              ),
                                              Center(
                                                child: AppStreamBuilder<bool>(
                                                    stream: model
                                                        .showButtonStream,
                                                    initialData: false,
                                                    dataBuilder:
                                                        (context, isValid) {
                                                      return Visibility(
                                                        visible: isValid!,
                                                        child: AnimatedButton(
                                                          buttonText: S
                                                              .of(context)
                                                              .swipeToProceed,
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                              });
                        }),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
