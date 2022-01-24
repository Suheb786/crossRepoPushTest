import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_page_view.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ActivityHomePage extends BasePage<ActivityHomeViewModel> {
  @override
  ActivityHomePageState createState() => ActivityHomePageState();
}

class ActivityHomePageState
    extends BaseStatefulPage<ActivityHomeViewModel, ActivityHomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  ProviderBase provideBase() {
    return activityHomeViewModelProvider;
  }

  @override
  Widget buildView(BuildContext context, ActivityHomeViewModel model) {
    return ActivityHomePageView(provideBase());
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
        initialActiveIndex: 0,
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.pop(context);
              break;
            case 1:
              SettingsDialog.show(
                context,
              );
              break;
            case 2:
              EngagementTeamDialog.show(context, onDismissed: () {
                Navigator.pop(context);
              }, onSelected: (value) {
                Navigator.pop(context);
              });
              break;
          }
        },
      ),
    );
  }

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
  bool get wantKeepAlive => true;
}
