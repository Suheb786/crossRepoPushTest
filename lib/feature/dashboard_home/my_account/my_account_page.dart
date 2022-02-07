import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/my_account/my_account_view_model.dart';
import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_content.dart';

class MyAccountPage extends BasePage<MyAccountViewModel> {
  final GetDashboardDataContent cardData;
  MyAccountPage({required this.cardData});
  @override
  MyAccountPageState createState() => MyAccountPageState();
}

class MyAccountPageState
    extends BaseStatefulPage<MyAccountViewModel, MyAccountPage>
    with AutomaticKeepAliveClientMixin {
  MyAccountPageState() : super(subscribeVisibilityEvents: true);

  @override
  ProviderBase provideBase() {
    return myAccountViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, MyAccountViewModel model) {
    model.deviceSize = MediaQuery.of(context).size;
    return MyAccountPageView(provideBase(), widget.cardData);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
