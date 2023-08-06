import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_page_view_new.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/app_home_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/app_home/widgets/custom_svg_image.dart';
import 'package:neo_bank/utils/color_utils.dart';

import '../../../ui/molecules/dialog/dashboard/settings/settings_dialog_view.dart';
import '../../../utils/asset_utils.dart';

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
      model.deviceSize = MediaQuery.of(context).size;
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
        model.bottomBarIndex == BottomBarIndex.home
            ? AnimatedBuilder(
                animation: model.zoomController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: model.firstTime ? 1 : model.zoomAnimation.value,
                    child: child!,
                  );
                },
                child: AppHomePageViewNew(
                  provideBase(),
                ))
            : model.bottomBarIndex == BottomBarIndex.payment
                ? Container()
                : AppHomePageViewNew(
                    provideBase(),
                  ),

        ///Bottom Navigation Bar
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: model.settings || model.timelinePage /*|| context.watch<PaymentViewModel>().showSendMoneyView || context.watch<PaymentViewModel>().showReceiveMoneyView*/ ? 0 : 1,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              dividerColor: Colors.transparent,
            ),
            child: SizedBox(
              height: model.bottomNavbarHeight,
              child: BottomNavigationBar(
                currentIndex: 0,
                elevation: 0,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                enableFeedback: false,
                backgroundColor: model.showMainMenu ? Colors.black26 : Colors.white,
                onTap: (int value) {
                  ///Deactivate bottom nav bar when menu is open
                  if (!model.showMainMenu || value == 1) {
                    ///Zoom out animation while coming back from main menu modules
                    if (value == 0 && model.bottomBarIndex != BottomBarIndex.home) {
                      model.zoomController.forward();
                    }

                    ///
                    model.onBottomMenuTap(value, context);
                  }
                },
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    label: "Home",
                    icon: SVGImage(assetPath: AssetUtils.homeOutlineButton),
                  ),
                  BottomNavigationBarItem(
                    label: "Main",
                    icon: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SVGImage(assetPath: "assets/icons/mainButton.svg"),
                        model.showMainMenu
                            ? Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: AppColor.light_acccent_blue),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Support",
                    icon: SVGImage(assetPath: AssetUtils.contactUs),
                  )
                ],
              ),
            ),
          ),
        ),

        ///Main Menu
        model.showMainMenu ? SettingsDialogView() : const SizedBox(),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
