import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/fatca_us_relevant_w8_address_details/fatca_us_relevant_w8_address_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSRelevantW8AddressDetailsPageView
    extends BasePageViewWidget<FatcaUSRelevantW8AddressDetailsPageViewModel> {
  FatcaUSRelevantW8AddressDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
        child: Column(
      children: [
        Text(
          S.of(context).fatcaandPep,
          style: TextStyle(
              color: AppColor.dark_gray,
              fontSize: 10,
              fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 32),
          child: Text(
            S.of(context).pleaseProvideInformationIfAppliesToYou,
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
                  stream: model.fatcaUSRelevantW8AddressDetailsStream,
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
                          model.validateFatcaUSRelevantW8AddressDetails();
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
                                    labelText: S
                                        .of(context)
                                        .permanentResidentAddressLine
                                        .toUpperCase(),
                                    hintText: S.of(context).pleaseEnter,
                                    controller:
                                        model.permanentAddressController,
                                    key: model.permanentAddressKey,
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
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).country,
                                    hintText: S.of(context).pleaseSelect,
                                    controller: model.countryController,
                                    key: model.countryKey,
                                    readOnly: true,
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
                                        onTap: () async {},
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
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).state,
                                    hintText: S.of(context).pleaseSelect,
                                    controller: model.stateController,
                                    key: model.stateKey,
                                    readOnly: true,
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
                                        onTap: () async {},
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
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).city,
                                    hintText: S.of(context).pleaseSelect,
                                    controller: model.cityController,
                                    key: model.cityKey,
                                    readOnly: true,
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
                                        onTap: () async {},
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
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText: S.of(context).postCode,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.postCodeController,
                                    key: model.postCodeKey,
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
                                    height: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  AppStreamBuilder<bool>(
                                    stream: model.mailingAddressDifferentStream,
                                    initialData: false,
                                    dataBuilder: (context, isActive) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 32.0),
                                        child: AppSwitchLabelWidget(
                                          label: S
                                              .of(context)
                                              .mailingAddressDifferentFromResidence,
                                          inActiveText: S.of(context).no,
                                          activeText: S.of(context).yes,
                                          onToggle: (value) {
                                            model.updateSwitchValue(value);
                                          },
                                          isActive: isActive,
                                        ),
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
