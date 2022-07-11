import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page_view_model.dart';

class PurchaseEVoucherPage extends BasePage<PurchaseEVoucherPageViewModel> {
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
  Widget buildView(BuildContext context, PurchaseEVoucherPageViewModel model) {
    return PurchaseEVoucherPageView(provideBase());
  }
}
