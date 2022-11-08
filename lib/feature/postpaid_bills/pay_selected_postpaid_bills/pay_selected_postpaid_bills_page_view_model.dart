import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/change_card_pin_success/change_card_pin_success_page.dart';

class PayAllPostPaidBillsPageViewModel extends BasePageViewModel {
  final ScrollController payingBillController = ScrollController();
  final TextEditingController savingAccountController = TextEditingController();
  final TextEditingController amtController = TextEditingController()..text = '13.220';
}
