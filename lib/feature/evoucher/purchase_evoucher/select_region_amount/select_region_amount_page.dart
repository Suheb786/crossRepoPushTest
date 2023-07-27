import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';

class SelectRegionAmountPage extends BasePage<SelectRegionAmountPageViewModel> {
  final PurchaseEVoucherPageArgument argument;

  SelectRegionAmountPage(this.argument);
  @override
  SelectRegionAmountPageState createState() => SelectRegionAmountPageState();
}

class SelectRegionAmountPageState
    extends BaseStatefulPage<SelectRegionAmountPageViewModel, SelectRegionAmountPage>
    with AutomaticKeepAliveClientMixin {
  SelectRegionAmountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectAmountRegionViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  void onModelReady(SelectRegionAmountPageViewModel model) {
    model.voucherItems.clear();
    model.voucherItems.addAll(widget.argument.voucherItems);
    model.selectedItem = widget.argument.selectedItem;
    model.getRegionFromVoucherIds();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, SelectRegionAmountPageViewModel model) {
    return SelectRegionAmountPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
