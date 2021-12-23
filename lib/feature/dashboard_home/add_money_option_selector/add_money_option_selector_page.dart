import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/add_money_option_selector/add_money_option_selector_page_view_model.dart';

class AddMoneyOptionSelectorPage
    extends BasePage<AddMoneyOptionSelectorViewModel> {
  @override
  AddMoneyOptionSelectorPageState createState() =>
      AddMoneyOptionSelectorPageState();
}

class AddMoneyOptionSelectorPageState extends BaseStatefulPage<
    AddMoneyOptionSelectorViewModel,
    AddMoneyOptionSelectorPage> {
  @override
  ProviderBase provideBase() {
    return addMoneyOptionSelectorViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme
        .of(context)
        .primaryColorDark;
  }

  @override
  Widget buildView(BuildContext context,
      AddMoneyOptionSelectorViewModel model) {
    return AddMoneyOptionSelectorPageView(provideBase());
  }
}
