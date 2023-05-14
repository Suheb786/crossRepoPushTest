import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/constants/enum/tax_payer_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/fatca_us_w8_tax_payer_details/fatca_us_w8_tax_payer_details_page_view_model.dart';
import 'package:neo_bank/feature/static_content/claim_of_tax_treaty_benefits/claim_of_tax_treaty_benefits_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
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
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class FatcaUSW8TaxPayersDetailsPageView extends BasePageViewWidget<FatcaUSW8TaxPayersDetailsPageViewModel> {
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
                      model.updateData(context);
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .moveToPage(7);
                        // .move(7, animation: false);
                      });
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (ProviderScope.containerOf(context)
                                .read(registerStepFourViewModelProvider)
                                .appSwiperController
                                .page ==
                            3.0) {
                          FocusScope.of(context).unfocus();
                          if (StringUtils.isDirectionRTL(context)) {
                            if (!details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSW8TaxPayersDetails();
                            } else {
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .previousPage();
                                // .previous();
                              });
                            }
                          } else {
                            if (details.primaryVelocity!.isNegative) {
                              model.validateFatcaUSW8TaxPayersDetails();
                            } else {
                              Future.delayed(Duration(milliseconds: 500), () {
                                ProviderScope.containerOf(context)
                                    .read(registerStepFourViewModelProvider)
                                    .previousPage();
                                // .previous();
                              });
                            }
                          }
                        }
                      },
                      child: Card(
                        child: Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).viewInsets.bottom - 50.0.h <= 0
                                    ? 0
                                    : MediaQuery.of(context).viewInsets.bottom - 48.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        AppTextField(
                                          labelText: S.of(context).whichTaxPayerAreYou,
                                          hintText: S.of(context).pleaseSelect,
                                          controller: model.taxPayerTypeController,
                                          key: model.taxPayerTypeKey,
                                          readOnly: true,
                                          onPressed: () {
                                            TaxPayerDialog.show(context,
                                                taxPayerTypeEnum: TaxPayerTypeEnum.W8, onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: (value, englishValue) {
                                              Navigator.pop(context);
                                              model.taxPayerVisibility(true);
                                              model.updateTaxPayerTypeField(value, englishValue);
                                              model.identificationNumberController.clear();
                                              model.foreignIdentificationNumberController.clear();
                                              model.referenceNumberController.clear();
                                              model.isValid();
                                            });
                                          },
                                          suffixIcon: (value, data) {
                                            return Container(
                                                height: 16.h,
                                                width: 16.w,
                                                padding: EdgeInsetsDirectional.only(end: 8.w),
                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                    color: AppColor.dark_gray_1));
                                          },
                                        ),
                                        SizedBox(
                                          height: 16.h,
                                        ),
                                        AppStreamBuilder<bool>(
                                            stream: model.taxPayerVisibilityStream,
                                            initialData: false,
                                            dataBuilder: (context, isActive) {
                                              return Visibility(
                                                visible: isActive!,
                                                child: Column(
                                                  children: [
                                                    AppStreamBuilder<bool>(
                                                      stream: model.identificationVisibilityStream,
                                                      initialData: true,
                                                      dataBuilder: (context, isVisible) {
                                                        return (isVisible!)
                                                            ? AppTextField(
                                                                labelText:
                                                                    S.of(context).usIDNumber.toUpperCase(),
                                                                hintText: S.of(context).pleaseEnter,
                                                                controller:
                                                                    model.identificationNumberController,
                                                                key: model.identificationNumberKey,
                                                                inputAction: TextInputAction.go,
                                                                labelIcon: () {
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional.only(
                                                                        start: 4.0.w),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            RoutePaths
                                                                                .UsTaxPayerIdentificationNo);
                                                                      },
                                                                      child: AppSvg.asset(AssetUtils.info,
                                                                          color: Theme.of(context)
                                                                              .primaryColorDark),
                                                                    ),
                                                                  );
                                                                },
                                                                onChanged: (value) {
                                                                  model.isValid();
                                                                },
                                                              )
                                                            : AppTextField(
                                                                labelText: S
                                                                    .of(context)
                                                                    .foreignTaxIdNumber
                                                                    .toUpperCase(),
                                                                hintText: S.of(context).pleaseEnter,
                                                                controller: model
                                                                    .foreignIdentificationNumberController,
                                                                key: model.foreignIdentificationNumberKey,
                                                                inputAction: TextInputAction.go,
                                                                labelIcon: () {
                                                                  return Padding(
                                                                    padding: EdgeInsetsDirectional.only(
                                                                        start: 4.0.w),
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        ///TODO: create foreign identification info page
                                                                      },
                                                                      child: AppSvg.asset(AssetUtils.info,
                                                                          color: Theme.of(context)
                                                                              .primaryColorDark),
                                                                    ),
                                                                  );
                                                                },
                                                                onChanged: (value) {
                                                                  model.isValid();
                                                                },
                                                              );
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    AppTextField(
                                                      labelText: S.of(context).referenceNumber,
                                                      hintText: S.of(context).pleaseEnter,
                                                      controller: model.referenceNumberController,
                                                      key: model.referenceNumberKey,
                                                      inputAction: TextInputAction.go,
                                                      labelIcon: () {
                                                        return Padding(
                                                          padding: EdgeInsets.only(left: 4.0.w),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.pushNamed(
                                                                  context, RoutePaths.ReferenceNumber);
                                                            },
                                                            child: AppSvg.asset(AssetUtils.info,
                                                                color: Theme.of(context).primaryColorDark),
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
                                            }),
                                        AppStreamBuilder<bool>(
                                          stream: model.taxTreatyBenefitsValue,
                                          initialData: false,
                                          dataBuilder: (context, isActive) {
                                            return Padding(
                                              padding: EdgeInsets.only(top: 24.0.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AppSwitchLabelWidget(
                                                    label: S.of(context).wantToClaimTaxTreatyBenefits,
                                                    inActiveText: S.of(context).no.toUpperCase(),
                                                    activeText: S.of(context).yes.toUpperCase(),
                                                    onToggle: (value) {
                                                      model.updateTaxTreatyBenefitsValue(value);
                                                      model.isValid();
                                                    },
                                                    isActive: isActive,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.pushNamed(
                                                          context, RoutePaths.TaxTreatyBenefits,
                                                          arguments: ClaimOfTaxTreatyBenefitsArguments(
                                                              staticRouteContent:
                                                                  StaticRouteContent.TAX_TREATY_BENEFITS));
                                                    },
                                                    child: Text(
                                                      S.of(context).whatIsTaxTreatyBenefits,
                                                      style: TextStyle(
                                                          fontFamily: StringUtils.appFont,
                                                          color: Theme.of(context).textTheme.bodyMedium!.color!,
                                                          fontSize: 12.t,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 16.h,
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
                                                          hintText: S.of(context).pleaseSelect,
                                                          controller: model.beneficialCountryController,
                                                          key: model.beneficialCountryKey,
                                                          readOnly: true,
                                                          onPressed: () {
                                                            Future.delayed(Duration(milliseconds: 200), () {
                                                              CountryDialog.show(context,
                                                                  title: S
                                                                      .of(context)
                                                                      .beneficialOwnerIsAResidenceOf,
                                                                  onDismissed: () {
                                                                Navigator.pop(context);
                                                              }, onSelected: (value) {
                                                                Navigator.pop(context);
                                                                model.beneficialCountryController.text =
                                                                    value.countryName!;
                                                                model.isValid();
                                                              });
                                                            });
                                                          },
                                                          suffixIcon: (value, data) {
                                                            return Container(
                                                                height: 16.h,
                                                                width: 16.w,
                                                                padding: EdgeInsets.only(right: 8.w),
                                                                child: AppSvg.asset(AssetUtils.downArrow,
                                                                    color: AppColor.dark_gray_1));
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        AppTextField(
                                                          labelText:
                                                              S.of(context).provisionClaim.toUpperCase(),
                                                          hintText: S.of(context).pleaseSelect,
                                                          controller: model.provisionClaimController,
                                                          key: model.provisionClaimKey,
                                                          inputType: TextInputType.text,
                                                          onChanged: (value) {
                                                            model.isValid();
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        AppTextField(
                                                          labelText:
                                                              S.of(context).treatyClaimRate.toUpperCase(),
                                                          hintText: S.of(context).pleaseEnter,
                                                          controller: model.treatyClaimRateController,
                                                          key: model.treatyClaimRateKey,
                                                          inputType: TextInputType.text,
                                                          onChanged: (value) {
                                                            model.isValid();
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        AppTextField(
                                                          labelText: S.of(context).typeOfIncome.toUpperCase(),
                                                          hintText: S.of(context).pleaseEnter,
                                                          controller: model.incomeTypeController,
                                                          key: model.incomeTypeKey,
                                                          inputAction: TextInputAction.go,
                                                          onChanged: (value) {
                                                            model.isValid();
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        AppTextField(
                                                          labelText: S.of(context).explanation,
                                                          hintText: S.of(context).pleaseEnter,
                                                          controller: model.explanationController,
                                                          key: model.explanationKey,
                                                          inputAction: TextInputAction.go,
                                                          onChanged: (value) {
                                                            model.isValid();
                                                          },
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
                                    stream: model.allFieldValidatorStream,
                                    initialData: false,
                                    dataBuilder: (context, isValid) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 16.0, bottom: 32),
                                        child: Visibility(
                                          visible: isValid!,
                                          child: AnimatedButton(buttonText: S.of(context).swipeToProceed),
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
