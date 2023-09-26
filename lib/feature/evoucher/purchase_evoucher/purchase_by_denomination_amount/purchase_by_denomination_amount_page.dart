import 'package:domain/model/e_voucher/voucher_item.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_by_denomination_amount/purchase_by_denomination_amount_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_by_denomination_amount/purchase_by_denomination_amount_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

class PurchaseByDenominationAmountPage extends BasePage<PurchaseByDenominationAmountPageViewModel> {
  final PurchaseByDenominationAmountPageArgument argument;

  PurchaseByDenominationAmountPage({required this.argument});

  @override
  State<StatefulWidget> createState() => PurchaseByDenominationAmountPageState();
}

class PurchaseByDenominationAmountPageState
    extends BaseStatefulPage<PurchaseByDenominationAmountPageViewModel, PurchaseByDenominationAmountPage> {
  @override
  Widget buildView(BuildContext context, PurchaseByDenominationAmountPageViewModel model) {
    return PurchaseByDenominationAmountPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return purchaseByDenominationAmountPageViewModel.call(widget.argument);
  }
}

class PurchaseByDenominationAmountPageArgument {
  List<VoucherItem> voucherItems;
  String category;

  PurchaseByDenominationAmountPageArgument({required this.voucherItems, required this.category});
}
