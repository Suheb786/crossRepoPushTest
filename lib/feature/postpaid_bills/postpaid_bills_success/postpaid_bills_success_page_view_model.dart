import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/postpaid_bills_success/postpaid_bills_success_page.dart';

class PostPaidBillsSuccessPageViewModel extends BasePageViewModel {
  final PostPaidBillsSuccessPageArguments arguments;

  PostPaidBillsSuccessPageViewModel(this.arguments);
    addAllBillAmt() {
      var totalBillAmt = 0.0;
      if (arguments.billerList == null || arguments.billerList!.isEmpty)
        return totalBillAmt;

      arguments.billerList!.forEach((element) {
          totalBillAmt =
              double.parse(element.totalAmount ?? "0.0") + totalBillAmt;
      });
      return totalBillAmt;
    }
}
