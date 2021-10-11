import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/register/step_three/employment_status/employment_status_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employer_country/employer_country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/employment_status/employment_status_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/occupation/occupation_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class EmploymentStatusPageView
    extends BasePageViewWidget<EmploymentStatusPageViewModel> {
  EmploymentStatusPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
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
              S.of(context).tellUsAboutYourJob,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColor.very_dark_gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  decoration: BoxDecoration(
                    color: AppColor.very_soft_violet,
                    gradient: LinearGradient(colors: [
                      AppColor.dark_violet,
                      AppColor.dark_moderate_blue
                    ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  ),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        AppTextField(
                          labelText: S.of(context).employmentStatus,
                          hintText: S.of(context).pleaseSelect,
                          controller: model.employmentStatusController,
                          key: model.employmentStatusKey,
                          readOnly: true,
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {
                                EmploymentStatusDialog.show(context,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updateEmploymentStatus(value);
                                });
                              },
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow)),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).occupation,
                          hintText: S.of(context).pleaseSelect,
                          controller: model.occupationController,
                          key: model.occupationKey,
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {
                                OccupationDialog.show(context, onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updateOccupation(value);
                                });
                              },
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow)),
                            );
                          },
                          readOnly: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).mainSourceOfIncome,
                          hintText: S.of(context).pleaseEnter,
                          controller: model.sourceController,
                          inputType: TextInputType.text,
                          key: model.sourceKey,
                          labelIcon: () {
                            return InkWell(
                              onTap: () async {},
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Container(
                                    height: 14,
                                    width: 14,
                                    child: AppSvg.asset(AssetUtils.info)),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).monthlyIncome,
                          hintText: '',
                          controller: model.monthlyIncomeController,
                          inputType: TextInputType.number,
                          key: model.monthlyIncomeKey,
                          prefixIcon: () {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 8),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.very_light_gray_white),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).annualIncome,
                          hintText: '',
                          controller: model.annualIncomeController,
                          key: model.annualIncomeKey,
                          inputType: TextInputType.number,
                          prefixIcon: () {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 8),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.very_light_gray_white),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).purposeOfAccountOpening,
                          hintText: S.of(context).pleaseSelect,
                          controller: model.purposeOfAccountOpeningController,
                          key: model.purposeOfAccountOpeningKey,
                          readOnly: true,
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {
                                PurposeOfAccountOpeningDialog.show(context,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updatePurposeOfAccountOpening(value);
                                });
                              },
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow)),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).employerName,
                          hintText: S.of(context).pleaseEnter,
                          controller: model.employerNameController,
                          inputType: TextInputType.text,
                          key: model.employerNameKey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).employerCountry,
                          hintText: S.of(context).pleaseSelect,
                          controller: model.employerCountryController,
                          readOnly: true,
                          key: model.employerCountryKey,
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {
                                EmployerCountryDialog.show(context,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updateEmployerCountry(value);
                                });
                              },
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow)),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).employerCity,
                          hintText: S.of(context).pleaseEnter,
                          controller: model.employerCityController,
                          inputType: TextInputType.text,
                          key: model.employerCityKey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).employerContact,
                          hintText: S.of(context).pleaseEnter,
                          inputType: TextInputType.number,
                          controller: model.employerContactController,
                          key: model.employerContactKey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).additionalSourceOfIncome,
                          hintText: S.of(context).pleaseSelect,
                          controller: model.additionalSourceIncomeController,
                          readOnly: true,
                          key: model.additionalSourceIncomeKey,
                          suffixIcon: (value, data) {
                            return InkWell(
                              onTap: () async {
                                AdditionalIncomeSourceDialog.show(context,
                                    onDismissed: () {
                                  Navigator.pop(context);
                                }, onSelected: (value) {
                                  Navigator.pop(context);
                                  model.updateAdditionalIncome(value);
                                });
                              },
                              child: Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsets.only(right: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow)),
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextField(
                          labelText: S.of(context).totalAdditionalIncome,
                          hintText: '',
                          controller: model.totalAdditionalIncomeController,
                          key: model.totalAdditionalIncomeKey,
                          inputType: TextInputType.number,
                          prefixIcon: () {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, right: 8),
                              child: Text(
                                S.of(context).JOD,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.very_light_gray_white),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
