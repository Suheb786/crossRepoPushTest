import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/help_center/help_center_page.dart';
import 'package:neo_bank/feature/login/login_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_model.dart';
import 'package:neo_bank/feature/registerselection/register_selection_page.dart';

class OnBoardingPageView extends BasePageViewWidget<OnBoardingViewModel> {
  OnBoardingPageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    LoginPage(),
    RegisterSelectionPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: model.onBoardingPageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        LoginPage(),
        RegisterSelectionPage(),
      ],
    );
  }
}
