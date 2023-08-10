import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page_view_new.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog.dart';
import 'package:neo_bank/ui/molecules/dialog/help_center/engagement_team_dialog/engagment_team_dialog.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';

import '../../../ui/molecules/dashboard/bottom_bar_widget.dart';

class AppHomePage extends BasePage<AppHomeViewModel> {
  @override
  AppHomePageState createState() => AppHomePageState();
}

class AppHomePageState extends BaseStatefulPage<AppHomeViewModel, AppHomePage> with AutomaticKeepAliveClientMixin, WidgetsBindingObserver, TickerProviderStateMixin {
  @override
  ProviderBase provideBase() {
    return appHomeViewModelProvider;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (Platform.isIOS) {
        getViewModel().timer = new Timer(
          const Duration(milliseconds: 1000),
          () {
            getViewModel().onResumeDynamicLink();
          },
        );
      } else {
        getViewModel().initDynamicLink();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onModelReady(AppHomeViewModel model) {
    if (!model.animationInitialized) {
      model.animationInitialized = true;

      model.translateSettingsUpController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      model.animation = Tween<double>(
        begin: 0,
        end: 1,
      ).animate(
        CurvedAnimation(
          parent: model.translateSettingsUpController,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ),
      );

      model.scaleAnimationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
        lowerBound: 1,
        upperBound: 2,
      );

      model.translateSidewaysController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );

      model.translateTimelineDownController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
        reverseDuration: const Duration(milliseconds: 400),
      );

      model.zoomController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
      model.zoomAnimation = Tween<double>(
        begin: 1.5,
        end: 1,
      ).animate(model.zoomController);

      model.timelineScrollController = ScrollController();
    }
    super.onModelReady(model);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
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
  Widget buildView(BuildContext context, AppHomeViewModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ///Main View
        AnimatedBuilder(
            animation: model.zoomController,
            builder: (context, child) {
              return Transform.scale(
                scale: model.firstTime ? 1 : model.zoomAnimation.value,
                child: child!,
              );
            },
            child: AppHomePageViewNew(
              provideBase(),
            )),

        ///Bottom Navigation Bar
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: AnimatedOpacity(
            duration: model.settings || model.showPayBackView || model.timelinePage ? const Duration(milliseconds: 200) : const Duration(seconds: 2),
            opacity: model.settings || model.showPayBackView || model.timelinePage ? 0 : 1,
            child: Padding(
              padding: EdgeInsets.only(top: 24.0.h, bottom: 0.0.h),
              child: BottomBarWidget(
                onHomeTap: () {
                  if (model.settings || model.showPayBackView || model.timelinePage) {
                  } else {
                    model.moveToPage(0);
                  }
                },
                onMoreTap: () {
                  if (model.settings || model.showPayBackView || model.timelinePage) {
                  } else {
                    SettingsDialog.show(context);
                  }
                },
                onContactUsTap: () {
                  if (model.settings || model.showPayBackView || model.timelinePage) {
                  } else {
                    EngagementTeamDialog.show(context, onDismissed: () {
                      Navigator.pop(context);
                    }, onSelected: (value) {
                      Navigator.pop(context);
                    });
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
