import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/onboarding/login_landing_page/login_landing_page.dart';
import 'package:neo_bank/feature/onboarding/onboarding_page_model.dart';
import 'package:neo_bank/feature/onboarding/registerselection/register_selection_page.dart';
import 'package:neo_bank/ui/molecules/stream_builder/app_stream_builder.dart';
import 'package:neo_bank/utils/resource.dart';

class OnBoardingPageView extends BasePageViewWidget<OnBoardingViewModel> {
  OnBoardingPageView(ProviderBase model) : super(model);

  final List<Widget> pages = [
    LoginLandingPage(),
    RegisterSelectionPage(),
  ];

  @override
  Widget build(BuildContext context, model) {
    return AppStreamBuilder<Resource<bool>>(
      initialData: Resource.none(),
      stream: model.checkVersionUpdateStream,
      onData: (data) {},
      dataBuilder: (context, data) {
        return PageView(
            scrollDirection: Axis.vertical,
            controller: model.onBoardingPageController,
            physics: NeverScrollableScrollPhysics(),
            children: pages);
      },
    );
  }
}
