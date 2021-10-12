import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:domain/usecase/register/employment_status_usecase.dart';
import 'package:rxdart/rxdart.dart';

class EmploymentStatusPageViewModel extends BasePageViewModel {
  final EmploymentStatusUseCase _employmentDetailsUseCase;
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

  ///employment details request subject holder
  PublishSubject<EmploymentStatusUseCaseParams> _employmentDetailsRequest =
      PublishSubject();

  ///employment details response holder
  PublishSubject<Resource<bool>> _employmentDetailsResponse = PublishSubject();

  ///employment details stream
  Stream<Resource<bool>> get employmentDetailsStream =>
      _employmentDetailsResponse.stream;

  PublishSubject<bool> _animatedSubject = PublishSubject();

  Stream<bool> get animatedStream => _animatedSubject.stream;

  void updateAnimatedValue(bool value) {
    _animatedSubject.add(value);
  }

  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///error detector subject
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  ///error detector stream
  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  // bool isValid() {
  //   bool valid = false;
  //   if (employmentStatusKey.currentState!.isValid &&
  //       occupationKey.currentState!.isValid &&
  //       sourceKey.currentState!.isValid &&
  //       monthlyIncomeKey.currentState!.isValid &&
  //       annualIncomeKey.currentState!.isValid &&
  //       purposeOfAccountOpeningKey.currentState!.isValid &&
  //       employerNameKey.currentState!.isValid &&
  //       employerCountryKey.currentState!.isValid &&
  //       employerCityKey.currentState!.isValid &&
  //       employerContactKey.currentState!.isValid &&
  //       additionalSourceIncomeKey.currentState!.isValid &&
  //       totalAdditionalIncomeKey.currentState!.isValid) {
  //     valid = true;
  //   }
  //   _allFieldValidatorSubject.add(valid);
  //   return valid;
  // }

  bool isValid() {
    bool valid = false;
    if (employmentStatusController.text.isNotEmpty &&
        occupationController.text.isNotEmpty &&
        sourceController.text.isNotEmpty &&
        monthlyIncomeController.text.isNotEmpty &&
        annualIncomeController.text.isNotEmpty &&
        purposeOfAccountOpeningController.text.isNotEmpty &&
        employerNameController.text.isNotEmpty &&
        employerCountryController.text.isNotEmpty &&
        employerCityController.text.isNotEmpty &&
        employerContactController.text.isNotEmpty &&
        additionalSourceIncomeController.text.isNotEmpty &&
        totalAdditionalIncomeController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.add(valid);
    return valid;
  }

  EmploymentStatusPageViewModel(this._employmentDetailsUseCase) {
    _employmentDetailsRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _employmentDetailsUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _employmentDetailsResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }
  void validateEmploymentDetails() {
    _employmentDetailsRequest.add(EmploymentStatusUseCaseParams(
        additionalSourceIncome: additionalSourceIncomeController.text,
        annualIncome: annualIncomeController.text,
        employerCity: employerCityController.text,
        employerContact: employerContactController.text,
        employerCountry: employerCountryController.text,
        employerName: employerNameController.text,
        employmentStatus: employmentStatusController.text,
        mainSourceIncome: sourceController.text,
        monthlyIncome: monthlyIncomeController.text,
        occupation: occupationController.text,
        purposeOfAccountOpening: purposeOfAccountOpeningController.text,
        totalAdditionalIncome: totalAdditionalIncomeController.text));
  }

  void showErrorState() {
    _errorDetectorSubject.add(true);
    Future.delayed(Duration(milliseconds: 500), () {
      _errorDetectorSubject.add(false);
    });
  }
}
