import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/enter_address/enter_address_model.dart';
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
              S.of(context).whereDoYouCurrentlyLive,
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
                                .read(registerStepThreeViewModelProvider)
                                .registrationStepThreePageController
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
                            } else {
                              model.buildingNameOrNumberKey.currentState!
                                  .isValid = false;
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
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          AppTextField(
                                            labelText:
                                                S.of(context).residentCountry,
                                            hintText: S
                                                .of(context)
                                                .residentCountryHint,
                                            readOnly: true,
                                            controller:
                                                model.residentCountryController,
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
                                                    model.validateAddress();
                                                  });
                                                },
                                                child: Container(
                                                    height: 16,
                                                    width: 16,
                                                    padding: EdgeInsets.only(
                                                        right: 8),
                                                    child: AppSvg.asset(
                                                        AssetUtils.downArrow)),
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
                                                        HomeAddressDialog.show(
                                                            context, onSelected:
                                                                (value) {
                                                          Navigator.of(context)
                                                              .pop();
                                                          model
                                                              .homeAddressController
                                                              .text = value;
                                                        }, onDismissed: () {
                                                          Navigator.pop(
                                                              context);
                                                        }),
                                                    child: Image.asset(
                                                        AssetUtils.location)),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText:
                                                S.of(context).streetAddress,
                                            hintText:
                                                S.of(context).streetAddressHint,
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
                                            labelText:
                                                S.of(context).buildingNameOrNo,
                                            hintText: S
                                                .of(context)
                                                .buildingNameOrNoHint,
                                            inputType: TextInputType.text,
                                            controller: model
                                                .buildingNameOrNumberController,
                                            key: model.buildingNameOrNumberKey,
                                            onChanged: (value) =>
                                                model.validateAddress(),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 45,
                                      right: 45,
                                      bottom: 0,
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
