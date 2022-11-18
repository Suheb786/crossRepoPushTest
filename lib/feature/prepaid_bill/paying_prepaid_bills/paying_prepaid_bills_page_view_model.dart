import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/prepaid_bill/paying_prepaid_bills/paying_prepaid_bills_page.dart';

class PayingPrePaidBillsPageViewModel extends BasePageViewModel {
  final PayingPrePaidBillsPageArgument argument;

  PayingPrePaidBillsPageViewModel(this.argument);

  TextEditingController searchBillController = TextEditingController();
  TextEditingController amtController = TextEditingController()..text = '50.000';
  TextEditingController savingAccountController = TextEditingController();
}
