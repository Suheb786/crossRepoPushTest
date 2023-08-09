import '../../../base/base_page_view_model.dart';
import '../../../generated/l10n.dart';
import 'failure_scenarios_page.dart';

class OnboardingFailureScenariosPageViewModel extends BasePageViewModel {
  final OnboardingFailureScenarioArgument argument;

  OnboardingFailureScenariosPageViewModel({required this.argument});

  String getTitle(OnboardingFailureScenarioEnum scenario) {
    switch (scenario) {
      case OnboardingFailureScenarioEnum.INELIGIBLE_IDENTITY:
        return S.current.ineligibleIdentity;
      case OnboardingFailureScenarioEnum.SELFIE_MISMATCHED:
        return S.current.selfieMismatched;
      case OnboardingFailureScenarioEnum.REGISTRATION_STOPPED:
        return S.current.registrationStopped;
      default:
        return S.current.ineligibleIdentity;
    }
  }

  String getDescription(OnboardingFailureScenarioEnum scenario) {
    switch (scenario) {
      case OnboardingFailureScenarioEnum.INELIGIBLE_IDENTITY:
        return S.current.ineligibleIdentityDescription;
      case OnboardingFailureScenarioEnum.SELFIE_MISMATCHED:
        return S.current.selfieMismatchedDescription;
      case OnboardingFailureScenarioEnum.REGISTRATION_STOPPED:
        return S.current.registrationStoppedDescription;
      default:
        return S.current.ineligibleIdentityDescription;
    }
  }
}
