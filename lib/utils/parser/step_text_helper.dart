import 'package:flutter/material.dart';

class StepTextHelper {
  StepTextHelper._();

  static String accountRegistrationTextHelper(
      int index, String step1, String step2, String step3) {
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      case 2:
        return step3;
      default:
        return step1;
    }
  }

  static String registrationFirstStepTextHelper(int index, String step1, String step2, String step3, String step4) {
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
        return step2;
    }
  }

  static String registrationTwoStepTextHelper(int index, String step1, String step2) {
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      default:
        return step1;
    }
  }

  static String registrationThreeStepTextHelper(int index, String step1) {
    switch (index) {
      case 0:
        return step1;
      default:
        return step1;
    }
  }

  static String registrationFourStepTextHelper(int index,
      String step1,
      String step2,
      String step3,
      String step4,
      String step5,
      String step6,
      String step7,
      String step8) {
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      case 2:
        return step3;
      case 3:
        return step4;
      case 4:
        return step5;
      case 5:
        return step6;
      case 6:
        return step7;
      case 7:
        return step8;
      default:
        return step1;
    }
  }

  static String registrationFiveStepTextHelper(int index, String step1,
      String step2, String step3, String step4, String step5) {
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      case 2:
        return step3;
      case 3:
        return step4;
      case 4:
        return step5;
      default:
        return step1;
    }
  }

  static String accountRegistrationStepTextHelper(int index, String step1, String step2, String step3, String step4) {
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

  static Widget paymentToNewRecipientStepTextHelper(
      int index, Widget step1, Widget step2) {
    print("got index : ${index}");
    switch (index) {
      case 0:
        return step1;
      case 1:
        return step2;
      default:
        return step1;
    }
  }
}
