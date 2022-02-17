import 'package:domain/constants/enum/employment_status_enum.dart';
import 'package:domain/constants/error_types.dart';
import 'package:domain/model/user/additional_income_type.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_data.dart';
import 'package:domain/model/user/get_combo_values/get_combo_values_response.dart';
import 'package:domain/model/user/save_job_details_response.dart';
import 'package:domain/usecase/register/job_and_income_usecase.dart';
import 'package:domain/usecase/user/get_combo_values_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class JobAndIncomePageViewModel extends BasePageViewModel {
  final JobAndIncomeUseCase _jobAndIncomeUseCase;

  final GetComboValuesUseCase _getComboValuesUseCase;

  ///controllers and keys
  final TextEditingController occupationController = TextEditingController();
  GlobalKey<AppTextFieldState> occupationKey =
      new GlobalKey(debugLabel: "occupation");

  final TextEditingController businessTypeController = TextEditingController();
  GlobalKey<AppTextFieldState> businessTypeKey =
      new GlobalKey(debugLabel: "businessType");

  final TextEditingController businessTypeOtherController =
      TextEditingController();
  GlobalKey<AppTextFieldState> businessTypeOtherKey =
      new GlobalKey(debugLabel: "businessTypeOther");

  final TextEditingController annualIncomeController = TextEditingController();
  GlobalKey<AppTextFieldState> annualIncomeKey =
      new GlobalKey(debugLabel: "annualIncome");

  final TextEditingController employerNameController = TextEditingController();
  GlobalKey<AppTextFieldState> employerNameKey =
      new GlobalKey(debugLabel: "employerName");

  final TextEditingController employerCountryController =
      TextEditingController();
  GlobalKey<AppTextFieldState> employerCountryKey =
      new GlobalKey(debugLabel: "employerCountry");

  final TextEditingController employerCityController = TextEditingController();
  GlobalKey<AppTextFieldState> employerCityKey =
      new GlobalKey(debugLabel: "employerCity");

  final TextEditingController employerContactController =
      TextEditingController();
  GlobalKey<AppTextFieldState> employerContactKey =
      new GlobalKey(debugLabel: "employerContact");

  ///update occupation  textfield value
  void updateOccupation(String value) {
    occupationController.text = value;
  }

  EmploymentStatusEnum employmentStatusEnum = EmploymentStatusEnum.OTHER;

  ///update employer country textfield value
  void updateEmployerCountry(String value) {
    employerCountryController.text = value;
  }

  /// business type other visibility Subject holder
  BehaviorSubject<bool> _businessTypeOtherVisibilitySubject =
      BehaviorSubject.seeded(false);

  Stream<bool> get businessTypeOtherVisibilityStream =>
      _businessTypeOtherVisibilitySubject.stream;

  void updateBusinessTypeOtherVisibility() {
    if (businessTypeController.text == 'Other') {
      _businessTypeOtherVisibilitySubject.safeAdd(true);
    } else {
      _businessTypeOtherVisibilitySubject.safeAdd(false);
    }
  }

  ///employment details request subject holder
  PublishSubject<JobAndIncomeUseCaseParams> _jobAndIncomeRequest =
      PublishSubject();

  ///employment details response holder
  PublishSubject<Resource<SaveJobDetailsResponse>> _jobAndIncomeResponse =
      PublishSubject();

  ///employment details stream
  Stream<Resource<SaveJobDetailsResponse>> get jobAndIncomeStream =>
      _jobAndIncomeResponse.stream;

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

  List<AdditionalIncomeType> additionalSourceIncome = [];

  List<GetComboValuesData> businessTypeList = [];

  ///additional income source list holder
  final BehaviorSubject<List<AdditionalIncomeType>>
      _additionalIncomeSourceSubject = BehaviorSubject.seeded([]);

  ///additional income source response stream
  Stream<List<AdditionalIncomeType>> get additionalSourceIncomeListStream =>
      _additionalIncomeSourceSubject.stream;

  ///get combo values request subject holder
  PublishSubject<GetComboValuesUseCaseParams> _getComboValuesRequest =
      PublishSubject();

  ///get combo values response holder
  PublishSubject<Resource<GetComboValuesResponse>> _getComboValuesResponse =
      PublishSubject();

  ///get combo values stream
  Stream<Resource<GetComboValuesResponse>> get getComboValuesStream =>
      _getComboValuesResponse.stream;

  bool isValid() {
    bool valid = false;
    if (employmentStatusEnum == EmploymentStatusEnum.BUSINESS_OWNER) {
      if (_businessTypeOtherVisibilitySubject.value) {
        if (businessTypeController.text.isNotEmpty &&
            businessTypeOtherController.text.isNotEmpty &&
            annualIncomeController.text.isNotEmpty &&
            employerNameController.text.isNotEmpty &&
            employerCountryController.text.isNotEmpty &&
            employerCityController.text.isNotEmpty &&
            employerContactController.text.isNotEmpty) {
          valid = true;
        }
      } else {
        if (businessTypeController.text.isNotEmpty &&
            annualIncomeController.text.isNotEmpty &&
            employerNameController.text.isNotEmpty &&
            employerCountryController.text.isNotEmpty &&
            employerCityController.text.isNotEmpty &&
            employerContactController.text.isNotEmpty) {
          valid = true;
        }
      }
    } else {
      if (occupationController.text.isNotEmpty &&
          annualIncomeController.text.isNotEmpty &&
          employerNameController.text.isNotEmpty &&
          employerCountryController.text.isNotEmpty &&
          employerCityController.text.isNotEmpty &&
          employerContactController.text.isNotEmpty) {
        valid = true;
      }
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  JobAndIncomePageViewModel(
      this._jobAndIncomeUseCase, this._getComboValuesUseCase) {
    _jobAndIncomeRequest.listen((value) {
      RequestManager(value,
              createCall: () => _jobAndIncomeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _jobAndIncomeResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _getComboValuesRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getComboValuesUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getComboValuesResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          businessTypeList = event.data!.getComboValuesContent!
              .getComboValuesContentData!.businessType!;
        }
      });
    });

    //getComboValues();
  }

  void getError(Resource<SaveJobDetailsResponse> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_OCCUPATION:
        occupationKey.currentState!.isValid = false;
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
      case ErrorType.INVALID_BUSINESS_TYPE:
        businessTypeKey.currentState!.isValid = false;
        break;
      case ErrorType.EMPTY_BUSINESS:
        businessTypeOtherKey.currentState!.isValid = false;
        break;
      default:
        break;
    }
  }

  ///add items to list
  void addAdditionalIncomeList(AdditionalIncomeType value) {
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
        occupation: occupationController.text,
        businessType: businessTypeController.text,
        businessTypeOther: _businessTypeOtherVisibilitySubject.value,
        employmentStatusEnum: employmentStatusEnum,
        specifyBusiness: businessTypeOtherController.text,
        isAdditionalIncome: _switchSubject.value,
        additionalIncomeList: additionalSourceIncome));
  }

  void getComboValues() {
    _getComboValuesRequest.safeAdd(GetComboValuesUseCaseParams());
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
