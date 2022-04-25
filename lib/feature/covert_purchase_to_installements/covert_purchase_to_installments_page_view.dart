import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/covert_purchase_to_installements/covert_purchase_to_installments_page_view_model.dart';
import 'package:neo_bank/feature/credit_card_apply_success/credit_card_apply_success_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/utils/color_utils.dart';

class ConvertPurchaseToInstallmentsPageView
    extends BasePageViewWidget<ConvertPurchaseToInstallmentsPageViewModel> {
  ConvertPurchaseToInstallmentsPageView(ProviderBase model) : super(model);

  @override
  Widget build(
      BuildContext context, ConvertPurchaseToInstallmentsPageViewModel model) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            S.of(context).convertPurchaseToInstallments.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Theme.of(context).accentColor),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            S.of(context).selectPreferredInstallmentDuration,
            textAlign: TextAlign.center,
            style: TextStyle(
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
              padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity!.isNegative) {
                    Navigator.pushNamed(
                        context, RoutePaths.CreditCardApplySuccess,
                        arguments: CreditCardApplySuccessArguments(
                            creditSuccessState: CreditSuccessState
                                .Convert_Purchase_To_Installments));
                  } else {}
                },
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "Host International Inc Dubai \nAED 2,771.74",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Theme.of(context)
                                    .textSelectionTheme
                                    .cursorColor),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "- 534.900",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textSelectionTheme
                                      .cursorColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "JOD",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .hintStyle!
                                        .color,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          S.of(context).installmentOption,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Theme.of(context)
                                  .textSelectionTheme
                                  .cursorColor),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color!,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "3-month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Monthly amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "44.57 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fees (%)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "0.7%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total payable",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                      Text(
                                        "592.39 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color!,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "6-month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Monthly amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "29.71 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fees (%)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "0.6%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total payable",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                      Text(
                                        "610.90 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .accentTextTheme
                                        .bodyText1!
                                        .color!,
                                  )),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "9-month",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Monthly amount",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "44.57 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fees (%)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                      Text(
                                        "0.7%",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: AppColor.gray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Total payable",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                      Text(
                                        "592.39 JOD",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color: Theme.of(context)
                                                .textSelectionTheme
                                                .cursorColor),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
    ;
  }
}
