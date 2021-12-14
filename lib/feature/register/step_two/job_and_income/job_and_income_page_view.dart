import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_two/job_and_income/job_and_income_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
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
import 'package:neo_bank/utils/status.dart';

class JobAndIncomePageView
    extends BasePageViewWidget<JobAndIncomePageViewModel> {
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
                      .nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                });
              } else if (data.status == Status.ERROR) {
                model.showToastWithError(data.appError!);
              }
            },
            dataBuilder: (context, response) {
              return GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity!.isNegative) {
                    model.validateJobAndIncomeDetails();
                  }
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom - 50 <=
                                0
                            ? 0
                            : MediaQuery.of(context).viewInsets.bottom - 48),
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      physics: ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          Visibility(
                            visible: model.employmentStatusEnum ==
                                    EmploymentStatusEnum.FULL_TIME_EMPLOYEE ||
                                model.employmentStatusEnum ==
                                    EmploymentStatusEnum.PART_TIME_EMPLOYEE,
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText: S.of(context).occupation,
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.occupationController,
                                  readOnly: true,
                                  key: model.occupationKey,
                                  onPressed: () {
                                    OccupationDialog.show(context,
                                        employmentStatusEnum:
                                            model.employmentStatusEnum,
                                        title: S.of(context).occupationSmall,
                                        onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (data) {
                                      Navigator.pop(context);
                                      model.occupationController.text = data;
                                      model.isValid();
                                    },
                                        businessTypeList:
                                            model.businessTypeList);
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
                              ],
                            ),
                          ),
                          Visibility(
                            visible: model.employmentStatusEnum ==
                                EmploymentStatusEnum.BUSINESS_OWNER,
                            child: Column(
                              children: [
                                AppTextField(
                                  labelText:
                                      S.of(context).businessType.toUpperCase(),
                                  hintText: S.of(context).pleaseSelect,
                                  controller: model.businessTypeController,
                                  readOnly: true,
                                  key: model.businessTypeKey,
                                  onPressed: () {
                                    OccupationDialog.show(context,
                                        employmentStatusEnum:
                                            model.employmentStatusEnum,
                                        title: S.of(context).businessType,
                                        onDismissed: () {
                                      Navigator.pop(context);
                                    }, onSelected: (data) {
                                      Navigator.pop(context);
                                      model.businessTypeController.text = data;
                                      model.updateBusinessTypeOtherVisibility();
                                      model.isValid();
                                    },
                                        businessTypeList:
                                            model.businessTypeList);
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
                                      controller:
                                          model.businessTypeOtherController,
                                      inputType: TextInputType.text,
                                      inputAction: TextInputAction.go,
                                      key: model.businessTypeOtherKey,
                                      onChanged: (value) {
                                        model.isValid();
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          AppTextField(
                            labelText: S.of(context).mainAnnualIncome,
                            hintText: '',
                            controller: model.annualIncomeController,
                            key: model.annualIncomeKey,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.done,
                            prefixIcon: () {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 8.0, right: 8),
                                child: Text(
                                  S.of(context).JOD,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyText1!
                                          .color!),
                                ),
                              );
                            },
                            onChanged: (value) {
                              model.isValid();
                            },
                          ),
                          SizedBox(
                            height: 16,
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
                            height: 16,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerCountry,
                            hintText: S.of(context).pleaseSelect,
                            controller: model.employerCountryController,
                            readOnly: true,
                            key: model.employerCountryKey,
                            onPressed: () {
                              CountryDialog.show(context,
                                  title: S.of(context).employerCountrySmall,
                                  onDismissed: () {
                                Navigator.pop(context);
                              }, onSelected: (value) {
                                Navigator.pop(context);
                                model.updateEmployerCountry(value);
                                model.isValid();
                              });
                            },
                            suffixIcon: (value, data) {
                              return Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow,
                                      color: AppColor.dark_gray_1));
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerCity,
                            hintText: S.of(context).pleaseEnter,
                            controller: model.employerCityController,
                            inputType: TextInputType.text,
                            inputAction: TextInputAction.go,
                            key: model.employerCityKey,
                            onChanged: (value) {
                              model.isValid();
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          AppTextField(
                            labelText: S.of(context).employerContact,
                            hintText: S.of(context).pleaseEnter,
                            inputType: TextInputType.number,
                            inputAction: TextInputAction.done,
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
                                padding: const EdgeInsets.only(top: 32.0),
                                child: Column(
                                  children: [
                                    AppSwitchLabelWidget(
                                      label: S
                                          .of(context)
                                          .doYouHaveAdditionalSourceOfIncome,
                                      inActiveText: S.of(context).no,
                                      activeText: S.of(context).yes,
                                      onToggle: (value) {
                                        model.updateSwitchValue(value);
                                      },
                                      isActive: isActive,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Visibility(
                                      visible: isActive!,
                                      child: AppStreamBuilder<
                                          List<AdditionalIncomeType>>(
                                        stream: model
                                            .additionalSourceIncomeListStream,
                                        initialData: [],
                                        dataBuilder: (context, dataList) {
                                          if (dataList!.isNotEmpty) {
                                            return ListView.builder(
                                                itemCount: dataList.length + 1,
                                                physics:
                                                    ClampingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  if (index ==
                                                      dataList.length) {
                                                    return AddIncomeWidget(
                                                      label: S
                                                          .of(context)
                                                          .addIncome,
                                                      onTap: () {
                                                        AdditionalIncomeSourceDialog
                                                            .show(context,
                                                                onDismissed:
                                                                    () {
                                                          Navigator.pop(
                                                              context);
                                                        }, onSelected: (value) {
                                                          Navigator.pop(
                                                              context);
                                                          model
                                                              .addAdditionalIncomeList(
                                                                  value);
                                                        });
                                                      },
                                                    );
                                                  }
                                                  return AdditionalIncomeSourceWidget(
                                                    additionalIncomeSourceParams:
                                                        dataList[index],
                                                    onTap: () {
                                                      model
                                                          .removeAdditionalItem(
                                                              index);
                                                    },
                                                  );
                                                });
                                          } else {
                                            return AddIncomeWidget(
                                              label: S.of(context).addIncome,
                                              onTap: () {
                                                AdditionalIncomeSourceDialog
                                                    .show(context,
                                                        onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                                  Navigator.pop(context);
                                                  model.addAdditionalIncomeList(
                                                      value);
                                                });
                                              },
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
                              padding: EdgeInsets.only(top: 32),
                              child: AppStreamBuilder<bool>(
                                  stream: model.allFieldValidatorStream,
                                  initialData: false,
                                  dataBuilder: (context, isValid) {
                                    return (isValid!)
                                        ? AnimatedButton(
                                            buttonText:
                                                S.of(context).swipeToProceed,
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
