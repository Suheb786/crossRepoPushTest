import 'package:domain/constants/error_types.dart';
import 'package:domain/model/card/get_loan_values/get_loan_values_response.dart';
import 'package:domain/model/card/process_loan_request/process_loan_request_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_application_failure/credit_card_application_failure_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/set_credit_limit/set_credit_limit_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/card_settings/relationship_with_cardholder/relationship_with_cardholder_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SetCreditLimitPageView
    extends BasePageViewWidget<SetCreditLimitViewModel> {
  SetCreditLimitPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, SetCreditLimitViewModel model) {
    return Column(
      children: [
        Expanded(
          child: AppKeyBoardHide(
            child: AppStreamBuilder<Resource<GetLoanValuesResponse>>(
                stream: model.getLoanValueResponse,
                initialData: Resource.none(),
                onData: (data) {
                  if (data.status == Status.ERROR) {
                    if (data.appError!.type == ErrorType.USER_NOT_ELIGIBLE) {
                      Navigator.pushReplacementNamed(
                          context, RoutePaths.CreditCardApplicationFailure,
                          arguments: CreditCardApplicationFailureArguments(
                              creditFailureState:
                                  CreditFailureState.InEligible));
                    } else {
                      model.showToastWithError(data.appError!);
                    }
                  }
                },
                dataBuilder: (context, loanValue) {
                  return AppStreamBuilder<Resource<ProcessLoanRequestResponse>>(
                      stream: model.setCreditLimitResponse,
                      initialData: Resource.none(),
                      onData: (data) {
                        if (data.status == Status.SUCCESS) {
                          Navigator.pushReplacementNamed(
                              context, RoutePaths.CreditCardApplySuccess,
                              arguments: CreditCardApplySuccessArguments(
                                  creditSuccessState:
                                      CreditSuccessState.Submitted));
                        } else if (data.status == Status.ERROR) {
                          if (data.appError!.type ==
                              ErrorType.EMPTY_MINIMUM_SETTLEMENT_VALUE) {
                            model.minimumSettlementKey.currentState!.isValid =
                                false;
                            model.showErrorState();
                            model.showToastWithError(data.appError!);
                          } else if (data.appError!.type ==
                              ErrorType.USER_NOT_ELIGIBLE) {
                            Navigator.pushReplacementNamed(context,
                                RoutePaths.CreditCardApplicationFailure,
                                arguments:
                                    CreditCardApplicationFailureArguments(
                                        creditFailureState:
                                            CreditFailureState.InEligible));
                          } else {
                            model.showToastWithError(data.appError!);
                          }
                        }
                      },
                      dataBuilder: (context, snapshot) {
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            FocusScope.of(context).unfocus();
                            if (details.primaryVelocity!.isNegative) {
                              model.setCreditLimit(loanValue!
                                  .data!.getLoanValuesContent!.loanValueId!);
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
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom -
                                                  50 <=
                                              0
                                          ? 0
                                          : MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom -
                                              48),
                              child: SingleChildScrollView(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).accentColor),
                                  padding: EdgeInsets.only(top: 38),
                                  child: AppStreamBuilder<SliderLimitValues>(
                                      stream: model.sliderValueStream,
                                      initialData: SliderLimitValues(
                                          maxValue: 0.0,
                                          minValue: 0.0,
                                          divisions: 0),
                                      dataBuilder:
                                          (context, sliderLimitValues) {
                                        return Column(
                                          children: [
                                            Text(
                                              S.of(context).creditLimit,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                AppStreamBuilder<double>(
                                                    stream: model.valueStream,
                                                    initialData:
                                                        sliderLimitValues!
                                                            .minValue!,
                                                    dataBuilder:
                                                        (context, value) {
                                                      return Text(
                                                        value!
                                                            .toInt()
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      );
                                                    }),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 4, top: 5),
                                                  child: Text(
                                                    "JOD",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColor
                                                            .verLightGray4),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24),
                                              child: Container(
                                                height: 48,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .backgroundColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: AppStreamBuilder<double>(
                                                    stream: model.valueStream,
                                                    initialData:
                                                        sliderLimitValues
                                                            .minValue!,
                                                    dataBuilder:
                                                        (context, val) {
                                                      return SfTheme(
                                                        data: SfThemeData(
                                                            sliderThemeData: SfSliderThemeData(
                                                                activeTrackColor:
                                                                    Colors
                                                                        .transparent,
                                                                activeTrackHeight:
                                                                    0,
                                                                thumbRadius: 20,
                                                                inactiveTrackColor:
                                                                    Colors
                                                                        .transparent,
                                                                thumbColor: Theme.of(
                                                                        context)
                                                                    .accentTextTheme
                                                                    .bodyText1!
                                                                    .color)),
                                                        child: SfSlider(
                                                          min: sliderLimitValues
                                                              .minValue!,
                                                          max: sliderLimitValues
                                                              .maxValue!,
                                                          stepSize:
                                                              sliderLimitValues
                                                                  .divisions!
                                                                  .toDouble(),
                                                          value: val!,
                                                          onChanged: (value) {
                                                            print(
                                                                "got value : $value");
                                                            model.updatevalue(
                                                                value);
                                                          },
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${sliderLimitValues.minValue!} JOD',
                                                    style: TextStyle(
                                                        color: AppColor.gray,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                  Text(
                                                    "${'${sliderLimitValues.maxValue!}'} JOD",
                                                    style: TextStyle(
                                                        color: AppColor.gray,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 24,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0),
                                              child: AppTextField(
                                                labelText: S
                                                    .of(context)
                                                    .minimumSettlement,
                                                hintText:
                                                    S.of(context).pleaseEnter,
                                                readOnly: true,
                                                key: model.minimumSettlementKey,
                                                controller: model
                                                    .minimumSettlementController,
                                                onPressed: () {
                                                  RelationshipWithCardHolderDialog.show(
                                                      context,
                                                      title: S
                                                          .of(context)
                                                          .minimumSettlement,
                                                      relationSHipWithCardHolder:
                                                          model.percentageList,
                                                      onSelected: (value) {
                                                    model
                                                        .updatedMinimumSettlementValue(
                                                            value);
                                                    Navigator.pop(context);
                                                  }, onDismissed: () {
                                                    Navigator.pop(context);
                                                  });
                                                },
                                                suffixIcon: (value, data) {
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
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 24.0),
                                              child: AppTextField(
                                                key: model.nickNameKey,
                                                labelText:
                                                    S.of(context).nickName,
                                                hintText:
                                                    S.of(context).optional,
                                                controller:
                                                    model.nickNameController,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Center(
                                                  child: Text(
                                                    S
                                                        .of(context)
                                                        .backToCardSettings,
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.brightBlue,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            AnimatedButton(
                                              buttonText:
                                                  S.of(context).swipeToProceed,
                                              borderColor: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color,
                                              textColor: Theme.of(context)
                                                  .accentTextTheme
                                                  .bodyText1!
                                                  .color,
                                            ),
                                            SizedBox(height: 28),
                                          ],
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ),
      ],
    );
  }
}
