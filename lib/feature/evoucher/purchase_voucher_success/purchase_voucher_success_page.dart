import 'package:domain/model/e_voucher/place_order.dart';
import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_voucher_success/purchase_voucher_success_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';

import '../../../main/navigation/route_paths.dart';

class PurchaseVoucherSuccessPage extends BasePage<PurchaseVoucherSuccessPageViewModel> {
  final PurchaseVoucherSuccessArgument argument;

  PurchaseVoucherSuccessPage({required this.argument});

  @override
  PurchaseVoucherSuccessPageState createState() => PurchaseVoucherSuccessPageState();
}

class PurchaseVoucherSuccessPageState
    extends BaseStatefulPage<PurchaseVoucherSuccessPageViewModel, PurchaseVoucherSuccessPage> {
  @override
  ProviderBase provideBase() {
    return purchaseVoucherViewModelProvider.call(widget.argument);
  }

  @override
  Widget buildView(BuildContext context, PurchaseVoucherSuccessPageViewModel model) {
    return PurchaseVoucherSuccessPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(PurchaseVoucherSuccessPageViewModel model, {param}) {
    final provider = ProviderScope.containerOf(context).read(
      evoucherViewModelProvider,
    );

    Navigator.popUntil(context, (route) => route.settings.name == RoutePaths.Evoucher);

    provider.tabChangeNotifier.value = 1;
    provider.myVoucherHistoryList = [];
    provider.getVoucherCategories();
    // to switch to history tab...
    provider.switchTabSubject.safeAdd(1);
    return super.onBackPressed(model);
  }
}

class PurchaseVoucherSuccessArgument {
  final VoucherItem selectedItem;
  final String? settlementAmount;
  final PlaceOrder? placeOrder;

  PurchaseVoucherSuccessArgument({required this.selectedItem, this.placeOrder, this.settlementAmount});
}
