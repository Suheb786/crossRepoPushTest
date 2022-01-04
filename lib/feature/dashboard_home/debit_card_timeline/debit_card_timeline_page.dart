import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';

class DebitCardTimeLinePage extends BasePage<DebitCardTimeLineViewModel> {
  @override
  DebitCardTimeLinePageState createState() => DebitCardTimeLinePageState();
}

class DebitCardTimeLinePageState extends BaseStatefulPage<
    DebitCardTimeLineViewModel, DebitCardTimeLinePage> {
  @override
  ProviderBase provideBase() {
    return debitCardTimeLineViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, DebitCardTimeLineViewModel model) {
    return DebitCardTimeLinePageView(provideBase());
  }
}
