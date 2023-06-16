
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/model/user/save_profile_status_response.dart';
import 'package:flutter/material.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ProfileDetailsPageView extends BasePageViewWidget<ProfileDetailsPageViewModel> {
  ProfileDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Column(
      children: [
        Expanded(
          child: AppKeyBoardHide(
            child: AppStreamBuilder<bool>(
                initialData: false,
                stream: model.errorDetectorStream,
                dataBuilder: (context, isError) {
                  return ShakeAnimatedWidget(
                    enabled: isError ?? false,
                    duration: Duration(milliseconds: 100),
                    shakeAngle: Rotation.deg(z: 1),
                    curve: Curves.easeInOutSine,
                    child: AppStreamBuilder<Resource<SaveProfileStatusResponse>>(
                      stream: model.profileDetailsStream,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          model.setKeysStatusValid();
                          Future.delayed(Duration(milliseconds: 500), () {
                            ProviderScope.containerOf(context)
                                .read(registerViewModelProvider)
                                .registrationStepsController
                                .nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                          });
                        } else if (data.status == Status.ERROR) {
                          model.checkKeyStatus(data.appError!.type);
                          model.showToastWithError(data.appError!);
                        }
                      },
                      dataBuilder: (context, data) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            if (ProviderScope.containerOf(context)
                                    .read(registerStepOneViewModelProvider)
                                    .appSwiperController
                                    .page ==
                                3.0) {
                              FocusScope.of(context).unfocus();
                              if (StringUtils.isDirectionRTL(context)) {
                                if (!details.primaryVelocity!.isNegative) {
                                  model.validateTextFields();
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(registerStepOneViewModelProvider)
                                      .previousPage();
                                  // .previous();
                                }
                              } else {
                                if (details.primaryVelocity!.isNegative) {
                                  model.validateTextFields();
                                } else {
                                  ProviderScope.containerOf(context)
                                      .read(registerStepOneViewModelProvider)
                                      .previousPage();
                                  // .previous();
                                }
                              }
                            }
                          },
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                      ? 0
                                      : MediaQuery.of(context).viewInsets.bottom - 48.0.h),
                              child: SingleChildScrollView(
                                padding: EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 24.0.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileRowItem(
                                      title: S.of(context).doYouHaveAnyOtherNationality,
                                      initialValue: false,
                                      activeText: S.of(context).yes.toUpperCase(),
                                      inactiveText: S.of(context).no.toUpperCase(),
                                      providerBase: anyOtherNationalityViewModelProvider,
                                      onToggle: (isActive) {
                                        model.isAnyOtherNationality = isActive;
                                        return Visibility(
                                          visible: isActive,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 16.0.h),
                                            child: AppTextField(
                                              labelText: S.of(context).otherNationality.toUpperCase(),
                                              hintText: S.of(context).pleaseSelect,
                                              readOnly: true,
                                              controller: model.otherNationalityController,
                                              key: model.otherNationalityKey,
                                              onPressed: () {
                                                CountryDialog.show(context,
                                                    title: S.of(context).otherNationality, onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.otherNationalityController.text = value.countryName!;
                                                  model.validate();
                                                });
                                              },
                                              suffixIcon: (value, data) {
                                                return Container(
                                                    height: 16.0.h,
                                                    width: 16.0.w,
                                                    padding: EdgeInsetsDirectional.only(end: 8.0.w),
                                                    child: AppSvg.asset(AssetUtils.downArrow,
                                                        color: AppColor.dark_gray_1));
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    ProfileRowItem(
                                      title: S.of(context).profileDetailsQ1,
                                      initialValue: false,
                                      activeText: S.of(context).yes.toUpperCase(),
                                      inactiveText: S.of(context).no.toUpperCase(),
                                      providerBase: profileQ1ViewModelProvider,
                                      onToggle: (isActive) {
                                        model.isMarried = isActive;
                                        return Visibility(
                                          visible: isActive,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 16.0.h),
                                            child: AppTextField(
                                              labelText: S.of(context).spouseNameCaps,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              controller: model.spouseNameController,
                                              key: model.spouseNameKey,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Visibility(
                                      visible: false,
                                      child: ProfileRowItem(
                                        title: S.of(context).profileDetailsQ2,
                                        initialValue: false,
                                        providerBase: profileQ2ViewModelProvider,
                                        activeText: S.of(context).yes.toUpperCase(),
                                        inactiveText: S.of(context).no.toUpperCase(),
                                        onToggle: (isActive) {
                                          model.isPerson = isActive;
                                          return Visibility(
                                            visible: isActive,
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 16.0.h),
                                              child: AppTextField(
                                                labelText: S.of(context).natureOfSpecialNeed,
                                                hintText: S.of(context).pleaseSelect,
                                                inputType: TextInputType.text,
                                                controller: model.natureController,
                                                key: model.natureOfSpecialNeedKey,
                                                readOnly: true,
                                                onPressed: () {
                                                  NatureSpecialNeedsDialog.show(context, onDismissed: () {
                                                    Navigator.pop(context);
                                                  }, onSelected: (value) {
                                                    Navigator.pop(context);
                                                    model.updateNatureOfNeeds(value);
                                                  });
                                                },
                                                suffixIcon: (enabled, value) {
                                                  return AppSvg.asset(AssetUtils.dropDown,
                                                      color: AppColor.dark_gray_1, width: 16.w, height: 16.h);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    AppStreamBuilder<bool>(
                                      stream: model.beneficialOwnerAccountErrorVisibilityStream,
                                      initialData: false,
                                      dataBuilder: (context, isValid) {
                                        return ProfileRowItem(
                                          title: S.of(context).areYouBeneficialOwnerAccount,
                                          initialValue: true,
                                          providerBase: areYouBeneficialOwnerAccountProvider,
                                          activeText: S.of(context).yes.toUpperCase(),
                                          inactiveText: S.of(context).no.toUpperCase(),
                                          labelColor: !isValid! ? AppColor.vivid_red : AppColor.text_color,
                                          onToggle: (isActive) {
                                            model.updateBeneficialOwnerAccountErrorVisibility(isActive);
                                            return Visibility(
                                              visible: isActive,
                                              child: Container(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      S.of(context).whatIsYourEmploymentStatus,
                                      style: TextStyle(
                                          fontFamily: StringUtils.appFont,
                                          fontSize: 14.t,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).primaryColorDark),
                                    ),
                                    SizedBox(
                                      height: 16.h,
                                    ),
                                    AppTextField(
                                      labelText: S.of(context).employmentStatus,
                                      hintText: S.of(context).pleaseSelect,
                                      inputType: TextInputType.text,
                                      controller: model.employeeStatusController,
                                      key: model.employeeStatusKey,
                                      readOnly: true,
                                      onPressed: () {
                                        EmploymentStatusDialog.show(context, onDismissed: () {
                                          Navigator.pop(context);
                                        }, onSelected: (value, englishValue) {
                                          Navigator.pop(context);
                                          model.updateRelationShipWithPEP(value, englishValue);
                                          model.updateJobNameVisibility();
                                          model.validate();
                                        });
                                      },
                                      suffixIcon: (enabled, value) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                                          width: 16,
                                          height: 16,
                                          child:
                                              AppSvg.asset(AssetUtils.dropDown, color: AppColor.dark_gray_1),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    AppStreamBuilder<bool>(
                                      stream: model.jobNameVisibilityStream,
                                      initialData: false,
                                      dataBuilder: (context, isVisible) {
                                        return Visibility(
                                            visible: isVisible!,
                                            child: AppTextField(
                                              labelText: S.of(context).jobName,
                                              hintText: S.of(context).pleaseEnter,
                                              inputType: TextInputType.text,
                                              controller: model.jobNameController,
                                              key: model.jobNameKey,
                                              onChanged: (value) => model.validate(),
                                            ));
                                      },
                                    ),
                                    Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 8),
                                          child: AppStreamBuilder<bool>(
                                              stream: model.showButtonStream,
                                              initialData: false,
                                              dataBuilder: (context, isValid) {
                                                return Visibility(
                                                  visible: isValid!,
                                                  child: AnimatedButton(
                                                      buttonText: S.of(context).swipeToProceed),
                                                );
                                              })),
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
                }),
          ),
        ),
      ],
    );
  }
}
