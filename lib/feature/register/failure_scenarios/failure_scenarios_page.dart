import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:riverpod/src/framework.dart';

import '../../../di/account_registration/account_registration_modules.dart';
import 'failure_scenarios_page_view.dart';
import 'failure_scenarios_page_view_model.dart';


class OnboardingFailurScenariosPage extends BasePage<OnboardingFailureScenariosPageViewModel> {
  OnboardingFailureScenarioArgument argument;

  // final OnboardingFailureScenarioEnum scenarios;

  OnboardingFailurScenariosPage(this.argument);

  @override
  State<StatefulWidget> createState() {
    return OnboardingErrorScenariosPageState();
  }
}

class OnboardingErrorScenariosPageState
    extends BaseStatefulPage<OnboardingFailureScenariosPageViewModel, OnboardingFailurScenariosPage> {
  @override
  Widget buildView(BuildContext context, OnboardingFailureScenariosPageViewModel model) {
    return OnboardingFailureScenariosPageView(
      model: provideBase(),
    );
  }

  @override
  ProviderBase provideBase() {
    return onboardingErrorScenariosPageViewModel;
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }

  @override
  void onModelReady(OnboardingFailureScenariosPageViewModel model) {
    model.argument = widget.argument;
    super.onModelReady(model);
  }
}

class OnboardingFailureScenarioArgument {
  final String title;
  final String description;

  OnboardingFailureScenarioArgument({required this.title, required this.description});
}
