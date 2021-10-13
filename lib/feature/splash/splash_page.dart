import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/splash/splash_modules.dart';
import 'package:neo_bank/feature/splash/splash_page_model.dart';
import 'package:neo_bank/feature/splash/splash_page_view.dart';
import 'package:neo_bank/utils/color_utils.dart';

class SplashPage extends BasePage<SplashViewModel> {
  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends BaseStatefulPage<SplashViewModel, SplashPage> {
  @override
  ProviderBase provideBase() {
    return splashViewModelProvider;
  }

  @override
  void onModelReady(SplashViewModel model) {
    model.startTimer();
  }

  @override
  bool extendBodyBehindAppBar() {
    return true;
  }

  @override
  Color scaffoldBackgroundColor() {
    return AppColor.very_dark_blue;
  }

  @override
  Widget buildView(BuildContext context, SplashViewModel model) {
    return SplashPageView(provideBase());
  }
}
