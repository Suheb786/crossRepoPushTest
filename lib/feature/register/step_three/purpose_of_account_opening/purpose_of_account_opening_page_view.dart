import 'package:animated_widgets/animated_widgets.dart';
import 'package:domain/model/register/expected_Transactionss.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/register/step_three/purpose_of_account_opening/purpose_of_account_opening_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/purpose_of_account_opening/purpose_of_account_opening_dialog.dart';
import 'package:neo_bank/ui/molecules/register/app_switch_label_widget.dart';
import 'package:neo_bank/ui/molecules/register/expected_transactions_selector_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class PurposeOfAccountOpeningPageView
    extends BasePageViewWidget<PurposeOfAccountOpeningPageViewModel> {
  PurposeOfAccountOpeningPageView(ProviderBase model) : super(model);

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
                  stream: model.purposeOfAccountOpeningStream,
                  initialData: Resource.none(),
                  onData: (data) {
                    if (data.status == Status.SUCCESS) {
                      ProviderScope.containerOf(context)
                          .read(registerViewModelProvider)
                          .registrationStepsController
                          .nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                    } else if (data.status == Status.ERROR) {
                      model.showToastWithError(data.appError!);
                    }
                  },
                  dataBuilder: (context, response) {
                    return GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta!.isNegative) {
                          model.validatePurposeOfAccountOpening();
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
                            child: SingleChildScrollView(
                              physics: ClampingScrollPhysics(),
                              child: Column(
                                children: [
                                  AppStreamBuilder<bool>(
                                    stream: model.beneficialOwnerAccountStream,
                                    initialData: false,
                                    dataBuilder: (context, isActive) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 32.0),
                                        child: AppSwitchLabelWidget(
                                          label: S
                                              .of(context)
                                              .areYouBeneficialOwnerAccount,
                                          inActiveText: S.of(context).no,
                                          activeText: S.of(context).yes,
                                          onToggle: (value) {
                                            model
                                                .updateBeneficialOwnerAccountValue(
                                                    value);
                                          },
                                          isActive: isActive,
                                        ),
                                      );
                                    },
                                  ),
                                  AppTextField(
                                    labelText:
                                        S.of(context).purposeOfAccountOpening,
                                    hintText: S.of(context).pleaseSelect,
                                    controller:
                                        model.purposeOfAccountOpeningController,
                                    key: model.purposeOfAccountOpeningKey,
                                    readOnly: true,
                                    suffixIcon: (value, data) {
                                      return InkWell(
                                        onTap: () async {
                                          PurposeOfAccountOpeningDialog.show(
                                              context, onDismissed: () {
                                            Navigator.pop(context);
                                          }, onSelected: (value) {
                                            Navigator.pop(context);
                                            model.updatePurposeOfAccountOpening(
                                                value);
                                            model.isValid();
                                          });
                                        },
                                        child: Container(
                                            height: 16,
                                            width: 16,
                                            padding: EdgeInsets.only(right: 8),
                                            child: AppSvg.asset(
                                                AssetUtils.downArrow)),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                  AppStreamBuilder<
                                      Resource<List<ExpectedTransactions>>>(
                                    stream: model.getExpectedTransactionsStream,
                                    initialData: Resource.none(),
                                    dataBuilder:
                                        (context, expectedTransactions) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            S
                                                .of(context)
                                                .typeOfExpectedTransactions,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                color: AppColor
                                                    .very_light_gray_white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          ListView.builder(
                                            itemBuilder: (context, index) {
                                              return ExpectedTransactionsSelectorWidget(
                                                expectedTransactions:
                                                    expectedTransactions!
                                                        .data![index],
                                                onTap: () {
                                                  model
                                                      .selectExpectedTransactions(
                                                          index);
                                                },
                                              );
                                            },
                                            physics: ClampingScrollPhysics(),
                                            itemCount: expectedTransactions!
                                                .data!.length,
                                            shrinkWrap: true,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  AppTextField(
                                    labelText: S
                                        .of(context)
                                        .expectedMonthlyTransactions,
                                    hintText: '',
                                    controller: model
                                        .expectedMonthlyTransactionController,
                                    key: model.expectedMonthlyTransactionKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    prefixIcon: () {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor
                                                  .very_light_gray_white),
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
                                        .expectedAnnualTransactions,
                                    hintText: '',
                                    controller: model
                                        .expectedAnnualTransactionController,
                                    key: model.expectedAnnualTransactionKey,
                                    inputType: TextInputType.number,
                                    inputAction: TextInputAction.done,
                                    prefixIcon: () {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 8),
                                        child: Text(
                                          S.of(context).JOD,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: AppColor
                                                  .very_light_gray_white),
                                        ),
                                      );
                                    },
                                    onChanged: (value) {
                                      model.isValid();
                                    },
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.only(right: 45, top: 24),
                                      child: AppStreamBuilder<bool>(
                                          stream: model.allFieldValidatorStream,
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
                                    ),
                                  )
                                ],
                              ),
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
