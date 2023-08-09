import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/feature/account_registration/failure_scenarios/failure_scenarios_page_view.dart';
import 'package:neo_bank/feature/account_registration/failure_scenarios/failure_scenarios_page_view_model.dart';
import 'package:riverpod/src/framework.dart';

import '../../../di/account_registration/account_registration_modules.dart';

class OnboardingFailurScenariosPage extends BasePage<OnboardingFailureScenariosPageViewModel> {
   OnboardingFailureScenarioArgument argument  ;

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
    return onboardingErrorScenariosPageViewModel.call(widget.argument);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).primaryColor;
  }
}

enum OnboardingFailureScenarioEnum {
  INELIGIBLE_IDENTITY,
  SELFIE_MISMATCHED,
  REGISTRATION_STOPPED,
}

class OnboardingFailureScenarioArgument {
  final OnboardingFailureScenarioEnum scenarios;

  OnboardingFailureScenarioArgument({this.scenarios = OnboardingFailureScenarioEnum.INELIGIBLE_IDENTITY});
}
