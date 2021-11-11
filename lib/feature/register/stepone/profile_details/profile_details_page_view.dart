import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/stepone/profile_details/profile_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/nature_special_needs/nature_special_needs_dialog.dart';
import 'package:neo_bank/ui/molecules/profile/profile_row_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ProfileDetailsPageView
    extends BasePageViewWidget<ProfileDetailsPageViewModel> {
  ProfileDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: Column(
        children: [
          Expanded(
            child: AppStreamBuilder<bool>(
                initialData: false,
                stream: model.errorDetectorStream,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<bool>>(
                      stream: model.profileDetailsStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.setKeysStatusValid();
                          ProviderScope.containerOf(context)
                              .read(registerViewModelProvider)
                              .registrationStepsController
                              .nextPage(
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                          // if (model.employeeStatusController.text ==
                          //     "Student") {
                          //   ProviderScope.containerOf(context)
                          //       .read(registerViewModelProvider)
                          //       .registrationStepsController
                          //       .nextPage(
                          //           duration: Duration(milliseconds: 500),
                          //           curve: Curves.easeInOut);
                          // } else {
                          //   ProviderScope.containerOf(context)
                          //       .read(registerStepTwoViewModelProvider)
                          //       .registrationStepTwoPageController
                          //       .jumpToPage(1);
                          // }
                        } else if (data.status == Status.ERROR) {
                          model.checkKeyStatus(data.appError!.type);
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            if (details.primaryDelta!.isNegative) {
                              model.validateTextFields();
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
                            color: Theme.of(context)
                                .cardTheme
                                .copyWith(color: AppColor.white)
                                .color,
                            margin: EdgeInsets.zero,
                            shadowColor: AppColor.black.withOpacity(0.32),
                            child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 32, horizontal: 24),
                                child: Stack(
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ProfileRowItem(
                                            title: S
                                                .of(context)
                                                .doYouHaveAnyOtherNationality,
                                            initialValue: false,
                                            activeText: S.of(context).yes,
                                            inactiveText: S.of(context).no,
                                            providerBase:
                                                anyOtherNationalityViewModelProvider,
                                            onToggle: (isActive) {
                                              model.isAnyOtherNationality =
                                                  isActive;
                                              return Visibility(
                                                visible: isActive,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.0),
                                                  child: AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .otherNationality
                                                        .toUpperCase(),
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    readOnly: true,
                                                    controller: model
                                                        .otherNationalityController,
                                                    key: model
                                                        .otherNationalityKey,
                                                    suffixIcon: (value, data) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          CountryDialog.show(
                                                              context,
                                                              title: S
                                                                  .of(context)
                                                                  .otherNationality,
                                                              onDismissed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }, onSelected:
                                                                  (value) {
                                                            Navigator.pop(
                                                                context);
                                                            model
                                                                .otherNationalityController
                                                                .text = value;
                                                            model.validate();
                                                          });
                                                        },
                                                        child: Container(
                                                            height: 16,
                                                            width: 16,
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 8),
                                                            child: AppSvg.asset(
                                                                AssetUtils
                                                                    .downArrow,
                                                                color: AppColor
                                                                    .dark_gray_1)),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          ProfileRowItem(
                                            title:
                                                S.of(context).profileDetailsQ1,
                                            initialValue: false,
                                            activeText: S.of(context).yes,
                                            inactiveText: S.of(context).no,
                                            providerBase:
                                                profileQ1ViewModelProvider,
                                            onToggle: (isActive) {
                                              model.isMarried = isActive;
                                              return Visibility(
                                                visible: isActive,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.0),
                                                  child: AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .spouseNameCaps,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    inputType:
                                                        TextInputType.text,
                                                    controller: model
                                                        .spouseNameController,
                                                    key: model.spouseNameKey,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          ProfileRowItem(
                                            title:
                                                S.of(context).profileDetailsQ2,
                                            initialValue: false,
                                            providerBase:
                                                profileQ2ViewModelProvider,
                                            activeText: S.of(context).yes,
                                            inactiveText: S.of(context).no,
                                            onToggle: (isActive) {
                                              model.isPerson = isActive;
                                              return Visibility(
                                                visible: isActive,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.0),
                                                  child: AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .natureOfSpecialNeed,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    inputType:
                                                        TextInputType.text,
                                                    controller:
                                                        model.natureController,
                                                    key: model
                                                        .natureOfSpecialNeedKey,
                                                    readOnly: true,
                                                    suffixIcon:
                                                        (enabled, value) {
                                                      return InkWell(
                                                          onTap: () async {
                                                            NatureSpecialNeedsDialog
                                                                .show(context,
                                                                    onDismissed:
                                                                        () {
                                                              Navigator.pop(
                                                                  context);
                                                            }, onSelected:
                                                                        (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              model
                                                                  .updateNatureOfNeeds(
                                                                      value);
                                                            });
                                                          },
                                                          child: AppSvg.asset(
                                                              AssetUtils
                                                                  .dropDown,
                                                              color: AppColor
                                                                  .dark_gray_1,
                                                              width: 16,
                                                              height: 16));
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          AppStreamBuilder<bool>(
                                            stream: model
                                                .beneficialOwnerAccountErrorVisibilityStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return ProfileRowItem(
                                                title: S
                                                    .of(context)
                                                    .areYouBeneficialOwnerAccount,
                                                initialValue: true,
                                                providerBase:
                                                    areYouBeneficialOwnerAccountProvider,
                                                activeText: S.of(context).yes,
                                                inactiveText: S.of(context).no,
                                                labelColor: !isValid!
                                                    ? AppColor.vivid_red
                                                    : AppColor.text_color,
                                                onToggle: (isActive) {
                                                  model
                                                      .updateBeneficialOwnerAccountErrorVisibility(
                                                          isActive);
                                                  return Visibility(
                                                    visible: isActive,
                                                    child: Container(),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                          SizedBox(
                                            height: 32,
                                          ),
                                          Text(
                                            S
                                                .of(context)
                                                .whatIsYourEmploymentStatus,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(context)
                                                    .primaryColorDark),
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppTextField(
                                            labelText:
                                                S.of(context).employmentStatus,
                                            hintText:
                                                S.of(context).pleaseSelect,
                                            inputType: TextInputType.text,
                                            controller:
                                                model.employeeStatusController,
                                            key: model.employeeStatusKey,
                                            readOnly: true,
                                            suffixIcon: (enabled, value) {
                                              return InkWell(
                                                  onTap: () async {
                                                    EmploymentStatusDialog.show(
                                                        context,
                                                        onDismissed: () {
                                                      Navigator.pop(context);
                                                    }, onSelected: (value) {
                                                      Navigator.pop(context);
                                                      model
                                                          .updateRelationShipWithPEP(
                                                              value);
                                                      model
                                                          .updateJobNameVisibility();
                                                      model.validate();
                                                    });
                                                  },
                                                  child: AppSvg.asset(
                                                      AssetUtils.dropDown,
                                                      color:
                                                          AppColor.dark_gray_1,
                                                      width: 16,
                                                      height: 16));
                                            },
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          AppStreamBuilder<bool>(
                                            stream:
                                                model.jobNameVisibilityStream,
                                            initialData: false,
                                            dataBuilder: (context, isVisible) {
                                              return Visibility(
                                                  visible: isVisible!,
                                                  child: AppTextField(
                                                    labelText:
                                                        S.of(context).jobName,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    inputType:
                                                        TextInputType.text,
                                                    controller:
                                                        model.jobNameController,
                                                    key: model.jobNameKey,
                                                    onChanged: (value) =>
                                                        model.validate(),
                                                  ));
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
                                    Positioned(
                                        bottom: 0,
                                        right: 45,
                                        child: AppStreamBuilder<bool>(
                                            stream: model.showButtonStream,
                                            initialData: false,
                                            dataBuilder: (context, isValid) {
                                              return Visibility(
                                                visible: isValid!,
                                                child: AnimatedButton(
                                                    buttonText: S
                                                        .of(context)
                                                        .swipeToProceed),
                                              );
                                            }))
                                  ],
                                )),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
