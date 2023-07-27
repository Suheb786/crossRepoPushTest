import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page_view_model.dart';

import '../../../base/base_page.dart';
import '../../../di/evoucher/evoucher_modules.dart';

class PurchaseEVoucherWithoutRegionPage extends BasePage<PurchaseEVoucherWithoutRegionPageViewModel> {
  final PurchaseEVoucherWithoutRegionPageArgument argument;
  PurchaseEVoucherWithoutRegionPage({
    required this.argument,
  });
  @override
  PurchaseEVoucherWithoutRegionPageState createState() => PurchaseEVoucherWithoutRegionPageState();
}

class PurchaseEVoucherWithoutRegionPageState
    extends BaseStatefulPage<PurchaseEVoucherWithoutRegionPageViewModel, PurchaseEVoucherWithoutRegionPage> {
  @override
  Widget buildView(BuildContext context, PurchaseEVoucherWithoutRegionPageViewModel model) {
    // TODO: implement buildView
    throw UnimplementedError();
  }

  @override
  ProviderBase provideBase() {
    return purchaseEVoucherWithoutRegionPageViewModel.call(widget.argument);
  }
}

class PurchaseEVoucherWithoutRegionPageArgument {
  List<VoucherItem> voucherItems;
  final VoucherItem selectedItem;
  PurchaseEVoucherWithoutRegionPageArgument({
    required this.voucherItems,
    required this.selectedItem,
  });
}
