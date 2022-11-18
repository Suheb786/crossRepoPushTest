import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

import 'how_much_like_to_pay_prepaid_bills_page.dart';

class HowMuchLikeToPayPrePaidBillsPageViewModel extends BasePageViewModel {
  final HowMuchLikeToPayPrePaidBillsPageArgument argument;

  HowMuchLikeToPayPrePaidBillsPageViewModel(this.argument);

  TextEditingController searchBillController = TextEditingController();
  TextEditingController amtController = TextEditingController()..text = '50.000';
  TextEditingController savingAccountController = TextEditingController()..text = 'Savings Account';
}
