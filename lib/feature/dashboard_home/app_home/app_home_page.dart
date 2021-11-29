import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/register/register_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AppHomePage extends BasePage<AppHomeViewModel> {
  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends BaseStatefulPage<AppHomeViewModel, AppHomePage> {
  @override
  ProviderBase provideBase() {
    return appHomeViewModelProvider;
  }

  @override
  Widget? buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.0),
      child: BottomAppBar(
        notchMargin: 0,
        elevation: 0,
        clipBehavior: Clip.none,
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 65),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(AssetUtils.house),
              Image.asset(AssetUtils.headphoneBlack),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget? buildFloatingActionButton() {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark, shape: BoxShape.circle),
      child: Center(
        child: Image.asset(AssetUtils.logoWhite),
      ),
    );
  }


  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, AppHomeViewModel model) {
    return AppHomePageView(provideBase());
  }
}