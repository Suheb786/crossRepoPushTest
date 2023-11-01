import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/purchase_evoucher_without_region_page_view.dart';
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
    return PurchaseEVoucherWithoutRegionPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return purchaseEVoucherWithoutRegionPageViewModel;
  }

  @override
  void onModelReady(PurchaseEVoucherWithoutRegionPageViewModel model) {
    model.argument = widget.argument;
    super.onModelReady(model);
  }

  @override
  Future<bool> onBackPressed(PurchaseEVoucherWithoutRegionPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(purchaseEVoucherWithoutRegionPageViewModel);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}

class PurchaseEVoucherWithoutRegionPageArgument {
  final VoucherItem selectedItem;
  final double settlementAmount;

  PurchaseEVoucherWithoutRegionPageArgument({required this.selectedItem, required this.settlementAmount});
}
