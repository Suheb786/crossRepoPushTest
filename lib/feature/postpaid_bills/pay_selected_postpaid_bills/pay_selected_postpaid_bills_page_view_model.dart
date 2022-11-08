import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/postpaid_bills/pay_selected_postpaid_bills/pay_selected_postpaid_bills_page.dart';

class PaySelectedBillsPostPaidBillsPageViewModel extends BasePageViewModel {
  final PaySelectedBillsPostPaidBillsPageArguments arguments;

  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();

  PaySelectedBillsPostPaidBillsPageViewModel(this.arguments);
}
