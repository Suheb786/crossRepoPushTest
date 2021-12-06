import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_relevant_w9_address_details/fatca_us_relevant_w9_address_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/state_city_dialog/state_city_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSRelevantW9AddressDetailsPageView
    extends BasePageViewWidget<FatcaUSRelevantW9AddressDetailsPageViewModel> {
  FatcaUSRelevantW9AddressDetailsPageView(ProviderBase model) : super(model);

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
                child: AppStreamBuilder<Resource<bool>>(
                  stream: model.fatcaUSRelevantW9AddressDetailsStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerStepFourViewModelProvider)
                          .registrationStepFourPageController
                          .nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateFatcaUSRelevantW9AddressDetails();
                        } else {
                          ProviderScope.containerOf(context)
                              .read(registerStepFourViewModelProvider)
                              .registrationStepFourPageController
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
                        color: Theme.of(context)
                            .cardTheme
                            .copyWith(color: AppColor.white)
                            .color,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColor.black.withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  AppTextField(
                                    labelText:
                                        S.of(context).addressInUnitedStates,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.addressController,
                                    key: model.addressKey,
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
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
                                    onPressed: () {
                                      StateCityDialog.show(context,
                                          title: S.of(context).stateSmall,
                                          onDismissed: () {
                                        Navigator.pop(context);
                                      }, onSelected: (value) {
                                        Navigator.pop(context);
                                        model.stateController.text = value;
                                        model.isValid();
                                      },
                                          stateCityTypeEnum:
                                              StateCityTypeEnum.STATE);
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16,
                                          width: 16,
                                          padding: EdgeInsets.only(right: 8),
                                          child: AppSvg.asset(
                                              AssetUtils.downArrow,
                                              color: AppColor.dark_gray_1));
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
                                    onPressed: () {
                                      StateCityDialog.show(context,
                                          title: S.of(context).citySmall,
                                          onDismissed: () {
                                        Navigator.pop(context);
                                      }, onSelected: (value) {
                                        Navigator.pop(context);
                                        model.cityController.text = value;
                                        model.isValid();
                                      },
                                          stateCityTypeEnum:
                                              StateCityTypeEnum.CITY);
                                    },
                                    suffixIcon: (value, data) {
                                      return Container(
                                          height: 16,
                                          width: 16,
                                          padding: EdgeInsets.only(right: 8),
                                          child: AppSvg.asset(
                                              AssetUtils.downArrow,
                                              color: AppColor.dark_gray_1));
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
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText:
                                        S.of(context).accountNumberOptional,
                                    hintText: S.of(context).pleaseEnter,
                                    controller: model.accountNumberController,
                                    // labelIcon: () {
                                    //   return InkWell(
                                    //     onTap: () async {},
                                    //     child: Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(left: 5.0),
                                    //       child: Container(
                                    //           height: 14,
                                    //           width: 14,
                                    //           child: AppSvg.asset(
                                    //               AssetUtils.info,
                                    //               color: Theme.of(context)
                                    //                   .inputDecorationTheme
                                    //                   .focusedBorder!
                                    //                   .borderSide
                                    //                   .color)),
                                    //     ),
                                    //   );
                                    // },
                                    key: model.accountNumberKey,
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppTextField(
                                    labelText:
                                        S.of(context).exemptPayeeOptional,
                                    hintText: S.of(context).pleaseEnter,
                                    controller:
                                        model.exemptPayeeCodeNumberController,
                                    labelIcon: () {
                                      return InkWell(
                                        onTap: () async {},
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: Container(
                                              height: 14,
                                              width: 14,
                                              child: AppSvg.asset(
                                                  AssetUtils.info,
                                                  color: Theme.of(context)
                                                      .inputDecorationTheme
                                                      .focusedBorder!
                                                      .borderSide
                                                      .color)),
                                        ),
                                      );
                                    },
                                    key: model.exemptPayeeCodeNumberKey,
                                    inputAction: TextInputAction.go,
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  AppStreamBuilder<bool>(
                                    stream: model.additionalRequesterStream,
                                    initialData: false,
                                    dataBuilder: (context, isActive) {
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 26.0),
                                            child: AppSwitchLabelWidget(
                                              label: S
                                                  .of(context)
                                                  .additionalRequester,
                                              inActiveText: S.of(context).no,
                                              activeText: S.of(context).yes,
                                              onToggle: (value) {
                                                model.updateSwitchValue(value);
                                              },
                                              isActive: isActive,
                                            ),
                                          ),
                                          Visibility(
                                              visible: isActive!,
                                              child: Column(
                                                children: [
                                                  AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .requesterName
                                                        .toUpperCase(),
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .additionalRequesterNameController,
                                                    key: model
                                                        .additionalRequesterNameKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    onChanged: (value) {
                                                      model.isValid();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .addressInUnitedStates,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .additionalRequesterAddressController,
                                                    key: model
                                                        .additionalRequesterAddressNameKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    onChanged: (value) {
                                                      model.isValid();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  AppTextField(
                                                    labelText:
                                                        S.of(context).state,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    controller: model
                                                        .additionalRequesterStateController,
                                                    key: model
                                                        .additionalRequesterStateKey,
                                                    readOnly: true,
                                                    onPressed: () {
                                                      StateCityDialog.show(
                                                          context,
                                                          title: S
                                                              .of(context)
                                                              .stateSmall,
                                                          onDismissed: () {
                                                        Navigator.pop(context);
                                                      }, onSelected: (value) {
                                                        Navigator.pop(context);
                                                        model
                                                            .additionalRequesterStateController
                                                            .text = value;
                                                        model.isValid();
                                                      },
                                                          stateCityTypeEnum:
                                                              StateCityTypeEnum
                                                                  .STATE);
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
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  AppTextField(
                                                    labelText:
                                                        S.of(context).city,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    controller: model
                                                        .additionalRequesterCityController,
                                                    key: model
                                                        .additionalRequesterCityKey,
                                                    readOnly: true,
                                                    onPressed: () {
                                                      StateCityDialog.show(
                                                          context,
                                                          title: S
                                                              .of(context)
                                                              .citySmall,
                                                          onDismissed: () {
                                                        Navigator.pop(context);
                                                      }, onSelected: (value) {
                                                        Navigator.pop(context);
                                                        model
                                                            .additionalRequesterCityController
                                                            .text = value;
                                                        model.isValid();
                                                      },
                                                          stateCityTypeEnum:
                                                              StateCityTypeEnum
                                                                  .CITY);
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
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  AppTextField(
                                                    labelText:
                                                        S.of(context).postCode,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .additionalRequesterPostCodeController,
                                                    key: model
                                                        .additionalRequesterPostCodeKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    onChanged: (value) {
                                                      model.isValid();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom,
                                                  ),
                                                ],
                                              ))
                                        ],
                                      );
                                    },
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 32),
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
