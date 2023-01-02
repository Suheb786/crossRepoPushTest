import 'package:domain/model/bill_payments/pay_post_paid_bill/biller_list.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PostPaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PostPaidBillsSuccessPageArguments arguments;

  PostPaidBillsSuccessPageViewModel(this.arguments);

  double addAllBillAmt() {
    double totalBillAmt = 0.0;
    if (arguments.billerList == null || arguments.billerList!.isEmpty) return totalBillAmt;

    arguments.billerList!.forEach((element) {
      if (element.isPaid ?? false == true) {
        totalBillAmt = double.parse(element.totalAmount ?? "0.0") + totalBillAmt;
      }
    });
    return totalBillAmt;
  }

  String getBillerName(BuildContext context, BillerList item) {
    return StringUtils.isDirectionRTL(context) ? item.billerNameAR ?? "" : item.billerName ?? "";
  }
}
