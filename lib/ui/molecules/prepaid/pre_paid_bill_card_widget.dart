import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/payment/payment_home/payment_home_view_model.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/main/navigation/route_paths.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_page.dart';
import '../../../main/navigation/cutom_route.dart';

class PrePaidBillCardWidget extends StatelessWidget {
  const PrePaidBillCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 2,
      color: Theme.of(context).primaryColor,
      margin: EdgeInsets.zero,
      shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
      child: Container(
        color: Theme.of(context).primaryColorDark,
        child: Padding(
          padding: EdgeInsets.only(top: 32.0.h, left: 24.0.w, right: 24.0.w, bottom: 38.0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Text(S.of(context).myPrePaidBills, style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: AppColor.white))),
                  InkWell(
                    onTap: () {
                      AppConstantsUtils.PRE_PAID_FLOW = true;
                      AppConstantsUtils.POST_PAID_FLOW = false;
                      // Navigator.pushNamed(context, RoutePaths.BillPaymentsTransactionPage);
                      ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateToNewPage();
                      Navigator.of(context).push(CustomRoute.swipeUpRoute(BillPaymentsTransactionPage()));
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.h,
                      alignment: Alignment.center,
                      child: AppSvg.asset(AssetUtils.clock, width: 24.h, height: 24.h, color: AppColor.light_acccent_blue),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.black,
                        border: Border.all(color: AppColor.borderColorNew, width: 1),
                        boxShadow: const [
                          BoxShadow(color: AppColor.borderColorNew, blurRadius: 14, spreadRadius: 0.6),
                        ],
                      ),
                    ),
                  ),
                  /*GestureDetector(
                    onTap: () {
                      AppConstantsUtils.PRE_PAID_FLOW = true;
                      AppConstantsUtils.POST_PAID_FLOW = false;
                      // Navigator.pushNamed(context, RoutePaths.BillPaymentsTransactionPage);
                      ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateToNewPage();
                      Navigator.of(context).push(slideBottomToTop(nextPage: BillPaymentsTransactionPage()));
                    },
                    child: Text(S.of(context).viewHistory, style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.0.t, fontWeight: FontWeight.w600, color: AppColor.brightBlue)),
                  ),*/
                ],
              ),
              SizedBox(
                height: 66.h,
              ),
              Container(
                height: 112.h,
                width: 112.w,
                child: Image.asset(AssetUtils.logoeFawateerYellow),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(S.of(context).howWouldLikeToPayPrePaidYourBills, textAlign: TextAlign.center, style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 14.0.t, fontWeight: FontWeight.w600, color: AppColor.white)),
              SizedBox(
                height: 40.h,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  ///LOG EVENT TO FIREBASE
                  FireBaseLogUtil.fireBaseLog("pay_my_pre_paid_bills", {"pay_my_pre_paid_bills_clicked": true});
                  AppConstantsUtils.IS_NEW_PAYMENT = false;
                  Navigator.pushNamed(context, RoutePaths.PayMyPrePaidBillsPage);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(border: Border.all(width: 1, color: AppColor.white_gray), borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      S.of(context).manageAndPayMyBills,
                      style: TextStyle(fontFamily: StringUtils.appFont, fontSize: 12.0.t, fontWeight: FontWeight.w600, color: AppColor.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
