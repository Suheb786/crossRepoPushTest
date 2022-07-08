import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/evouchers/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/ui/molecules/account_ready/account_details.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/button/animated_button.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PurchaseVoucherSuccessPageView extends BasePageViewWidget<PurchaseVoucherSuccessPageViewModel> {
  PurchaseVoucherSuccessPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, PurchaseVoucherSuccessPageViewModel model) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity!.isNegative) {}
      },
      child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 72),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              AssetUtils.line,
                              color: AppColor.softRed,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 111.37,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).canvasColor,
                                ),
                                child: Center(
                                    child: AppSvg.asset(AssetUtils.right,
                                        color: Theme.of(context).primaryColorDark)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '4.99',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 32,
                                color: Theme.of(context).accentColor),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(bottom: 4),
                            child: Text(
                              'USD',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 14, color: AppColor.very_light_red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        '(3.540 JOD)',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 14, color: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        S.of(context).purchasedFor,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 24, color: Theme.of(context).accentColor),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16), color: Theme.of(context).accentColor),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                height: 72,
                                width: 72,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'PlayStation Voucher Lorem Ipsum',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Theme.of(context).indicatorColor),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              'PlayStation',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Theme.of(context).indicatorColor),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            AccountDetails(
                              title: 'Ref No.',
                              value: '984893922',
                              showIcon: false,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    S.of(context).date,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text.rich(
                                    TextSpan(children: [
                                      TextSpan(
                                        text: "16 Dec 2021 - ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "3:30PM",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.dark_gray_1),
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      buttonText: S.of(context).swipeToProceed,
                      textColor: Theme.of(context).accentColor,
                      borderColor: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 32,
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).toViewVoucher,
                          style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
