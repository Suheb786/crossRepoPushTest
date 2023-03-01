import 'package:domain/model/bill_payments/pay_post_paid_bill/biller_success.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/utils/string_utils.dart';

class PostPaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PostPaidBillsSuccessPageArguments arguments;

  PostPaidBillsSuccessPageViewModel(this.arguments);

  double addAllBillAmt() {
    /*double totalBillAmt = 0.0;
    if (arguments.billerSuccessDetailsList == null || arguments.billerSuccessDetailsList!.isEmpty) return totalBillAmt;

    arguments.billerSuccessDetailsList!.forEach((element) {
        totalBillAmt = double.parse(element.dueAmount ?? "0.0") + totalBillAmt;
    });*/
    return arguments.totalBillAmt ?? 0.0;
  }

  String getBillerName(BuildContext context, BillerSuccessDetails item) {
    return StringUtils.isDirectionRTL(context) ? item.billerName ?? "" : item.billerName ?? "";
  }
}
