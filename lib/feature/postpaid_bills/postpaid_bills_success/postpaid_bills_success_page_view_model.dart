import 'package:domain/model/bill_payments/add_new_postpaid_biller/add_new_postpaid_biller_model.dart';
import 'package:domain/usecase/bill_payment/add_new_postpaid_biller_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';
import 'package:neo_bank/utils/app_constants.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class PostPaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PostPaidBillsSuccessPageArguments arguments;

  PostPaidBillsSuccessPageViewModel(this.arguments);

  double addAllBillAmt() {
    double totalBillAmt = 0.0;
    if (arguments.billerList == null || arguments.billerList!.isEmpty)
      return totalBillAmt;

    arguments.billerList!.forEach((element) {
      totalBillAmt = double.parse(element.totalAmount ?? "0.0") + totalBillAmt;
    });
    return totalBillAmt;
  }
}
