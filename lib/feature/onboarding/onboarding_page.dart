import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/onboarding/onboarding_module.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_model.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_view.dart';
import 'package:neo_bank/utils/color_utils.dart';

class OnBoardingPage extends BasePage<OnBoardingViewModel> {
  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState
    extends BaseStatefulPage<OnBoardingViewModel, OnBoardingPage> {
  @override
  ProviderBase provideBase() {
    return onBoardingViewModelProvider;
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
  Widget buildView(BuildContext context, OnBoardingViewModel model) {
    return OnBoardingPageView(provideBase());
  }
}
