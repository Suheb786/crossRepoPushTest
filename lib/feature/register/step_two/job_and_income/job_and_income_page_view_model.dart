import 'package:domain/constants/error_types.dart';
import 'package:domain/usecase/register/job_and_income_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/dialog/register/step_three/additional_income_source/additional_income_source_dialog.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class JobAndIncomePageViewModel extends BasePageViewModel {
  final JobAndIncomeUseCase _jobAndIncomeUseCase;

  ///controllers and keys
  final TextEditingController occupationController = TextEditingController();
  final GlobalKey<AppTextFieldState> occupationKey =
      GlobalKey(debugLabel: "occupation");

  final TextEditingController sourceController = TextEditingController();
  final GlobalKey<AppTextFieldState> sourceKey =
      GlobalKey(debugLabel: "source");

  final TextEditingController annualIncomeController = TextEditingController();
  final GlobalKey<AppTextFieldState> annualIncomeKey =
      GlobalKey(debugLabel: "annualIncome");

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

  ///update occupation  textfield value
  void updateOccupation(String value) {
    occupationController.text = value;
  }

  ///update employer country textfield value
  void updateEmployerCountry(String value) {
    employerCountryController.text = value;
  }

  ///employment details request subject holder
  PublishSubject<JobAndIncomeUseCaseParams> _jobAndIncomeRequest =
      PublishSubject();

  ///employment details response holder
  PublishSubject<Resource<bool>> _jobAndIncomeResponse = PublishSubject();

  ///employment details stream
  Stream<Resource<bool>> get jobAndIncomeStream => _jobAndIncomeResponse.stream;

  ///all filed validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all filed validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  ///cupertino switch value subject
  final BehaviorSubject<bool> _switchSubject = BehaviorSubject.seeded(false);

  Stream<bool> get switchValue => _switchSubject.stream;

  void updateSwitchValue(bool value) {
    _switchSubject.safeAdd(value);
  }

  List<AdditionalIncomeSourceParams> additionalSourceIncome = [];

  ///additional income source list holder
  final BehaviorSubject<List<AdditionalIncomeSourceParams>>
      _additionalIncomeSourceSubject = BehaviorSubject.seeded([]);

  ///additional income source response stream
  Stream<List<AdditionalIncomeSourceParams>>
      get additionalSourceIncomeListStream =>
          _additionalIncomeSourceSubject.stream;

  bool isValid() {
    bool valid = false;
    if (occupationController.text.isNotEmpty &&
        sourceController.text.isNotEmpty &&
        annualIncomeController.text.isNotEmpty &&
        employerNameController.text.isNotEmpty &&
        employerCountryController.text.isNotEmpty &&
        employerCityController.text.isNotEmpty &&
        employerContactController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  JobAndIncomePageViewModel(this._jobAndIncomeUseCase) {
    _jobAndIncomeRequest.listen((value) {
      RequestManager(value,
              createCall: () => _jobAndIncomeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _jobAndIncomeResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_OCCUPATION:
        occupationKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_SOURCE_INCOME:
        sourceKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_ANNUAL_INCOME:
        annualIncomeKey.currentState!.isValid = false;
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
    }
  }

  ///add items to list
  void addAdditionalIncomeList(AdditionalIncomeSourceParams value) {
    additionalSourceIncome.add(value);
    _additionalIncomeSourceSubject.safeAdd(additionalSourceIncome);
  }

  ///remove item from list
  void removeAdditionalItem(int index) {
    additionalSourceIncome.removeAt(index);
    _additionalIncomeSourceSubject.safeAdd(additionalSourceIncome);
  }

  void validateJobAndIncomeDetails() {
    _jobAndIncomeRequest.safeAdd(JobAndIncomeUseCaseParams(
      annualIncome: annualIncomeController.text,
      employerCity: employerCityController.text,
      employerContact: employerContactController.text,
      employerCountry: employerCountryController.text,
      employerName: employerNameController.text,
      mainSourceIncome: sourceController.text,
      occupation: occupationController.text,
    ));
  }

  @override
  void dispose() {
    _jobAndIncomeRequest.close();
    _jobAndIncomeResponse.close();
    _allFieldValidatorSubject.close();
    _additionalIncomeSourceSubject.close();
    super.dispose();
  }
}
