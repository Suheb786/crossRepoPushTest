import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/enter_address/enter_address_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
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
                    child: AppStreamBuilder<Resource<bool>>(
                        stream: model.enterAddressResponseStream,
                        initialData: Resource.none(),
                        onData: (data) {
                          if (data.status == Status.SUCCESS) {
                            model.residentCountryKey.currentState!.isValid =
                                true;
                            model.homeAddressrKey.currentState!.isValid = true;
                            model.streetAddressKey.currentState!.isValid = true;
                            model.buildingNameOrNumberKey.currentState!
                                .isValid = true;
                            ProviderScope.containerOf(context)
                                .read(registerStepOneViewModelProvider)
                                .pageController
                                .nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut);
                          } else if (data.status == Status.ERROR) {
                            if (data.appError!.type ==
                                ErrorType.EMPTY_RESIDENT_COUNTRY) {
                              model.residentCountryKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_HOME_ADDRESS) {
                              model.homeAddressrKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_STREET_ADDRESS) {
                              model.streetAddressKey.currentState!.isValid =
                                  false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_BUILDING_NAME_OR_NUMBER) {
                              model.buildingNameOrNumberKey.currentState!
                                  .isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_PERMANENT_RESIDENT_COUNTRY) {
                              model.permanentResidentCountryKey.currentState!
                                  .isValid = false;
                            } else if (data.appError!.type ==
                                ErrorType.EMPTY_CITY) {
                              model.permanentCityKey.currentState!.isValid =
                                  false;
                            }
                            model.showToastWithError(data.appError!);
                          }
                        },
                        dataBuilder: (context, data) {
                          return GestureDetector(
                            onHorizontalDragUpdate: (details) {
                              if (details.primaryDelta!.isNegative) {
                                model.enterAddress();
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
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppTextField(
                                              labelText:
                                                  S.of(context).residentCountry,
                                              hintText: S
                                                  .of(context)
                                                  .residentCountryHint,
                                              readOnly: true,
                                              controller: model
                                                  .residentCountryController,
                                              suffixIcon: (value, data) {
                                                return InkWell(
                                                  onTap: () async {
                                                    CountryDialog.show(context,
                                                        title: S
                                                            .of(context)
                                                            .residentCountrySmall,
                                                        onDismissed: () {
                                                      Navigator.pop(context);
                                                    }, onSelected: (value) {
                                                      Navigator.pop(context);
                                                      model
                                                          .residentCountryController
                                                          .text = value;
                                                      model
                                                          .updatePermanentAddressVisibility();
                                                      model.validateAddress();
                                                    });
                                                  },
                                                  child: Container(
                                                      height: 16,
                                                      width: 16,
                                                      padding: EdgeInsets.only(
                                                          right: 8),
                                                      child: AppSvg.asset(
                                                          AssetUtils
                                                              .downArrow)),
                                                );
                                              },
                                              key: model.residentCountryKey,
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            AppTextField(
                                              labelText:
                                                  S.of(context).homeAddress,
                                              hintText:
                                                  S.of(context).homeAddressHint,
                                              inputType: TextInputType.text,
                                              controller:
                                                  model.homeAddressController,
                                              key: model.homeAddressrKey,
                                              onChanged: (value) =>
                                                  model.validateAddress(),
                                              suffixIcon: (isValid, value) =>
                                                  InkWell(
                                                      onTap: () =>
                                                          HomeAddressDialog
                                                              .show(context,
                                                                  onSelected:
                                                                      (value) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            model
                                                                .homeAddressController
                                                                .text = value;
                                                          }, onDismissed: () {
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
                                                                .location_marker),
                                                      )),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            AppTextField(
                                              labelText:
                                                  S.of(context).streetAddress,
                                              hintText: S
                                                  .of(context)
                                                  .streetAddressHint,
                                              inputType: TextInputType.text,
                                              controller:
                                                  model.streetAddressController,
                                              key: model.streetAddressKey,
                                              onChanged: (value) =>
                                                  model.validateAddress(),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            AppTextField(
                                              labelText: S
                                                  .of(context)
                                                  .buildingNameOrNo,
                                              hintText: S
                                                  .of(context)
                                                  .buildingNameOrNoHint,
                                              inputType: TextInputType.text,
                                              controller: model
                                                  .buildingNameOrNumberController,
                                              key:
                                                  model.buildingNameOrNumberKey,
                                              onChanged: (value) =>
                                                  model.validateAddress(),
                                            ),
                                            SizedBox(
                                              height: 32,
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
                                                      Text(
                                                        S
                                                            .of(context)
                                                            .permanentAddress,
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: AppColor
                                                                .very_light_gray_white),
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      AppTextField(
                                                        labelText: S
                                                            .of(context)
                                                            .residentCountry,
                                                        hintText: S
                                                            .of(context)
                                                            .pleaseSelect,
                                                        readOnly: true,
                                                        controller: model
                                                            .permanentResidentCountryController,
                                                        suffixIcon:
                                                            (value, data) {
                                                          return InkWell(
                                                            onTap: () async {
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
                                                                    value;
                                                                model
                                                                    .validateAddress();
                                                              });
                                                            },
                                                            child: Container(
                                                                height: 16,
                                                                width: 16,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            8),
                                                                child: AppSvg.asset(
                                                                    AssetUtils
                                                                        .downArrow)),
                                                          );
                                                        },
                                                        key: model
                                                            .permanentResidentCountryKey,
                                                      ),
                                                      SizedBox(
                                                        height: 16,
                                                      ),
                                                      AppTextField(
                                                        labelText:
                                                            S.of(context).city,
                                                        hintText: S
                                                            .of(context)
                                                            .pleaseEnter,
                                                        inputType:
                                                            TextInputType.text,
                                                        controller: model
                                                            .permanentCityController,
                                                        key: model
                                                            .permanentCityKey,
                                                        onChanged: (value) => model
                                                            .validateAddress(),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 45,
                                        top: 16,
                                      ),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.showButtonStream,
                                          initialData: false,
                                          dataBuilder: (context, isValid) {
                                            return Visibility(
                                              visible: isValid!,
                                              child: AnimatedButton(
                                                buttonText: S
                                                    .of(context)
                                                    .swipeToProceed,
                                              ),
                                            );
                                          }),
                                    )
                                  ],
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
