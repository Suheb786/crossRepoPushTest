import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/tax_payer/tax_payer_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class FatcaUSW8TaxPayersDetailsPageView
    extends BasePageViewWidget<FatcaUSW8TaxPayersDetailsPageViewModel> {
  FatcaUSW8TaxPayersDetailsPageView(ProviderBase model) : super(model);

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
                  stream: model.fatcaUSW8taxPayerDetailsStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerStepFourViewModelProvider)
                          .registrationStepFourPageController
                          .jumpToPage(7);
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateFatcaUSW8TaxPayersDetails();
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
                        shadowColor: Theme.of(context)
                            .primaryColorDark
                            .withOpacity(0.32),
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 32, horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        AppTextField(
                                          labelText:
                                              S.of(context).whichTaxPayerAreYou,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.taxPayerTypeController,
                                          key: model.taxPayerTypeKey,
                                          readOnly: true,
                                          onPressed: () {
                                            TaxPayerDialog.show(context,
                                                taxPayerTypeEnum:
                                                    TaxPayerTypeEnum.W8,
                                                onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: (value) {
                                              Navigator.pop(context);
                                              model.updateTaxPayerTypeField(
                                                  value);
                                              model.isValid();
                                            });
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16,
                                                width: 16,
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: AppSvg.asset(
                                                    AssetUtils.downArrow,
                                                    color:
                                                        AppColor.dark_gray_1));
                                          },
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        AppStreamBuilder<bool>(
                                          stream: model
                                              .identificationVisibilityStream,
                                          initialData: false,
                                          dataBuilder: (context, isVisible) {
                                            return Visibility(
                                              visible: isVisible!,
                                              child: Column(
                                                children: [
                                                  AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .usIDNumber
                                                        .toUpperCase(),
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .identificationNumberController,
                                                    key: model
                                                        .identificationNumberKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    labelIcon: () {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            ///TODO:Navigate to us tax identification number page
                                                          },
                                                          child: AppSvg.asset(
                                                              AssetUtils.info,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
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
                                                    labelText: S
                                                        .of(context)
                                                        .referenceNumber,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller: model
                                                        .referenceNumberController,
                                                    key: model
                                                        .referenceNumberKey,
                                                    inputAction:
                                                        TextInputAction.go,
                                                    labelIcon: () {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            ///TODO:Navigate to us reference page
                                                          },
                                                          child: AppSvg.asset(
                                                              AssetUtils.info,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColorDark),
                                                        ),
                                                      );
                                                    },
                                                    onChanged: (value) {
                                                      model.isValid();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        AppStreamBuilder<bool>(
                                          stream: model.taxTreatyBenefitsValue,
                                          initialData: false,
                                          dataBuilder: (context, isActive) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 24.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AppSwitchLabelWidget(
                                                    label: S
                                                        .of(context)
                                                        .wantToClaimTaxTreatyBenefits,
                                                    inActiveText:
                                                        S.of(context).no,
                                                    activeText:
                                                        S.of(context).yes,
                                                    onToggle: (value) {
                                                      model
                                                          .updateTaxTreatyBenefitsValue(
                                                              value);
                                                      model.isValid();
                                                    },
                                                    isActive: isActive,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      ///TODO:Navigate to info of what is Tax treaty Benefits
                                                    },
                                                    child: Text(
                                                      S
                                                          .of(context)
                                                          .whatIsTaxTreatyBenefits,
                                                      style: TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .accentTextTheme
                                                              .bodyText1!
                                                              .color,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Visibility(
                                                    visible: isActive!,
                                                    child: Column(
                                                      children: [
                                                        AppTextField(
                                                          labelText: S
                                                              .of(context)
                                                              .beneficialOwnerIsAResidenceOf
                                                              .toUpperCase(),
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseSelect,
                                                          controller: model
                                                              .beneficialCountryController,
                                                          key: model
                                                              .beneficialCountryKey,
                                                          readOnly: true,
                                                          onPressed: () {
                                                            CountryDialog.show(
                                                                context,
                                                                title: S
                                                                    .of(context)
                                                                    .beneficialOwnerIsAResidenceOf,
                                                                onDismissed:
                                                                    () {
                                                              Navigator.pop(
                                                                  context);
                                                            }, onSelected:
                                                                    (value) {
                                                              Navigator.pop(
                                                                  context);
                                                              model
                                                                  .beneficialCountryController
                                                                  .text = value;
                                                              model.isValid();
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
                                                        ),
                                                        SizedBox(
                                                          height: 16,
                                                        ),
                                                        AppTextField(
                                                          labelText: S
                                                              .of(context)
                                                              .provisionClaim
                                                              .toUpperCase(),
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseSelect,
                                                          controller: model
                                                              .provisionClaimController,
                                                          key: model
                                                              .provisionClaimKey,
                                                          inputType:
                                                              TextInputType
                                                                  .text,
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
                                                              .treatyClaimRate
                                                              .toUpperCase(),
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseEnter,
                                                          controller: model
                                                              .treatyClaimRateController,
                                                          key: model
                                                              .treatyClaimRateKey,
                                                          inputType:
                                                              TextInputType
                                                                  .text,
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
                                                              .typeOfIncome
                                                              .toUpperCase(),
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseEnter,
                                                          controller: model
                                                              .incomeTypeController,
                                                          key: model
                                                              .incomeTypeKey,
                                                          inputAction:
                                                              TextInputAction
                                                                  .go,
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
                                                              .explanation,
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseEnter,
                                                          controller: model
                                                              .explanationController,
                                                          key: model
                                                              .explanationKey,
                                                          inputAction:
                                                              TextInputAction
                                                                  .go,
                                                          onChanged: (value) {
                                                            model.isValid();
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Center(
                                  child: AppStreamBuilder<bool>(
                                    stream:
                                    model.allFieldValidatorStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16.0),
                                        child: Visibility(
                                          visible: isValid!,
                                          child: AnimatedButton(
                                              buttonText: S
                                                  .of(context)
                                                  .swipeToProceed),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
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
