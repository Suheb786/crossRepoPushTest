class StepTextHelper {
  StepTextHelper._();

  static String registrationFirstStepTextHelper(
      int index, String step1, String step2, String step3, String step4) {
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      case 2:
        return step3;
      case 3:
        return step4;
      default:
        return step1;
    }
  }
}
