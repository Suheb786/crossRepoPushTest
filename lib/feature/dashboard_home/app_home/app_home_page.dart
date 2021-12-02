import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class AppHomePage extends BasePage<AppHomeViewModel> {
  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends BaseStatefulPage<AppHomeViewModel, AppHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return appHomeViewModelProvider;
  }

  @override
  Widget? buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: ConvexAppBar(
        elevation: 0,
        style: TabStyle.fixedCircle,
        backgroundColor: Theme.of(context).accentColor,
        items: [
          TabItem(icon: AppSvg.asset(AssetUtils.house), title: " "),
          TabItem(
            icon: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorDark,
                  shape: BoxShape.circle),
              child: Center(
                child: AppSvg.asset(AssetUtils.logoWhite),
              ),
            ),
          ),
          TabItem(
              icon: Container(child: AppSvg.asset(AssetUtils.headphoneBlack)),
              title: " "),
        ],
        initialActiveIndex: 1,
        onTap: (i) => print("got index $i"),
      ),
    );
  }

  // @override
  // Widget? buildFloatingActionButton() {
  //   return Container(
  //     height: 80,
  //     width: 80,
  //     decoration: BoxDecoration(
  //         color: Theme.of(context).primaryColorDark, shape: BoxShape.circle),
  //     child: Center(
  //       child: Image.asset(AssetUtils.logoWhite),
  //     ),
  //   );
  // }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  Widget buildView(BuildContext context, AppHomeViewModel model) {
    return AppHomePageView(provideBase());
  }

  @override
  bool get wantKeepAlive => true;
}
