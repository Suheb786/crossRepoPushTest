import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/my_debit_card/my_debit_card_view_model.dart';

class MyDebitCardPage extends BasePage<MyDebitCardViewModel> {
  @override
  MyDebitCardPageState createState() => MyDebitCardPageState();
}

class MyDebitCardPageState
    extends BaseStatefulPage<MyDebitCardViewModel, MyDebitCardPage>
    with AutomaticKeepAliveClientMixin {
  MyDebitCardPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return myDebitCardViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, MyDebitCardViewModel model) {
    return MyDebitCardPageView(provideBase());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
