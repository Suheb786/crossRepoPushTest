import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/activity/activity_modules.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_page_view.dart';
import 'package:neo_bank/feature/activity/activity_home/activity_home_view_model.dart';

class ActivityHomePage extends BasePage<ActivityHomeViewModel> {
  @override
  ActivityHomePageState createState() => ActivityHomePageState();
}

class ActivityHomePageState extends BaseStatefulPage<ActivityHomeViewModel, ActivityHomePage>
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
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).colorScheme.secondary;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
