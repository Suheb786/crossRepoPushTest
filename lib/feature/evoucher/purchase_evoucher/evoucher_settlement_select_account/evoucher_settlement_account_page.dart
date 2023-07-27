// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view_model.dart.dart';

class EvoucherSettlementAccountPage extends BasePage<EvoucherSettlementAccountPageViewModel> {
  final PurchaseEVoucherPageArgument argument;

  EvoucherSettlementAccountPage({
    required this.argument,
  });

  @override
  EvoucherSettlementAccountPageState createState() => EvoucherSettlementAccountPageState();
}

class EvoucherSettlementAccountPageState
    extends BaseStatefulPage<EvoucherSettlementAccountPageViewModel, EvoucherSettlementAccountPage>
    with AutomaticKeepAliveClientMixin {
  EvoucherSettlementAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return evoucherSettlementAccountViewModelProvider.call(widget.argument);
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
  Widget buildView(BuildContext context, EvoucherSettlementAccountPageViewModel model) {
    return EvoucherSettlementAccountPageView(
      provideBase(),
    );
  }

  @override
  void onModelReady(EvoucherSettlementAccountPageViewModel model) {
    model.getDashboardData();
  }

  @override
  bool get wantKeepAlive => true;
}
