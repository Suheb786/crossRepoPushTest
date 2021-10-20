import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:domain/constants/error_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/profile_details/profile_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/nature_special_needs/nature_special_needs_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/relationship_with_pep/relationship_with_pep_dialog.dart';
import 'package:neo_bank/ui/molecules/profile/profile_row_item.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/parser/error_parser.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ProfileDetailsPageView
    extends BasePageViewWidget<ProfileDetailsPageViewModel> {
  ProfileDetailsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<bool>(
        stream: model.animatedStream,
        initialData: false,
        dataBuilder: (context, isAnimated) {
          return Column(
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
                  S.of(context).tellUsAboutYourProfile,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColor.very_dark_gray,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
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
                                  .read(registerStepThreeViewModelProvider)
                                  .registrationStepThreePageController
                                  .nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                            } else if (data.status == Status.ERROR) {
                              model.checkKeyStatus(data.appError!.type);
                            }
                          },
                          dataBuilder: (context, data) {
                            return GestureDetector(
                              onHorizontalDragUpdate: (details) {
                                if (details.primaryDelta!.isNegative) {
                                  model.validateTextFields();
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
                                      child: Column(
                                        children: [
                                          ProfileRowItem(
                                            title:
                                                S.of(context).profileDetailsQ1,
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
                                                    hintText: "",
                                                    inputType:
                                                        TextInputType.text,
                                                    controller: model
                                                        .spouseNameController,
                                                    key: model.spouseNameKey,
                                                    textHintWidget: (hasFocus,
                                                        isValid, value) {
                                                      return Visibility(
                                                        visible: !isValid,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8),
                                                          child: Text(
                                                            ErrorParser.getLocalisedStringError(
                                                                error: data!
                                                                    .appError,
                                                                localisedHelper:
                                                                    S.of(
                                                                        context)),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .vivid_red),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          ProfileRowItem(
                                            title:
                                                S.of(context).profileDetailsQ2,
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
                                                            model
                                                                .updateAnimatedValue(
                                                                    true);
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
                                                                  .updateAnimatedValue(
                                                                      false);
                                                              model
                                                                  .updateNatureOfNeeds(
                                                                      value);
                                                            });
                                                          },
                                                          child: AppSvg.asset(
                                                              AssetUtils
                                                                  .dropDown,
                                                              width: 16,
                                                              height: 16));
                                                    },
                                                    textHintWidget: (hasFocus,
                                                        isValid, value) {
                                                      return Visibility(
                                                        visible: !isValid,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8),
                                                          child: Text(
                                                            ErrorParser.getLocalisedStringError(
                                                                error: data!
                                                                    .appError,
                                                                localisedHelper:
                                                                    S.of(
                                                                        context)),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .vivid_red),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          ProfileRowItem(
                                            title:
                                                S.of(context).profileDetailsQ3,
                                            providerBase:
                                                profileQ3ViewModelProvider,
                                            activeText: S.of(context).yes,
                                            inactiveText: S.of(context).no,
                                            onToggle: (isActive) {
                                              model.isRelative = isActive;
                                              return Visibility(
                                                visible: isActive,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 16.0),
                                                  child: AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .employmentStatus,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    inputType:
                                                        TextInputType.text,
                                                    controller: model
                                                        .relationShipController,
                                                    key: model
                                                        .relationShipWithPepKey,
                                                    readOnly: true,
                                                    suffixIcon:
                                                        (enabled, value) {
                                                      return InkWell(
                                                          onTap: () async {
                                                            model
                                                                .updateAnimatedValue(
                                                                    true);
                                                            EmploymentStatusDialog
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
                                                                  .updateAnimatedValue(
                                                                      false);
                                                              model
                                                                  .updateRelationShipWithPEP(
                                                                      value);
                                                            });
                                                          },
                                                          child: AppSvg.asset(
                                                              AssetUtils
                                                                  .dropDown,
                                                              width: 16,
                                                              height: 16));
                                                    },
                                                    textHintWidget: (hasFocus,
                                                        isValid, value) {
                                                      return Visibility(
                                                        visible: !isValid,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      16,
                                                                  vertical: 8),
                                                          child: Text(
                                                            ErrorParser.getLocalisedStringError(
                                                                error: data!
                                                                    .appError,
                                                                localisedHelper:
                                                                    S.of(
                                                                        context)),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColor
                                                                    .vivid_red),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
