import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/payment/request_money/request_money_view_model.dart';
import 'package:neo_bank/feature/payment/request_payment_from_new_recipient/request_payment_from_new_recipient_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/app_keyboard_hide.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class RequestMoneyPageView extends BasePageViewWidget<RequestMoneyViewModel> {
  RequestMoneyPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return AppKeyBoardHide(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity!.isNegative) {
          } else {
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Container(
                      height: 50,
                      width: 281,
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -1,
                    child: Column(
                      children: [
                        AppSvg.asset(AssetUtils.downArrow),
                        Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            S.of(context).backToPayments,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColor.dark_gray_2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text(
                S.of(context).requestMoney,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 47, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 40),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 15, left: 4),
                          child: Text(
                            "JOD",
                            style: TextStyle(
                                color: AppColor.verLightGray4,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppSvg.asset(AssetUtils.backspaceBlue),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 49),
              child: Text(
                S.of(context).accountBalance,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                    color: AppColor.dark_gray_1),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "12,451.92",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.0, top: 2),
                    child: Text(
                      "JOD",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: AppColor.dark_gray_1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 44.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 78),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "1",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "2",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "3",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48, left: 78, right: 78),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "4",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "5",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "6",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 48, left: 78, right: 78),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "7",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "8",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "9",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 31, left: 78, right: 51, bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ".",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            Text(
                              "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 28),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RequestPaymentFromNewRecipientPage()));
                                },
                                child: AppSvg.asset(AssetUtils.next))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
