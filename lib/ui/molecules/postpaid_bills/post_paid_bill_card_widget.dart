import 'package:domain/constants/enum/postpaid_bills_pay_type_option_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_all_postpaid_bills/pay_all_postpaid_bills_page.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/firebase_log_util.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

import '../../../feature/postpaid_bills/bill_payments_transaction/bill_payments_transaction_page.dart';
import '../../../main/navigation/cutom_route.dart';

class PostPaidBillCardWidget extends StatelessWidget {
  const PostPaidBillCardWidget({Key? key}) : super(key: key);

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
          padding: EdgeInsets.only(top: 32.0.h, left: 24.0.w, right: 24.0.w, bottom: 34.0.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Text(S.of(context).myPostPaidBill,
                          style: TextStyle(
                              fontFamily: StringUtils.appFont,
                              fontSize: 12.0.t,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white))),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      AppConstantsUtils.PRE_PAID_FLOW = false;
                      AppConstantsUtils.POST_PAID_FLOW = true;
                      ProviderScope.containerOf(context)
                          .read(paymentHomeViewModelProvider)
                          .animateToNewPage();
                      Navigator.of(context).push(CustomRoute.swipeUpRoute(BillPaymentsTransactionPage()));
                    },
                    child: Text(S.of(context).viewHistory,
                        style: TextStyle(
                            fontFamily: StringUtils.appFont,
                            fontSize: 14.0.t,
                            fontWeight: FontWeight.w600,
                            color: AppColor.brightBlue)),
                  ),
                ],
              ),
              Spacer(),
              Container(
                height: 112.h,
                width: 112.w,
                child: Image.asset(AssetUtils.logoeFawateerRed),
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(S.of(context).howWouldLikeToPayPostPaidYourBills,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: StringUtils.appFont,
                      fontSize: 14.0.t,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white)),
              Spacer(),
              InkWell(
                onTap: () {
                  ///LOG EVENT TO FIREBASE
                  FireBaseLogUtil.fireBaseLog(
                      "view_my_post_paid_bills", {"view_my_post_paid_bills_clicked": true});

                  AppConstantsUtils.IS_NEW_PAYMENT = false;
                  ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateToNewPage();
                  Navigator.of(context).push(CustomRoute.swipeUpRoute(PayAllPostPaidBillsPage(
                      PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS))));
                  // Navigator.pushNamed(context, RoutePaths.PayAllPostPaidBillsPage, arguments: PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.VIEWMYBILLS));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.white_gray),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      S.of(context).manageMyBills,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              InkWell(
                onTap: () {
                  ///LOG EVENT TO FIREBASE
                  FireBaseLogUtil.fireBaseLog(
                      "pay_all_post_paid_bills", {"pay_all_post_paid_bills_clicked": true});

                  AppConstantsUtils.IS_NEW_PAYMENT = false;
                  ProviderScope.containerOf(context).read(paymentHomeViewModelProvider).animateToNewPage();
                  Navigator.of(context).push(CustomRoute.swipeUpRoute(PayAllPostPaidBillsPage(
                      PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.PAYALLBILLS))));

                  // Navigator.pushNamed(context, RoutePaths.PayAllPostPaidBillsPage, arguments: PayAllPostPaidBillsPageArguments(PostPaidBillsPayTypeOptionEnum.PAYALLBILLS));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 12.0.h),
                  decoration:
                      BoxDecoration(color: AppColor.brightBlue, borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      S.of(context).viewAndPayYourDueBills,
                      style: TextStyle(
                          fontFamily: StringUtils.appFont,
                          fontSize: 12.0.t,
                          fontWeight: FontWeight.w600,
                          color: AppColor.white),
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
