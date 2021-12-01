import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view.dart';
import 'package:neo_bank/feature/dashboard/dashboard_page_view_model.dart';

class DashboardPage extends BasePage<DashboardPageViewModel> {
  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState
    extends BaseStatefulPage<DashboardPageViewModel, DashboardPage> {
  @override
  ProviderBase provideBase() {
    return dashboardViewModelProvider;
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  Widget buildView(BuildContext context, DashboardPageViewModel model) {
    return DashboardPageView(provideBase());
  }
}
