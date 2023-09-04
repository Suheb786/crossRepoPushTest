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
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
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
  void onModelReady(ActivityHomeViewModel model) {
    if (!model.animationInitialized) {
      model.animationInitialized = true;
      model.translateSettingsUpController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );

      model.translateSidewaysController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
    }

    super.onModelReady(model);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return stateBuild(context);
  }

  @override
  bool get wantKeepAlive => true;
}
