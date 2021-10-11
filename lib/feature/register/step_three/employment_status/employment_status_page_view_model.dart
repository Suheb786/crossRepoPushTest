import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';

class EmploymentStatusPageViewModel extends BasePageViewModel {
  final TextEditingController employmentStatusController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> employmentStatusKey =
      GlobalKey(debugLabel: "employmentStatus");

  final TextEditingController occupationController = TextEditingController();
  final GlobalKey<AppTextFieldState> occupationKey =
      GlobalKey(debugLabel: "occupation");

  final TextEditingController sourceController = TextEditingController();
  final GlobalKey<AppTextFieldState> sourceKey =
      GlobalKey(debugLabel: "source");

  final TextEditingController monthlyIncomeController = TextEditingController();
  final GlobalKey<AppTextFieldState> monthlyIncomeKey =
      GlobalKey(debugLabel: "monthlyIncome");

  final TextEditingController annualIncomeController = TextEditingController();
  final GlobalKey<AppTextFieldState> annualIncomeKey =
      GlobalKey(debugLabel: "annualIncome");

  final TextEditingController purposeOfAccountOpeningController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> purposeOfAccountOpeningKey =
      GlobalKey(debugLabel: "purposeOfAccountOpening");

  final TextEditingController employerNameController = TextEditingController();
  final GlobalKey<AppTextFieldState> employerNameKey =
      GlobalKey(debugLabel: "employerName");

  final TextEditingController employerCountryController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> employerCountryKey =
      GlobalKey(debugLabel: "employerCountry");

  final TextEditingController employerCityController = TextEditingController();
  final GlobalKey<AppTextFieldState> employerCityKey =
      GlobalKey(debugLabel: "employerCity");

  final TextEditingController employerContactController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> employerContactKey =
      GlobalKey(debugLabel: "employerContact");

  final TextEditingController additionalSourceIncomeController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> additionalSourceIncomeKey =
      GlobalKey(debugLabel: "additionalSourceIncome");

  final TextEditingController totalAdditionalIncomeController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> totalAdditionalIncomeKey =
      GlobalKey(debugLabel: "totalAdditional");

  void updateEmploymentStatus(String value) {
    employmentStatusController.text = value;
    notifyListeners();
  }

  void updateOccupation(String value) {
    occupationController.text = value;
    notifyListeners();
  }

  void updatePurposeOfAccountOpening(String value) {
    purposeOfAccountOpeningController.text = value;
    notifyListeners();
  }

  void updateEmployerCountry(String value) {
    employerCountryController.text = value;
    notifyListeners();
  }

  void updateAdditionalIncome(String value) {
    additionalSourceIncomeController.text = value;
    notifyListeners();
  }
}
