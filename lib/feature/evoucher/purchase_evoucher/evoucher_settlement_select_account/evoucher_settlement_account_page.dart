import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/evoucher_settlement_select_account/evoucher_settlement_account_page_view_model.dart.dart';

class EvoucherSettlementAccountPage extends BasePage<EvoucherSettlementAccountPageViewModel> {
  @override
  EvoucherSettlementAccountPageState createState() => EvoucherSettlementAccountPageState();
}

class EvoucherSettlementAccountPageState
    extends BaseStatefulPage<EvoucherSettlementAccountPageViewModel, EvoucherSettlementAccountPage>
    with AutomaticKeepAliveClientMixin {
  EvoucherSettlementAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return evoucherSettlementAccountViewModelProvider;
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
  bool get wantKeepAlive => true;
}
