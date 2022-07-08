import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evouchers/evouchers_modules.dart';
import 'package:neo_bank/feature/evouchers/purchase_evoucher/select_account/select_account_page_view.dart';
import 'package:neo_bank/feature/evouchers/purchase_evoucher/select_account/select_account_page_view_model.dart';

class SelectAccountPage extends BasePage<SelectAccountPageViewModel> {
  @override
  SelectAccountPageState createState() => SelectAccountPageState();
}

class SelectAccountPageState extends BaseStatefulPage<SelectAccountPageViewModel, SelectAccountPage>
    with AutomaticKeepAliveClientMixin {
  SelectAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectAccountViewModelProvider;
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
    return SelectAccountPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
