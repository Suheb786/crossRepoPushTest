import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page_view.dart';
import 'package:neo_bank/feature/manage_credit_settlement/manage_credit_settlement_page_view_model.dart';

class ManageCreditSettlementPage
    extends BasePage<ManageCreditSettlementViewModel> {
  @override
  ManageCreditSettlementPageState createState() =>
      ManageCreditSettlementPageState();
}

class ManageCreditSettlementPageState extends BaseStatefulPage<
    ManageCreditSettlementViewModel, ManageCreditSettlementPage> {
  @override
  ProviderBase provideBase() {
    return manageCreditSettlementPageViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(
      BuildContext context, ManageCreditSettlementViewModel model) {
    return ManageCreditSettlementPageView(provideBase());
  }
}
