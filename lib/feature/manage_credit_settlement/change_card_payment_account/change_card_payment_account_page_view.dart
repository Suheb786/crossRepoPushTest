import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/feature/manage_credit_settlement/change_card_payment_account/change_card_payment_account_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_divider.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/ui/molecules/dialog/payment/accounts_dialog/accounts_dialog.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ChangeCardPaymentAccountPageView extends BasePageViewWidget<ChangeCardPaymentAccountPageViewModel> {
  ChangeCardPaymentAccountPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).changeLinkedAccount.toUpperCase(),
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).selectAccountToPayCreditCard,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 32,
          ),
          Expanded(
              child: Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (StringUtils.isDirectionRTL(context)) {
                    if (!details.primaryVelocity!.isNegative) {
                      Navigator.pushReplacementNamed(context, RoutePaths.CreditCardApplySuccess,
                          arguments: CreditCardApplySuccessArguments(
                              creditSuccessState: CreditSuccessState.Settlement_Account_Changed));
                    }
                  } else {
                    if (details.primaryVelocity!.isNegative) {
                      Navigator.pushReplacementNamed(context, RoutePaths.CreditCardApplySuccess,
                          arguments: CreditCardApplySuccessArguments(
                              creditSuccessState: CreditSuccessState.Settlement_Account_Changed));
                    } else {}
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          child: Text(
                            S.of(context).currentSettlementAccount,
                            style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: AppDivider(
                            color: AppColor.lightGrayishBlue,
                            indent: 12,
                            endIndent: 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor, shape: BoxShape.circle),
                                child: AppSvg.asset(
                                  AssetUtils.dollarSvg,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Savings Account',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    '5669 4900 2111',
                                    style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.gray),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: AppDivider(
                            color: AppColor.lightGrayishBlue,
                            indent: 12,
                            endIndent: 8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: AppTextField(
                            labelText: S.of(context).newSettlementAccount.toUpperCase(),
                            hintText: S.of(context).pleaseSelect,
                            readOnly: true,
                            controller: model.settlementAccountController,
                            key: model.settlementAccountKey,
                            onPressed: () {
                              AccountsDialog.show(context, label: S.of(context).newSettlementAccount,
                                  onDismissed: () {
                                Navigator.pop(context);
                              }, onSelected: (value) {
                                Navigator.pop(context);
                                model.settlementAccountController.text = value;
                                model.validate();
                              });
                            },
                            suffixIcon: (value, data) {
                              return Container(
                                  height: 16,
                                  width: 16,
                                  padding: EdgeInsetsDirectional.only(end: 8),
                                  child: AppSvg.asset(AssetUtils.downArrow, color: AppColor.dark_gray_1));
                            },
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: AppStreamBuilder<bool>(
                              stream: model.showButtonStream,
                              initialData: false,
                              dataBuilder: (context, isValid) {
                                return Visibility(
                                  visible: isValid!,
                                  child: AnimatedButton(
                                    buttonText: S.of(context).swipeToProceed,
                                  ),
                                );
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              S.of(context).backToCardSettings,
                              style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: AppColor.brightBlue,
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
