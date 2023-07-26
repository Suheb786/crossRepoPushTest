// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/purchase_evoucher_page.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_account/select_account_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_account/select_account_page_view_model.dart';

class SelectAccountPage extends BasePage<SelectAccountPageViewModel> {
  final PurchaseEVoucherPageArgument argument;

  SelectAccountPage({
    required this.argument,
  });

  @override
  SelectAccountPageState createState() => SelectAccountPageState();
}

class SelectAccountPageState extends BaseStatefulPage<SelectAccountPageViewModel, SelectAccountPage>
    with AutomaticKeepAliveClientMixin {
  SelectAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectAccountViewModelProvider.call(widget.argument);
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
  Widget buildView(BuildContext context, SelectAccountPageViewModel model) {
    return SelectAccountPageView(
      provideBase(),
    );
  }

  @override
  void onModelReady(SelectAccountPageViewModel model) {
    model.getDashboardData();
  }

  @override
  bool get wantKeepAlive => true;
}
