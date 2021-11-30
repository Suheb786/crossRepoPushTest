import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/fatca_crs/get_fatca_questions_response.dart';
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
                child: AppStreamBuilder<Resource<SetFatcaQuestionsResponse>>(
                  stream: model.setFatcaQuestionsStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      if (model.isPEP &&
                          !model.bornInUS &&
                          !model.usTaxResident &&
                          !model.isUSCitizen &&
                          !model.anyOtherCountryResident) {
                        ProviderScope.containerOf(context)
                            .read(registerViewModelProvider)
                            .registrationStepsController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                      } else if (model.usTaxResident &&
                          !model.bornInUS &&
                          !model.isPEP &&
                          !model.anyOtherCountryResident &&
                          !model.isUSCitizen) {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .registrationStepFourPageController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                      } else if (model.usTaxResident &&
                          model.bornInUS &&
                          !model.isPEP &&
                          !model.anyOtherCountryResident &&
                          model.isUSCitizen) {
                        ProviderScope.containerOf(context)
                            .read(registerStepFourViewModelProvider)
                            .registrationStepFourPageController
                            .jumpToPage(4);
                      }
                      // else if (!model.usTaxResident &&
                      //     !model.bornInUS &&
                      //     !model.isPEP &&
                      //     model.anyOtherCountryResident &&
                      //     !model.isUSCitizen) {
                      //   ProviderScope.containerOf(context)
                      //       .read(registerStepFourViewModelProvider)
                      //       .registrationStepFourPageController
                      //       .jumpToPage(7);
                      // }
                      else {
                        ProviderScope.containerOf(context)
                            .read(registerViewModelProvider)
                            .registrationStepsController
                            .nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
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
                            child: AppStreamBuilder<
                                Resource<GetFatcaQuestionsResponse>>(
                              stream: model.getFatcaQuestionsStream,
                              initialData: Resource.none(),
                              onData: (data) {},
                              dataBuilder: (context, questions) {
                                switch (questions!.status) {
                                  case Status.SUCCESS:
                                    return SingleChildScrollView(
                                      physics: ClampingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          TaxationSwitchWidget(
                                            providerBase:
                                                areYouUSCitizenViewModelProvider,
                                            onToggle: (value) {
                                              model.isUSCitizen = value;
                                              return Container();
                                            },
                                            title: questions
                                                .data!
                                                .getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList![0]
                                                .labelEn!,
                                          ),
                                          TaxationSwitchWidget(
                                            providerBase:
                                                areYouUSTaxResidentViewModelProvider,
                                            onToggle: (value) {
                                              model.usTaxResident = value;
                                              return Container();
                                            },
                                            title: questions
                                                .data!
                                                .getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList![1]
                                                .labelEn!,

                                            ///TODO:specify hint text when received from api
                                            // hintText: S
                                            //     .of(context)
                                            //     .areYouUSTaxResidentHint,
                                          ),
                                          TaxationSwitchWidget(
                                            providerBase:
                                                bornInUSViewModelProvider,
                                            onToggle: (value) {
                                              model.bornInUS = value;
                                              return Container();
                                            },
                                            title: questions
                                                .data!
                                                .getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList![2]
                                                .labelEn!,
                                          ),
                                          TaxationSwitchWidget(
                                            providerBase:
                                                taxResidentOtherViewModelProvider,
                                            onToggle: (value) {
                                              model.anyOtherCountryResident =
                                                  value;
                                              return Visibility(
                                                visible: value,
                                                child: AppTextField(
                                                  labelText:
                                                      S.of(context).taxCountry,
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
                                                      model
                                                          .countrySelectorController
                                                          .text = value;
                                                      model.isValid();
                                                    });
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
                                              );
                                            },
                                            title: questions
                                                .data!
                                                .getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList![3]
                                                .labelEn!,
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
                                                      labelText: S
                                                          .of(context)
                                                          .relationShipWithPepCaps,
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
                                                      onPressed: () {
                                                        RelationshipWithPEPDialog
                                                            .show(context,
                                                                onDismissed:
                                                                    () {
                                                          Navigator.pop(
                                                              context);
                                                        }, onSelected: (value) {
                                                          Navigator.pop(
                                                              context);
                                                          model
                                                              .updateRelationShipWithPEP(
                                                                  value);
                                                          model.isValid();
                                                        });
                                                      },
                                                      suffixIcon:
                                                          (enabled, value) {
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
                                                    SizedBox(height: 16),
                                                    AppTextField(
                                                      labelText: S
                                                          .of(context)
                                                          .personName,
                                                      hintText: S
                                                          .of(context)
                                                          .pleaseEnter,
                                                      inputType:
                                                          TextInputType.text,
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
                                                      inputType:
                                                          TextInputType.text,
                                                      controller: model
                                                          .personRoleController,
                                                      key: model.personRoleKey,
                                                      onChanged: (value) {
                                                        model.isValid();
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                              .viewInsets
                                                              .bottom,
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            title: questions
                                                .data!
                                                .getFatcaQuestionsResponseContent!
                                                .fatcaQuestionsList![4]
                                                .labelEn!,
                                            secondaryText:
                                                S.of(context).whatIsPEP,
                                            onSecondaryTextTap: () {
                                              PEPDialog.show(context,
                                                  onSelected: () {
                                                Navigator.pop(context);
                                              });
                                            },
                                          ),
                                          AppStreamBuilder<bool>(
                                            stream:
                                                model.declarationSelectedStream,
                                            initialData: false,
                                            dataBuilder: (context, isSelected) {
                                              return DeclarationWidget(
                                                isSelected: isSelected,
                                                title1: S
                                                    .of(context)
                                                    .confirmThatTaxResidency,
                                                title2: S
                                                    .of(context)
                                                    .termAndCondition,
                                                title3: S.of(context).ofTheBank,
                                                onTap: () {
                                                  model
                                                      .updateDeclarationSelection(
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
                                                  stream: model
                                                      .allFieldValidatorStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isValid) {
                                                    return (isValid!)
                                                        ? AnimatedButton(
                                                            buttonText: S
                                                                .of(context)
                                                                .swipeToProceed)
                                                        : Container();
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                    );

                                  case Status.LOADING:
                                    return Center(
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Theme.of(context).primaryColor),
                                        strokeWidth: 2,
                                      ),
                                    );
                                  default:
                                    return Center(
                                      child: Text('Something went wrong'),
                                    );
                                }
                              },
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
