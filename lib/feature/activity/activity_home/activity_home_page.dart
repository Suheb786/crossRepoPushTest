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
import 'package:neo_bank/utils/sizer_helper_util.dart';

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
      padding: EdgeInsets.only(bottom: 24.0.h),
      child: ConvexAppBar(
        elevation: 0,
        style: TabStyle.fixedCircle,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        items: [
          TabItem(icon: AppSvg.asset(AssetUtils.house), title: " "),
          TabItem(
            icon: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 80.0.h,
                width: 80.0.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    shape: BoxShape.circle),
                child: Center(
                  child: AppSvg.asset(AssetUtils.logoWhite),
                ),
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
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  void onModelReady(ActivityHomeViewModel model) {
    // model.getRequestMoneyActivity(true);
    super.onModelReady(model);
  }

  @override
  bool get wantKeepAlive => true;
}
