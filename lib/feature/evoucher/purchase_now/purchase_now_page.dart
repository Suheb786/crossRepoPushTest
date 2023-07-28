import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_model.dart';
import 'package:neo_bank/feature/evoucher/purchase_now/purchase_now_detail_view.dart';

class PurchaseNowDetailPage extends BasePage<PurchaseNowDetailViewModel> {
  final PurchaseNowArgument argument;

  PurchaseNowDetailPage(this.argument);

  @override
  EvoucherDetailState createState() => EvoucherDetailState();
}

class EvoucherDetailState extends BaseStatefulPage<PurchaseNowDetailViewModel, PurchaseNowDetailPage> {
  @override
  ProviderBase provideBase() {
    return purchaseNowDetailViewModelProvider.call(widget.argument);
  }

  @override
  Widget buildView(BuildContext context, PurchaseNowDetailViewModel model) {
    return PurchaseNowDetailView(provideBase());
  }
}

class PurchaseNowArgument {
  VoucherItem selectedVoucherItem;

  PurchaseNowArgument({required this.selectedVoucherItem});
}
