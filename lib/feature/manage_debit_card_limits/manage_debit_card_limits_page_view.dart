import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/debit_card/debit_card_limit_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../di/payment/payment_modules.dart';
import '../../ui/molecules/app_svg.dart';
import '../../utils/asset_utils.dart';

class ManageDebitCardLimitsPageView extends BasePageViewWidget<ManageDebitCardLimitsPageViewModel> {
  ManageDebitCardLimitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<DebitCardLimitResponse>>(
          stream: model.debitCardLimitResponseStream,
          initialData: Resource.none(),
          onData: (debitCardLimitResponse) {
            if (debitCardLimitResponse.status == Status.SUCCESS) {
              model.atmWithdrawalValue = model.atmWithdrawalInitialValue =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![0].currentLimit!);
              model.merchantPaymentValue = model.merchantPaymentInitialValue =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![1].currentLimit!);
              model.onlinePurchaseValue = model.onlinePurchaseInitialValue =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![4].currentLimit!);
              model.contactlessPaymentsValue = model.contactlessPaymentsInitialValue =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![6].currentLimit!);
              model.isAtmWithdrawal =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![0].currentLimit!) > 0
                      ? true
                      : false;
              model.isMerchantPayments =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![1].currentLimit!) > 0
                      ? true
                      : false;
              model.isOnlinePurchase = model.isOnlinePurchaseInitialValue =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![4].currentLimit!) > 0
                      ? true
                      : false;
              model.isContactLessPayments =
                  num.parse(debitCardLimitResponse.data!.debitCardLimitContent!.limits![6].currentLimit!) > 0
                      ? true
                      : false;
              model.updateShowSaveButtonValue(false);
            }
          },
          dataBuilder: (context, debitCardLimitResponse) {
            return Padding(
              padding: EdgeInsetsDirectional.only(top: 52.0.h),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.0.h),
                    child: Text(
                      S.of(context).manageCardLimits,
                      style: TextStyle(
                        fontFamily: StringUtils.appFont,
                        fontWeight: FontWeight.bold,
                        color: model.cardLimitsArguments.cardType == CardType.DEBIT
                            ? Theme.of(context).primaryColorDark
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: 13.t,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(top: 24.0.h),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                              padding: EdgeInsetsDirectional.only(top: 42.0.h, bottom: 30.h) +
                                  EdgeInsetsDirectional.symmetric(horizontal: 30.0.h),
                              child: Column(
                                children: [
                                  debitCardLimitResponse!.status == Status.SUCCESS
                                      ? Flexible(
                                          child: Card(
                                            color: AppColor.veryLightGray,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            margin: EdgeInsets.only(bottom: 45.h),
                                            elevation: 20,
                                            child: AppStreamBuilder<Resource<bool>>(
                                                stream: model.updateCardLimitsStream,
                                                initialData: Resource.none(),
                                                onData: (data) {
                                                  if (data.status == Status.SUCCESS) {
                                                    model.getDebitCardLimit();
                                                  }
                                                },
                                                dataBuilder: (context, response) {
                                                  return SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isAtmWithdrawal = value;
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
                                                                          .limits![6]
                                                                          .currentLimit!),
                                                                  merchantPayment: num.parse(
                                                                      debitCardLimitResponse
                                                                          .data!
                                                                          .debitCardLimitContent!
                                                                          .limits![1]
                                                                          .currentLimit!));
                                                            }
                                                          },
                                                          initialValue: num.parse(debitCardLimitResponse
                                                                      .data!
                                                                      .debitCardLimitContent!
                                                                      .limits![0]
                                                                      .currentLimit!) ==
                                                                  0
                                                              ? false
                                                              : true,
                                                          title: S.of(context).atmWithDrawal,
                                                          amountSet: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![0].currentLimit!
                                                              .toString(),
                                                          maxAmount: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![0].maxLimit!
                                                              .toString(),
                                                          providerBase: atmWithdrawalViewModelProvider,
                                                          onChange: (atmWithdrawalValue) {
                                                            model.atmWithdrawalValue =
                                                                num.tryParse(atmWithdrawalValue) ?? 0;

                                                            model.showSaveButton();
                                                          },
                                                          onDone: (String value) {},
                                                        ),
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isMerchantPayments = value;
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
                                                                          .limits![6]
                                                                          .currentLimit!),
                                                                  merchantPayment: 0);
                                                            }
                                                          },
                                                          title: S.of(context).merchantPayments,
                                                          initialValue: num.parse(debitCardLimitResponse
                                                                      .data!
                                                                      .debitCardLimitContent!
                                                                      .limits![1]
                                                                      .currentLimit!) ==
                                                                  0
                                                              ? false
                                                              : true,
                                                          amountSet: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![1].currentLimit!
                                                              .toString(),
                                                          maxAmount: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![2].maxLimit!
                                                              .toString(),
                                                          providerBase: merchantPaymentViewModelProvider,
                                                          onChange: (merchantPaymentValue) {
                                                            model.merchantPaymentValue =
                                                                num.tryParse(merchantPaymentValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          onDone: (merchantPaymentValue) {
                                                            // if (num.parse(
                                                            //         merchantPaymentValue) >
                                                            //     num.parse(
                                                            //         debitCardLimitResponse
                                                            //             .data!
                                                            //             .debitCardLimitContent!
                                                            //             .limits![1]
                                                            //             .maxLimit!)) {
                                                            //   model.showToastWithError(
                                                            //       AppError(
                                                            //           cause:
                                                            //               Exception(),
                                                            //           error: ErrorInfo(
                                                            //               message: ''),
                                                            //           type: ErrorType
                                                            //               .LIMIT_EXCEEDED));
                                                            // } else {
                                                            //   model.updateCardLimits(
                                                            //       context: context,
                                                            //       onlinePurchase: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![4]
                                                            //               .currentLimit!),
                                                            //       atmWithdrawalValue: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![0]
                                                            //               .currentLimit!),
                                                            //       contactlessPayments: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![5]
                                                            //               .currentLimit!),
                                                            //       merchantPayment:
                                                            //           num.parse(
                                                            //               merchantPaymentValue));
                                                            // }
                                                          },
                                                        ),
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isOnlinePurchase = value;
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
                                                                          .limits![6]
                                                                          .currentLimit!),
                                                                  merchantPayment: num.parse(
                                                                      debitCardLimitResponse
                                                                          .data!
                                                                          .debitCardLimitContent!
                                                                          .limits![1]
                                                                          .currentLimit!));
                                                            }
                                                          },
                                                          title: S.of(context).onlinePurchase,
                                                          initialValue: num.parse(debitCardLimitResponse
                                                                      .data!
                                                                      .debitCardLimitContent!
                                                                      .limits![4]
                                                                      .currentLimit!) ==
                                                                  0
                                                              ? false
                                                              : true,
                                                          amountSet: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![4].currentLimit!
                                                              .toString(),
                                                          maxAmount: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![4].maxLimit!
                                                              .toString(),
                                                          providerBase: onlinePurchaseViewModelProvider,
                                                          onChange: (onlinePurchaseLimitValue) {
                                                            model.onlinePurchaseValue =
                                                                num.tryParse(onlinePurchaseLimitValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          onDone: (onlinePurchaseLimitValue) {
                                                            // if (num.parse(
                                                            //         onlinePurchaseLimitValue) >
                                                            //     num.parse(
                                                            //         debitCardLimitResponse
                                                            //             .data!
                                                            //             .debitCardLimitContent!
                                                            //             .limits![4]
                                                            //             .maxLimit!)) {
                                                            //   model.showToastWithError(
                                                            //       AppError(
                                                            //           cause:
                                                            //               Exception(),
                                                            //           error: ErrorInfo(
                                                            //               message: ''),
                                                            //           type: ErrorType
                                                            //               .LIMIT_EXCEEDED));
                                                            // } else {
                                                            //   model.updateCardLimits(
                                                            //       context: context,
                                                            //       onlinePurchase: num.parse(
                                                            //           onlinePurchaseLimitValue),
                                                            //       atmWithdrawalValue: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![0]
                                                            //               .currentLimit!),
                                                            //       contactlessPayments: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![5]
                                                            //               .currentLimit!),
                                                            //       merchantPayment: num.parse(
                                                            //           debitCardLimitResponse
                                                            //               .data!
                                                            //               .debitCardLimitContent!
                                                            //               .limits![1]
                                                            //               .currentLimit!));
                                                            // }
                                                          },
                                                        ),
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isContactLessPayments = value;
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

                                                                  ///TODO:check with backend
                                                                  contactlessPayments: 300,
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
                                                                  contactlessPayments: 0,
                                                                  merchantPayment: num.parse(
                                                                      debitCardLimitResponse
                                                                          .data!
                                                                          .debitCardLimitContent!
                                                                          .limits![1]
                                                                          .currentLimit!));
                                                            }
                                                          },
                                                          isContactless: true,
                                                          initialValue:
                                                              // debitCardLimitResponse
                                                              //                 .data!
                                                              //                 .debitCardLimitContent!
                                                              //                 .limits![5]
                                                              //                 .currentLimit ==
                                                              //             150 &&
                                                              ((model.cardLimitsArguments
                                                                          .debitDeliveredDatetime
                                                                          .toString()
                                                                          .isNotEmpty) &&
                                                                      num.parse(debitCardLimitResponse
                                                                              .data!
                                                                              .debitCardLimitContent!
                                                                              .limits![6]
                                                                              .currentLimit!) !=
                                                                          0)
                                                                  ? true
                                                                  : false,
                                                          noToggle: !(model
                                                              .cardLimitsArguments.debitDeliveredDatetime
                                                              .toString()
                                                              .isNotEmpty),
                                                          title: S.of(context).contactLessPayments,
                                                          amountSet: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![6].currentLimit!
                                                              .toString(),
                                                          maxAmount: debitCardLimitResponse.data!
                                                              .debitCardLimitContent!.limits![6].maxLimit!
                                                              .toString(),
                                                          isLast: true,
                                                          readOnly: false,
                                                          providerBase: contactLessPaymentViewModelProvider,
                                                          onChange: (contactLessPaymentValue) {
                                                            model.contactlessPaymentsValue =
                                                                num.tryParse(contactLessPaymentValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          onDone: (contactLessPaymentValue) {
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
                                          ),
                                        )
                                      : Container()
                                ],
                              )),
                        ),
                        AppStreamBuilder<bool>(
                            stream: model.showSaveButtonStream,
                            initialData: false,
                            dataBuilder: (context, isVisible) {
                              return Visibility(
                                visible: isVisible!,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: InkWell(
                                    onTap: () {
                                      if (model.atmWithdrawalValue >
                                          num.parse(debitCardLimitResponse
                                              .data!.debitCardLimitContent!.limits![0].maxLimit!)) {
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.ATM_WITHDRAWAL_VALUE_EXCEEDED));
                                      } else if (model.merchantPaymentValue >
                                          num.parse(debitCardLimitResponse
                                              .data!.debitCardLimitContent!.limits![1].maxLimit!)) {
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.MERCHANT_PAYMENT_EXCEEDED));
                                      } else if (model.onlinePurchaseValue >
                                          num.parse(debitCardLimitResponse
                                              .data!.debitCardLimitContent!.limits![4].maxLimit!)) {
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.ONLINE_PURCHASE_VALUE_EXCEEDED));
                                      } else if (model.contactlessPaymentsValue >
                                          num.parse(debitCardLimitResponse
                                              .data!.debitCardLimitContent!.limits![5].maxLimit!)) {
                                        model.showToastWithError(AppError(
                                            cause: Exception(),
                                            error: ErrorInfo(message: ''),
                                            type: ErrorType.CONTACTLESS_MAX_LIMIT));
                                      } else {
                                        model.updateCardLimits(
                                            atmWithdrawalValue: model.atmWithdrawalValue,
                                            merchantPayment: model.merchantPaymentValue,
                                            onlinePurchase: model.onlinePurchaseValue,
                                            context: context,
                                            contactlessPayments: model.contactlessPaymentsValue);
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                                      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                                      height: 56.h,
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                                      ),
                                      child: Center(
                                        child: Text(S.of(context).saveChanges,
                                            style: TextStyle(
                                                fontFamily: StringUtils.appFont,
                                                fontSize: 14.t,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 1,
                                                color: Theme.of(context).colorScheme.secondary)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                        Positioned(
                          top: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48.h,
                              width: 48.h,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).colorScheme.inverseSurface, width: 1),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                        spreadRadius: 0.1,
                                        offset: Offset(0, 4))
                                  ]),
                              child: AppSvg.asset(AssetUtils.down, color: AppColor.light_acccent_blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
