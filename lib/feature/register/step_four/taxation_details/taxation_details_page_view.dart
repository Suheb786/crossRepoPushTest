import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/fatca_crs/set_fatca_questions_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/taxation_details/taxation_details_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_four/pep_dialog/pep_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/relationship_with_pep/relationship_with_pep_dialog.dart';
import 'package:neo_bank/ui/molecules/register/declaration_widget.dart';
import 'package:neo_bank/ui/molecules/register/taxation_switch_widget/taxation_switch_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class TaxationDetailsPageView
    extends BasePageViewWidget<TaxationDetailsPageViewModel> {
  TaxationDetailsPageView(ProviderBase model) : super(model);

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
              child: AppStreamBuilder<Resource<SetFatcaQuestionsResponse>>(
                stream: model.setFatcaQuestionsStream,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.SUCCESS) {
                    ///storing response to main page
                    model.updateData(context);
                    if (model.isPEP &&
                        !model.bornInUS &&
                        !model.usTaxResident &&
                        !model.isUSCitizen &&
                        !model.anyOtherCountryResident) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope
                            .containerOf(context)
                            .read(registerViewModelProvider)
                            .registrationStepsController
                            .nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      });
                    } else if (model.usTaxResident &&
                        !model.bornInUS &&
                        !model.isPEP &&
                        !model.anyOtherCountryResident &&
                        !model.isUSCitizen) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope
                            .containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .registrationStepFourPageController
                            .next();
                      });
                    } else if (model.usTaxResident &&
                        model.bornInUS &&
                        !model.isPEP &&
                        !model.anyOtherCountryResident &&
                        model.isUSCitizen) {
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope
                            .containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .registrationStepFourPageController
                            .move(4);
                      });
                    } else {
                      Future.delayed(Duration(milliseconds: 500), () {
                        ProviderScope
                            .containerOf(context)
                            .read(registerViewModelProvider)
                            .registrationStepsController
                            .nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut);
                      });
                    }
                  } else if (data.status == Status.ERROR) {
                    model.showToastWithError(data.appError!);
                  }
                },
                dataBuilder: (context, response) {
                  return GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity!.isNegative) {
                        model.setFatcaQuestionResponse();
                      }
                    },
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery
                                .of(context)
                                .viewInsets
                                .bottom - 50 <=
                                0
                                ? 0
                                : MediaQuery
                                .of(context)
                                .viewInsets
                                .bottom - 48),
                        child: SingleChildScrollView(
                          padding:
                          EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                          physics: ClampingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TaxationSwitchWidget(
                                providerBase: areYouUSCitizenViewModelProvider,
                                onToggle: (value) {
                                  model.isUSCitizen = value;
                                  return Container();
                                },
                                title: S
                                    .of(context)
                                    .areYouUSCitizen,
                              ),
                              TaxationSwitchWidget(
                                providerBase: areYouUSTaxResidentViewModelProvider,
                                onToggle: (value) {
                                  model.usTaxResident = value;
                                  return Container();
                                },
                                title: S
                                    .of(context)
                                    .areYouUSTaxResident,

                                ///TODO:specify hint text when received from api
                                hintText: S
                                    .of(context)
                                    .areYouUSTaxResidentHint,
                              ),
                              TaxationSwitchWidget(
                                providerBase: bornInUSViewModelProvider,
                                onToggle: (value) {
                                  model.bornInUS = value;
                                  return Container();
                                },
                                title: S
                                    .of(context)
                                    .wereBornInUS,
                              ),
                              TaxationSwitchWidget(
                                providerBase: taxResidentOtherViewModelProvider,
                                onToggle: (value) {
                                  model.anyOtherCountryResident = value;
                                  return Visibility(
                                    visible: value,
                                    child: AppTextField(
                                      labelText: S
                                          .of(context)
                                          .taxCountry,
                                      hintText: S
                                          .of(context)
                                          .pleaseSelect,
                                      controller: model
                                          .countrySelectorController,
                                      key: model.countrySelectorKey,
                                      readOnly: true,
                                      onPressed: () {
                                        CountryDialog.show(context,
                                            title: S
                                                .of(context)
                                                .taxCountrySmall,
                                            onDismissed: () {
                                              Navigator.pop(context);
                                            }, onSelected: (value) {
                                              Navigator.pop(context);
                                              model.countrySelectorController
                                                  .text =
                                                  value;
                                              model.isValid();
                                            });
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
                                  );
                                },
                                title: S
                                    .of(context)
                                    .anyOtherCountryTaxResident,
                              ),
                              TaxationSwitchWidget(
                                providerBase:
                                areYouFirstDegreeRelativeViewModelProvider,
                                onToggle: (value) {
                                  model.isPEP = value;
                                  return Visibility(
                                    visible: value,
                                    child: Column(
                                      children: [
                                        AppTextField(
                                          labelText:
                                          S
                                              .of(context)
                                              .relationShipWithPepCaps,
                                          hintText: S
                                              .of(context)
                                              .pleaseSelect,
                                          inputType: TextInputType.text,
                                          controller: model
                                              .relationShipController,
                                          key: model.relationShipWithPepKey,
                                          readOnly: true,
                                          onPressed: () {
                                            RelationshipWithPEPDialog.show(
                                                context,
                                                onDismissed: () {
                                                  Navigator.pop(context);
                                                }, onSelected: (value) {
                                              Navigator.pop(context);
                                              model
                                                  .updateRelationShipWithPEP(
                                                  value);
                                              model.isValid();
                                            });
                                          },
                                          suffixIcon: (enabled, value) {
                                            return Container(
                                                height: 16,
                                                width: 16,
                                                padding: EdgeInsets.only(
                                                    right: 8),
                                                child: AppSvg.asset(
                                                    AssetUtils.downArrow,
                                                    color: AppColor
                                                        .dark_gray_1));
                                          },
                                        ),
                                        SizedBox(height: 16),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .personName,
                                          hintText: S
                                              .of(context)
                                              .pleaseEnter,
                                          inputType: TextInputType.text,
                                          controller: model
                                              .personNameController,
                                          key: model.personNameKey,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                        SizedBox(height: 16),
                                        AppTextField(
                                          labelText: S
                                              .of(context)
                                              .personRole,
                                          hintText: S
                                              .of(context)
                                              .pleaseEnter,
                                          inputType: TextInputType.text,
                                          controller: model
                                              .personRoleController,
                                          key: model.personRoleKey,
                                          onChanged: (value) {
                                            model.isValid();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                title: S
                                    .of(context)
                                    .areYouFirstDegreeRelativePEP,
                                secondaryText: S
                                    .of(context)
                                    .whatIsPEP,
                                onSecondaryTextTap: () {
                                  PEPDialog.show(context, onSelected: () {
                                    Navigator.pop(context);
                                  });
                                },
                              ),
                              AppStreamBuilder<bool>(
                                stream: model.declarationSelectedStream,
                                initialData: false,
                                dataBuilder: (context, isSelected) {
                                  return DeclarationWidget(
                                    isSelected: isSelected,
                                    title1: S
                                        .of(context)
                                        .iConfirmThatAllInfoAccurateFatca,
                                    onTap: () {
                                      model.updateDeclarationSelection(
                                          !(isSelected!));
                                      model.isValid();
                                    },
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
                                            S
                                                .of(context)
                                                .swipeToProceed)
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
