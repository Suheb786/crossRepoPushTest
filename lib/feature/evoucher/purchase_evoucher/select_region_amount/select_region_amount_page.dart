import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/evoucher/evoucher_modules.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view.dart';
import 'package:neo_bank/feature/evoucher/purchase_evoucher/select_region_amount/select_region_amount_page_view_model.dart';

class SelectRegionAmountPage extends BasePage<SelectRegionAmountPageViewModel> {
  @override
  SelectRegionAmountPageState createState() => SelectRegionAmountPageState();
}

class SelectRegionAmountPageState
    extends BaseStatefulPage<SelectRegionAmountPageViewModel, SelectRegionAmountPage>
    with AutomaticKeepAliveClientMixin {
  SelectRegionAmountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return selectAmountRegionViewModelProvider;
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
  Widget buildView(BuildContext context, SelectRegionAmountPageViewModel model) {
    return SelectRegionAmountPageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
