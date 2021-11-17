import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/splash/splash_modules.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';
import 'package:neo_bank/feature/splash/splash_page_view.dart';

class SplashPage extends BasePage<SplashViewModel> {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends BaseStatefulPage<SplashViewModel, SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  ProviderBase provideBase() {
    return splashViewModelProvider;
  }

  @override
  void onModelReady(SplashViewModel model) {
    model.animationController = AnimationController(vsync: this);
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Widget buildView(BuildContext context, SplashViewModel model) {
    return SplashPageView(provideBase());
  }
}
