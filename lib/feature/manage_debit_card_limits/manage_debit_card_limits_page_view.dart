import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';

class ManageDebitCardLimitsPageView
    extends BasePageViewWidget<ManageDebitCardLimitsPageViewModel> {
  ManageDebitCardLimitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<DebitCardLimitResponse>>(
          stream: model.debitCardLimitResponseStream,
          initialData: Resource.none(),
          dataBuilder: (context, debitCardLimitResponse) {
            return GestureDetector(
              onVerticalDragEnd: (details) {
                if (!details.primaryVelocity!.isNegative) {
                  Navigator.pop(context);
                }
              },
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        S.of(context).manageCardLimits,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: model.cardLimitsArguments.cardType ==
                                  CardType.DEBIT
                              ? Theme.of(context).primaryColorDark
                              : Theme.of(context).accentColor,
                          fontSize: 13,
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, bottom: 30, top: 5),
                        child: Column(
                          children: [
                            Container(
                              width: 60,
                              height: 3,
                              color: AppColor.whiteGrey,
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            debitCardLimitResponse!.status == Status.SUCCESS
                                ? Card(
                                    color: AppColor.veryLightGray,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    margin: EdgeInsets.only(bottom: 45),
                                    elevation: 20,
                                    child: AppStreamBuilder<Resource<bool>>(
                                        stream: model.updateCardLimitsStream,
                                        initialData: Resource.none(),
                                        onData: (data) {
                                          if (data.status == Status.SUCCESS) {
                                            ///TODO: updated value from response
                                            model.getDebitCardLimit();
                                          }
                                        },
                                        dataBuilder: (context, response) {
                                          return SingleChildScrollView(
                                            physics: ClampingScrollPhysics(),
                                            child: Column(
                                              children: [
                                                ManageLimitsWidget(
                                                  onToggle: (value) {
                                                    model.isAtmWithdrawal =
                                                        value;
                                                    if (!value) {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue: 0,
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    }
                                                  },
                                                  initialValue: debitCardLimitResponse
                                                              .data!
                                                              .debitCardLimitContent!
                                                              .limits![0]
                                                              .currentLimit ==
                                                          0
                                                      ? false
                                                      : true,
                                                  title: S
                                                      .of(context)
                                                      .atmWithDrawal,
                                                  amountSet:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![0]
                                                          .currentLimit!
                                                          .toString(),
                                                  maxAmount:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![0]
                                                          .maxLimit!
                                                          .toString(),
                                                  providerBase:
                                                      atmWithdrawalViewModelProvider,
                                                  onDone: (atmWithdrawalValue) {
                                                    if (num.parse(
                                                            atmWithdrawalValue) >
                                                        num.parse(
                                                            debitCardLimitResponse
                                                                .data!
                                                                .debitCardLimitContent!
                                                                .limits![0]
                                                                .maxLimit!)) {
                                                      model.showToastWithError(
                                                          AppError(
                                                              cause:
                                                                  Exception(),
                                                              error: ErrorInfo(
                                                                  message: ''),
                                                              type: ErrorType
                                                                  .LIMIT_EXCEEDED));
                                                    } else {
                                                      print(
                                                          "atm withdraw : ${atmWithdrawalValue}");
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue:
                                                              num.parse(
                                                                  atmWithdrawalValue),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    }
                                                  },
                                                ),
                                                ManageLimitsWidget(
                                                  onToggle: (value) {
                                                    model.isMerchantPayments =
                                                        value;
                                                    if (!value) {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: 0);
                                                    }
                                                  },
                                                  title: S
                                                      .of(context)
                                                      .merchantPayments,
                                                  initialValue: debitCardLimitResponse
                                                              .data!
                                                              .debitCardLimitContent!
                                                              .limits![1]
                                                              .currentLimit ==
                                                          0
                                                      ? false
                                                      : true,
                                                  amountSet:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![1]
                                                          .currentLimit!
                                                          .toString(),
                                                  maxAmount:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![2]
                                                          .maxLimit!
                                                          .toString(),
                                                  providerBase:
                                                      merchantPaymentViewModelProvider,
                                                  onDone:
                                                      (merchantPaymentValue) {
                                                    if (num.parse(
                                                            merchantPaymentValue) >
                                                        num.parse(
                                                            debitCardLimitResponse
                                                                .data!
                                                                .debitCardLimitContent!
                                                                .limits![1]
                                                                .maxLimit!)) {
                                                      model.showToastWithError(
                                                          AppError(
                                                              cause:
                                                                  Exception(),
                                                              error: ErrorInfo(
                                                                  message: ''),
                                                              type: ErrorType
                                                                  .LIMIT_EXCEEDED));
                                                    } else {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment:
                                                              num.parse(
                                                                  merchantPaymentValue));
                                                    }
                                                  },
                                                ),
                                                ManageLimitsWidget(
                                                  onToggle: (value) {
                                                    model.isOnlinePurchase =
                                                        value;
                                                    if (!value) {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: 0,
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    }
                                                  },
                                                  title: S
                                                      .of(context)
                                                      .onlinePurchase,
                                                  initialValue: debitCardLimitResponse
                                                              .data!
                                                              .debitCardLimitContent!
                                                              .limits![4]
                                                              .currentLimit ==
                                                          0
                                                      ? false
                                                      : true,
                                                  amountSet:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![4]
                                                          .currentLimit!
                                                          .toString(),
                                                  maxAmount:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![4]
                                                          .maxLimit!
                                                          .toString(),
                                                  providerBase:
                                                      onlinePurchaseViewModelProvider,
                                                  onDone:
                                                      (onlinePurchaseLimitValue) {
                                                    if (num.parse(
                                                            onlinePurchaseLimitValue) >
                                                        num.parse(
                                                            debitCardLimitResponse
                                                                .data!
                                                                .debitCardLimitContent!
                                                                .limits![4]
                                                                .maxLimit!)) {
                                                      model.showToastWithError(
                                                          AppError(
                                                              cause:
                                                                  Exception(),
                                                              error: ErrorInfo(
                                                                  message: ''),
                                                              type: ErrorType
                                                                  .LIMIT_EXCEEDED));
                                                    } else {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              onlinePurchaseLimitValue),
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    }
                                                  },
                                                ),
                                                ManageLimitsWidget(
                                                  onToggle: (value) {
                                                    if (value) {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![5]
                                                                  .currentLimit!),
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    } else {
                                                      model.updateCardLimits(
                                                          context: context,
                                                          onlinePurchase: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![4]
                                                                  .currentLimit!),
                                                          atmWithdrawalValue: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![0]
                                                                  .currentLimit!),
                                                          contactlessPayments:
                                                              0,
                                                          merchantPayment: num.parse(
                                                              debitCardLimitResponse
                                                                  .data!
                                                                  .debitCardLimitContent!
                                                                  .limits![1]
                                                                  .currentLimit!));
                                                    }
                                                  },
                                                  initialValue: false,
                                                  noToggle: !(ProviderScope
                                                              .containerOf(
                                                                  context)
                                                          .read(
                                                              appHomeViewModelProvider)
                                                          .dashboardDataContent
                                                          .debitCard!
                                                          .first
                                                          .debitDeliveredDatetime !=
                                                      null),
                                                  title: S
                                                      .of(context)
                                                      .contactLessPayments,
                                                  amountSet:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![5]
                                                          .currentLimit!
                                                          .toString(),
                                                  maxAmount:
                                                      debitCardLimitResponse
                                                          .data!
                                                          .debitCardLimitContent!
                                                          .limits![5]
                                                          .maxLimit!
                                                          .toString(),
                                                  isLast: true,
                                                  readOnly: true,
                                                  providerBase:
                                                      contactLessPaymentViewModelProvider,
                                                  onDone:
                                                      (contactLessPaymentValue) {
                                                    // model.updateCardLimits(
                                                    //     onlinePurchase: 0,
                                                    //     atmWithdrawalValue: 0,
                                                    //     contactlessPayments: num.parse(
                                                    //         contactLessPaymentValue),
                                                    //     merchantPayment: 0);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  )
                                : Container()
                          ],
                        )),
                  )
                ],
              ),
            );
          }),
    );
  }
}
