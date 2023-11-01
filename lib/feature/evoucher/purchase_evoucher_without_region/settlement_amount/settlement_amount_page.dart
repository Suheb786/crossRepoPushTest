// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/settlement_amount/settlement_amount_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher_without_region/settlement_amount/settlement_amount_page_view_model.dart';

import '../purchase_evoucher_without_region_page.dart';

class SettlementAccountPage extends BasePage<SettlementAmountPageViewModel> {
  final PurchaseEVoucherWithoutRegionPageArgument argument;

  SettlementAccountPage({
    required this.argument,
  });

  @override
  SettlementAccountPageState createState() => SettlementAccountPageState();
}

class SettlementAccountPageState
    extends BaseStatefulPage<SettlementAmountPageViewModel, SettlementAccountPage>
    with AutomaticKeepAliveClientMixin {
  SettlementAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return settlementAccountViewModelProvider.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget buildView(BuildContext context, SettlementAmountPageViewModel model) {
    return SettlementAmountPageView(provideBase());
  }

  @override
  Future<bool> onBackPressed(SettlementAmountPageViewModel model, {param}) async {
    var parentModel = ProviderScope.containerOf(context).read(purchaseEVoucherWithoutRegionPageViewModel);
    if (parentModel.appSwiperController.page != 0) {
      parentModel.previousPage();
      return false;
    } else {
      return super.onBackPressed(model);
    }
  }
}
