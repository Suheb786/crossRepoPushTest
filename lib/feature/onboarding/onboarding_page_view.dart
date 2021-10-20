import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/login/login_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_model.dart';
import 'package:neo_bank/ui/molecules/pager/vertical_pager.dart';

class OnBoardingPageView extends BasePageViewWidget<OnBoardingViewModel> {
  OnBoardingPageView(ProviderBase model) : super(model);

  @override
  Widget build(BuildContext context, model) {
    return VerticalPager(
      titles: ["", ""],
      images: [LoginPage(), LoginPage()],
      initialPage: 0,
    );
  }
}
