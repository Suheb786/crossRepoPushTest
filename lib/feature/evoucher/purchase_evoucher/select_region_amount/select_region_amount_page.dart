import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';

class SelectRegionAmountPage extends BasePage<SelectRegionAmountPageViewModel> {
  final SelectRegionAmountPageArgument argument;

  SelectRegionAmountPage({required this.argument});

  @override
  SelectRegionAmountPageState createState() => SelectRegionAmountPageState();
}

class SelectRegionAmountPageState
    extends BaseStatefulPage<SelectRegionAmountPageViewModel, SelectRegionAmountPage> {
  SelectRegionAmountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectAmountRegionViewModelProvider;
  }

  @override
  void onModelReady(SelectRegionAmountPageViewModel model) {
    model.argument = widget.argument;
    // model.voucherItems.clear();
    model.voucherItems = model.argument?.voucherItems ?? [];
    model.getRegionFromVoucherIds(context);
  }

  @override
  Widget buildView(BuildContext context, SelectRegionAmountPageViewModel model) {
    return SelectRegionAmountPageView(provideBase());
  }
}

class SelectRegionAmountPageArgument {
  List<VoucherItem> voucherItems;

  SelectRegionAmountPageArgument({required this.voucherItems});
}
