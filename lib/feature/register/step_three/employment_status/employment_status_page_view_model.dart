import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/employment_status_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EmploymentStatusPageViewModel extends BasePageViewModel {
  final EmploymentStatusUseCase _employmentDetailsUseCase;

  ///controllers and keys
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

  ///update employment status textfield value
  void updateEmploymentStatus(String value) {
    employmentStatusController.text = value;
  }

  ///update occupation  textfield value
  void updateOccupation(String value) {
    occupationController.text = value;
  }

  ///update purpose of account opening textfield value
  void updatePurposeOfAccountOpening(String value) {
    purposeOfAccountOpeningController.text = value;
  }

  ///update employer country textfield value
  void updateEmployerCountry(String value) {
    employerCountryController.text = value;
  }

  ///update additional income source textfield value
  void updateAdditionalIncome(String value) {
    additionalSourceIncomeController.text = value;
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

  ///all filed validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all filed validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

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
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_EMPLOYMENT_STATUS:
        employmentStatusKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_OCCUPATION:
        occupationKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_SOURCE_INCOME:
        sourceKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_MONTHLY_INCOME:
        monthlyIncomeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_ANNUAL_INCOME:
        annualIncomeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING:
        purposeOfAccountOpeningKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMPLOYER_NAME:
        employerNameKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMPLOYER_COUNTRY:
        employerCountryKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMPLOYER_CITY:
        employerCityKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EMPLOYER_CONTACT:
        employerContactKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_ADDITIONAL_SOURCE_INCOME:
        additionalSourceIncomeKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_TOTAL_ADDITIONAL_INCOME:
        totalAdditionalIncomeKey.currentState!.isValid = false;
        break;
      default:
        return;
    }
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

  @override
  void dispose() {
    _employmentDetailsRequest.close();
    _employmentDetailsResponse.close();
    _allFieldValidatorSubject.close();
    super.dispose();
  }
}
