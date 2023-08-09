import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view_model.dart';

class PurchaseEVoucherPage extends BasePage<PurchaseEVoucherPageViewModel> {
  final PurchaseEVoucherPageArgument argument;

  PurchaseEVoucherPage({
    required this.argument,
  });

  @override
  PurchaseEVoucherPageState createState() => PurchaseEVoucherPageState();
}

class PurchaseEVoucherPageState
    extends BaseStatefulPage<PurchaseEVoucherPageViewModel, PurchaseEVoucherPage> {
  @override
  ProviderBase provideBase() {
    return purchaseEVouchersViewModelProvider;
  }

  @override
  void onModelReady(PurchaseEVoucherPageViewModel model) {
    super.onModelReady(model);
    model.voucherItems = widget.argument.voucherItems;
  }

  @override
  Widget buildView(BuildContext context, PurchaseEVoucherPageViewModel model) {
    return PurchaseEVoucherPageView(provideBase());
  }
}

class PurchaseEVoucherPageArgument {
  List<VoucherItem> voucherItems;

  PurchaseEVoucherPageArgument({required this.voucherItems});
}
