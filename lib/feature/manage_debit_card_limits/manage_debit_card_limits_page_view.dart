import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/manage_card_limits/manage_card_limits_modules.dart';
import 'package:neo_bank/feature/manage_debit_card_limits/manage_Debit_cards_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/debit_card_settings/manage_limits/manage_limits_widget.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ManageDebitCardLimitsPageView
    extends BasePageViewWidget<ManageDebitCardLimitsPageViewModel> {
  ManageDebitCardLimitsPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {
          Navigator.pop(context);
        }
      },
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                S.of(context).manageCardLimits,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.black,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 50,
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
                      height: 40,
                    ),
                    Card(
                      color: AppColor.veryLightGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      margin: EdgeInsets.only(top: 25, bottom: 45),
                      elevation: 20,
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            ManageLimitsWidget(
                              onToggle: (value) {},
                              title: S.of(context).atmWithDrawal,
                              amountSet: '500',
                              maxAmount: '5000',
                              providerBase: atmWithdrawalViewModelProvider,
                            ),
                            ManageLimitsWidget(
                              onToggle: (value) {},
                              title: S.of(context).merchantPayments,
                              amountSet: '2000',
                              maxAmount: '5000',
                              providerBase: merchantPaymentViewModelProvider,
                            ),
                            ManageLimitsWidget(
                              onToggle: (value) {},
                              title: S.of(context).onlinePurchase,
                              amountSet: '1000',
                              maxAmount: '5000',
                              providerBase: onlinePurchaseViewModelProvider,
                            ),
                            ManageLimitsWidget(
                              onToggle: (value) {},
                              title: S.of(context).contactLessPayments,
                              amountSet: '240',
                              maxAmount: '5000',
                              providerBase: contactLessPaymentViewModelProvider,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
