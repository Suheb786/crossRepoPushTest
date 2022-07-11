import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/ui/molecules/evoucher/buy_evoucher_tab.dart';

import '../evoucher_model.dart';

class BuyEvoucherView extends BasePageViewWidget<EvoucherViewModel> {
  BuyEvoucherView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return BuyEvoucherTab();
  }
}
