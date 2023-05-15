import 'package:domain/constants/error_types.dart';
import 'package:domain/error/app_error.dart';
import 'package:domain/model/base/error_info.dart';
import 'package:domain/model/credit_card/get_credit_card_limit_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_credit_card_limits/manage_credit_card_limits_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ManageCreditCardLimitsPageView extends BasePageViewWidget<ManageCreditCardLimitsPageViewModel> {
  ManageCreditCardLimitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: AppStreamBuilder<Resource<GetCreditCardLimitResponse>>(
          stream: model.getCreditCardLimitResponseStream,
          initialData: Resource.none(),
          onData: (creditCardLimitResponse) {
            if (creditCardLimitResponse.status == Status.SUCCESS) {
              model.atmWithdrawalValue = model.atmWithdrawalInitialValue =
                  num.parse(creditCardLimitResponse.data!.cardLimit!.atmCurrentLimit ?? '0');
              model.merchantPaymentValue = model.merchantPaymentInitialValue =
                  num.parse(creditCardLimitResponse.data!.cardLimit!.merchantCurrentLimit ?? '0');
              model.onlinePurchaseValue = model.onlinePurchaseInitialValue =
                  num.parse(creditCardLimitResponse.data!.cardLimit!.onlinePurchaseCurrentLimit ?? '0');
              // model.contactlessPaymentsValue =
              //     model.contactlessPaymentsInitialValue = num.parse(
              //     creditCardLimitResponse.data!.cardLimit!.currentLimit ??
              //         '0');
              model.isAtmWithdrawal =
                  model.isAtmWithdrawalInitialValue = creditCardLimitResponse.data!.cardLimit!.isATM ?? false;
              model.isMerchantPayments = model.isMerchantPaymentsInitialValue =
                  creditCardLimitResponse.data!.cardLimit!.isMerchant ?? false;
              model.isOnlinePurchase = model.isOnlinePurchaseInitialValue =
                  creditCardLimitResponse.data!.cardLimit!.isOnlinePurchase ?? false;
              model.isContactLessPayments = model.isContactLessPaymentsInitialValue =
                  creditCardLimitResponse.data!.cardLimit!.isContactLess ?? false;
              model.updateShowSaveButtonValue(false);
            }
          },
          dataBuilder: (context, creditCardLimitResponse) {
            return GestureDetector(
              onVerticalDragEnd: (details) {
                int sensitivity = 8;
                if (details.primaryVelocity! > sensitivity) {
                  Navigator.pop(context);
                } else if (details.primaryVelocity! < -sensitivity) {}
              },
              child: Container(
                color: Theme.of(context).primaryColor,
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
                            fontFamily: StringUtils.appFont,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25), topRight: Radius.circular(25))),
                              padding:
                                  const EdgeInsetsDirectional.only(start: 30, end: 30, bottom: 30, top: 5),
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
                                  creditCardLimitResponse!.status == Status.SUCCESS
                                      ? Expanded(
                                          child: SingleChildScrollView(
                                            physics: ClampingScrollPhysics(),
                                            child: Card(
                                              color: AppColor.veryLightGray,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                              ),
                                              margin: EdgeInsets.only(bottom: 45),
                                              elevation: 20,
                                              child: AppStreamBuilder<Resource<bool>>(
                                                  stream: model.updateCreditCardLimitsStream,
                                                  initialData: Resource.none(),
                                                  onData: (data) {
                                                    if (data.status == Status.SUCCESS) {
                                                      model.getCreditCardLimit();
                                                    }
                                                  },
                                                  dataBuilder: (context, response) {
                                                    return Column(
                                                      children: [
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isAtmWithdrawal = value;
                                                            model.showSaveButton();
                                                            // if (!value) {
                                                            //   model
                                                            //       .updateCreditCardLimits(
                                                            //       onlinePurchase: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       atmWithdrawalValue:
                                                            //       0,
                                                            //       contactlessPayments:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       merchantPayment: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'));
                                                            // }
                                                          },
                                                          initialValue: creditCardLimitResponse
                                                                  .data!.cardLimit!.isATM ??
                                                              false,
                                                          title: S.of(context).atmWithDrawal,
                                                          amountSet: creditCardLimitResponse
                                                                      .data!.cardLimit!.atmCurrentLimit ==
                                                                  '.001'
                                                              ? '0'
                                                              : creditCardLimitResponse
                                                                      .data!.cardLimit!.atmCurrentLimit ??
                                                                  '0',
                                                          maxAmount: creditCardLimitResponse
                                                                  .data!.cardLimit!.atmMaxLimit ??
                                                              '0',
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
                                                            model.showSaveButton();
                                                            // if (!value) {
                                                            //   model
                                                            //       .updateCreditCardLimits(
                                                            //       onlinePurchase: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       atmWithdrawalValue:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       contactlessPayments:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       merchantPayment:
                                                            //       0);
                                                            // }
                                                          },
                                                          title: S.of(context).merchantPayments,
                                                          initialValue: creditCardLimitResponse
                                                                  .data!.cardLimit!.isMerchant ??
                                                              false,
                                                          amountSet: creditCardLimitResponse.data!.cardLimit!
                                                                      .merchantCurrentLimit ==
                                                                  '.001'
                                                              ? '0'
                                                              : creditCardLimitResponse.data!.cardLimit!
                                                                      .merchantCurrentLimit ??
                                                                  '0',
                                                          maxAmount: creditCardLimitResponse
                                                                  .data!.cardLimit!.merchantMaxLimit ??
                                                              '0',
                                                          providerBase: merchantPaymentViewModelProvider,
                                                          onChange: (merchantPaymentValue) {
                                                            model.merchantPaymentValue =
                                                                num.tryParse(merchantPaymentValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          onDone: (merchantPaymentValue) {},
                                                        ),
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isOnlinePurchase = value;
                                                            model.showSaveButton();
                                                            // if (!value) {
                                                            //   model
                                                            //       .updateCreditCardLimits(
                                                            //       onlinePurchase: 0,
                                                            //       atmWithdrawalValue:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       contactlessPayments:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       merchantPayment: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'));
                                                            // }
                                                          },
                                                          noToggle: true,
                                                          title: S.of(context).onlinePurchase,
                                                          initialValue: false,
                                                          // initialValue: creditCardLimitResponse
                                                          //         .data!.cardLimit!.isOnlinePurchase ??
                                                          //     false,
                                                          amountSet: creditCardLimitResponse.data!.cardLimit!
                                                                  .onlinePurchaseCurrentLimit ??
                                                              '0',
                                                          maxAmount: creditCardLimitResponse
                                                                  .data!.cardLimit!.onlinePurchaseMaxLimit ??
                                                              '0',
                                                          providerBase: onlinePurchaseViewModelProvider,
                                                          onChange: (onlinePurchaseLimitValue) {
                                                            model.onlinePurchaseValue =
                                                                num.tryParse(onlinePurchaseLimitValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          readOnly: true,
                                                          onDone: (onlinePurchaseLimitValue) {},
                                                        ),
                                                        ManageLimitsWidget(
                                                          onToggle: (value) {
                                                            model.isContactLessPayments = value;
                                                            model.showSaveButton();
                                                            // if (value) {
                                                            //   model
                                                            //       .updateCreditCardLimits(
                                                            //       onlinePurchase: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       atmWithdrawalValue:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       contactlessPayments:
                                                            //       150,
                                                            //       merchantPayment: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'));
                                                            // } else {
                                                            //   model
                                                            //       .updateCreditCardLimits(
                                                            //       onlinePurchase: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       atmWithdrawalValue:
                                                            //       num.parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'),
                                                            //       contactlessPayments:
                                                            //       0,
                                                            //       merchantPayment: num
                                                            //           .parse(
                                                            //           creditCardLimitResponse
                                                            //               .data!
                                                            //               .cardLimit!
                                                            //               .currentLimit ??
                                                            //               '0'));
                                                            // }
                                                          },
                                                          initialValue: /*(model.cardLimitsArguments
                                                                      .creditDeliveredDatetime
                                                                      .toString()
                                                                      .isNotEmpty &&
                                                                  (creditCardLimitResponse.data!.cardLimit!
                                                                              .isContactLess !=
                                                                          null &&
                                                                      creditCardLimitResponse
                                                                          .data!.cardLimit!.isContactLess!))
                                                              ? true
                                                              :*/
                                                              false,
                                                          noToggle:
                                                              true /*!(model
                                                              .cardLimitsArguments.creditDeliveredDatetime
                                                              .toString()
                                                              .isNotEmpty)*/
                                                          ,
                                                          title: S.of(context).contactLessPayments,

                                                          ///TODO:check with backend
                                                          amountSet: creditCardLimitResponse
                                                                      .data!.cardLimit!.isContactLess ??
                                                                  false
                                                              ? "150"
                                                              : "0",
                                                          maxAmount: creditCardLimitResponse
                                                                      .data!.cardLimit!.isContactLess ??
                                                                  false
                                                              ? "150"
                                                              : "0",
                                                          isLast: true,
                                                          readOnly: true,
                                                          providerBase: contactLessPaymentViewModelProvider,
                                                          onChange: (contactLessPaymentValue) {
                                                            model.contactlessPaymentsValue =
                                                                num.tryParse(contactLessPaymentValue) ?? 0;
                                                            model.showSaveButton();
                                                          },
                                                          onDone: (contactLessPaymentValue) {},
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                              )),
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
                                            num.parse(creditCardLimitResponse.data!.cardLimit!.atmMaxLimit ??
                                                '0')) {
                                          model.showToastWithError(AppError(
                                              cause: Exception(),
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.ATM_WITHDRAWAL_VALUE_EXCEEDED));
                                        } else if (model.merchantPaymentValue >
                                            num.parse(
                                                creditCardLimitResponse.data!.cardLimit!.merchantMaxLimit ??
                                                    '0')) {
                                          model.showToastWithError(AppError(
                                              cause: Exception(),
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.MERCHANT_PAYMENT_EXCEEDED));
                                        } else if (model.onlinePurchaseValue >
                                            num.parse(creditCardLimitResponse
                                                    .data!.cardLimit!.onlinePurchaseMaxLimit ??
                                                '0')) {
                                          model.showToastWithError(AppError(
                                              cause: Exception(),
                                              error: ErrorInfo(message: ''),
                                              type: ErrorType.ONLINE_PURCHASE_VALUE_EXCEEDED));
                                        } else {
                                          model.updateCreditCardLimits(
                                              atmWithdrawalValue: model.atmWithdrawalValue,
                                              merchantPayment: model.merchantPaymentValue,
                                              onlinePurchase: model.onlinePurchaseValue,
                                              contactlessPayments: model.contactlessPaymentsValue);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                                        padding: EdgeInsets.all(18),
                                        height: 56,
                                        width: double.maxFinite,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Theme.of(context).textTheme.bodyLarge?.color,
                                        ),
                                        child: Center(
                                          child: Text(S.of(context).saveChanges,
                                              style: TextStyle(
                                                  fontFamily: StringUtils.appFont,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1,
                                                  color: Theme.of(context).colorScheme.secondary)),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
