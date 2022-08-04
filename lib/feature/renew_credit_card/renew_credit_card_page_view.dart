import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/renew_credit_card/renew_credit_card_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class RenewCreditCardPageView extends BasePageViewWidget<RenewCreditCardPageViewModel> {
  RenewCreditCardPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).renewNewCreditCard.toUpperCase(),
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
            S.of(context).yourCardIssued,
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
                  if (details.primaryVelocity!.isNegative) {
                    Navigator.pushNamed(context, RoutePaths.CreditCardActivationStatus);
                  } else {}
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.1))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).creditLimit.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "JOD 1,000",
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.1))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).cardSettlementAccount.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Savings Account",
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      "5669 4900 2111",
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.1))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).minimumSettlement.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "3%",
                                      style: TextStyle(
                                        fontFamily: StringUtils.appFont,
                                        fontSize: 14,
                                        color: Theme.of(context)
                                            .textSelectionTheme
                                            .cursorColor!
                                            .withOpacity(0.4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Text(
                                S.of(context).youCanChangeCardDetailsInSettings,
                                style: TextStyle(
                                    fontFamily: StringUtils.appFont,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.gray),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: AnimatedButton(
                              buttonText: S.of(context).swipeToProceed,
                            ),
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
            ),
          ))
        ],
      ),
    );
  }
}
