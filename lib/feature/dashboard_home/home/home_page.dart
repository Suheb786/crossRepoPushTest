import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/home/home_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/home/home_view_model.dart';

class HomePage extends BasePage<HomeViewModel> {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseStatefulPage<HomeViewModel, HomePage> {
  @override
  ProviderBase provideBase() {
    return homeViewModelProvider;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, HomeViewModel model) {
    return HomePageView(provideBase());
  }
}
