import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';

import 'package:neo_bank/ui/molecules/evoucher/my_voucher_tab.dart';

import '../evoucher_model.dart';

class MyVoucherView extends BasePageViewWidget<EvoucherViewModel> {
  MyVoucherView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return MyVoucherTab();
  }
}
