import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evouchers/evouchers_modules.dart';
import 'package:neo_bank/feature/evouchers/purchase_voucher_success/purchase_voucher_success_page_view.dart';
import 'package:neo_bank/feature/evouchers/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';

class PurchaseVoucherSuccessPage extends BasePage<PurchaseVoucherSuccessPageViewModel> {
  @override
  PurchaseVoucherSuccessPageState createState() => PurchaseVoucherSuccessPageState();
}

class PurchaseVoucherSuccessPageState
    extends BaseStatefulPage<PurchaseVoucherSuccessPageViewModel, PurchaseVoucherSuccessPage> {
  @override
  ProviderBase provideBase() {
    return purchaseVoucherViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, PurchaseVoucherSuccessPageViewModel model) {
    return PurchaseVoucherSuccessPageView(provideBase());
  }
}
