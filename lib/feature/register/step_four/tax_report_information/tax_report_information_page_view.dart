import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_four/tax_report_information/tax_report_information_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/country_dialog/country_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/reason_of_unavailability/reason_of_unavailability_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class TaxReportInformationPageView
    extends BasePageViewWidget<TaxReportInformationPageViewModel> {
  TaxReportInformationPageView(ProviderBase model) : super(model);

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
                  stream: model.taxReportInformationStream,
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
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validateTaxReportInformation();
                        } else {
                          Future.delayed(Duration(milliseconds: 500), () {
                            ProviderScope.containerOf(context)
                                .read(registerStepFourViewModelProvider)
                                .registrationStepFourPageController
                                .move(0);
                          });
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        shadowColor: AppColor.black.withOpacity(0.32),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: ClampingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        AppTextField(
                                          labelText: S.of(context).taxCountry,
                                          hintText: S.of(context).pleaseSelect,
                                          controller:
                                              model.countrySelectorController,
                                          key: model.countrySelectorKey,
                                          readOnly: true,
                                          suffixIcon: (value, data) {
                                            return InkWell(
                                              onTap: () async {
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
                                                      .text = value.countryName!;
                                                  model.validateFields();
                                                });
                                              },
                                              child: Container(
                                                  height: 16,
                                                  width: 16,
                                                  padding:
                                                      EdgeInsets.only(right: 8),
                                                  child: AppSvg.asset(
                                                      AssetUtils.downArrow)),
                                            );
                                          },
                                        ),
                                        AppStreamBuilder<bool>(
                                          stream: model.switchValue,
                                          initialData: true,
                                          dataBuilder: (context, isActive) {
                                            return Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 28.0),
                                                  child: AppSwitchLabelWidget(
                                                    label: S
                                                        .of(context)
                                                        .doYouHaveTinAvailable,
                                                    inActiveText:
                                                        S.of(context).no,
                                                    activeText:
                                                        S.of(context).yes,
                                                    onToggle: (value) {
                                                      model.updateSwitchValue(
                                                          value);
                                                      model.reasonController
                                                          .clear();
                                                      model
                                                          .explainReasonController
                                                          .clear();
                                                      model.tinController
                                                          .clear();
                                                      model
                                                          .updateExplainReasonVisibility(
                                                              false);
                                                      model
                                                          .updateValidateFieldValue(
                                                              false);
                                                    },
                                                    isActive: isActive,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: isActive!,
                                                  child: AppTextField(
                                                    key: model.tinKey,
                                                    labelText:
                                                        S.of(context).tinNo,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseEnter,
                                                    controller:
                                                        model.tinController,
                                                    onChanged: (value) {
                                                      model.validateFields();
                                                    },
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: !isActive,
                                                  child: AppTextField(
                                                    labelText: S
                                                        .of(context)
                                                        .reasonOfUnavailability,
                                                    hintText: S
                                                        .of(context)
                                                        .pleaseSelect,
                                                    controller:
                                                        model.reasonController,
                                                    key:
                                                        model.reasonSelectorKey,
                                                    readOnly: true,
                                                    suffixIcon: (value, data) {
                                                      return InkWell(
                                                        onTap: () async {
                                                          ReasonOfUnavailabilityDialog
                                                              .show(context,
                                                                  onSelected:
                                                                      (value) {
                                                            Navigator.pop(
                                                                context);
                                                            model
                                                                .updateReasonControllerField(
                                                                    value);
                                                            model
                                                                .validateFields();
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
                                                                    .downArrow)),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                AppStreamBuilder<bool>(
                                                  stream:
                                                      model.explainReasonStream,
                                                  initialData: false,
                                                  dataBuilder:
                                                      (context, isVisible) {
                                                    return Visibility(
                                                      visible: isVisible!,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                top: 16.0),
                                                        child: AppTextField(
                                                          labelText: S
                                                              .of(context)
                                                              .explainReason,
                                                          hintText: S
                                                              .of(context)
                                                              .pleaseEnter,
                                                          key: model
                                                              .explainReasonKey,
                                                          controller: model
                                                              .explainReasonController,
                                                          onChanged: (value) {
                                                            model
                                                                .validateFields();
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: AppSvg.asset(
                                            AssetUtils.saveAndExit)),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 45, top: 24),
                                      child: AppStreamBuilder<bool>(
                                          stream: model
                                              .taxReportFieldValidateStream,
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
                                    )
                                  ],
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
