import 'package:domain/constants/error_types.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/model/bank_smart/customer_information.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/model/user/confirm_application_data_get/account_purpose_info.dart';
import 'package:domain/model/user/confirm_application_data_get/country_residence_info.dart';
import 'package:domain/model/user/confirm_application_data_get/fatca_crs_info.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_content.dart';
import 'package:domain/model/user/confirm_application_data_get/get_confirm_application_data_response.dart';
import 'package:domain/model/user/confirm_application_data_get/id_card_details_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/model/user/status/customer_status.dart';
import 'package:domain/usecase/account/check_videocall_status_usecase.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/bank_smart/remove_debit_lock_usecase.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';
import 'package:domain/usecase/user/check_customer_status_usecase.dart';
import 'package:domain/usecase/user/confirm_application_data_get_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:neo_bank/utils/time_utils.dart';
import 'package:rxdart/rxdart.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  final ReviewApplicationUseCase _reviewAppUseCase;
  final CheckVideoCallStatusUseCase _checkVideoCallStatusUseCase;
  final GetAccountUseCase _getAccountUseCase;
  final CreateAccountUseCase _createAccountUseCase;
  final CheckCustomerStatusUseCase _checkCustomerStatusUseCase;
  final ConfirmApplicationDataGetUseCase _applicationDataGetUseCase;
  final RemoveDebitLockUseCase _removeDebitLockUseCase;

  ScrollController scrollController = ScrollController();

  ///declaration selected  subject
  BehaviorSubject<bool> _declarationSelected = BehaviorSubject.seeded(false);

  ///declaration selected stream
  Stream<bool> get declarationSelectedStream => _declarationSelected.stream;

  ///update declaration selection function
  void updateDeclarationSelection(bool value) {
    _declarationSelected.add(value);
  }

  ///review request subject holder
  PublishSubject<ReviewApplicationUseCaseParams> _reviewAppRequest = PublishSubject();

  ///review response holder
  PublishSubject<Resource<bool>> _reviewAppResponse = PublishSubject();

  ///review stream
  Stream<Resource<bool>> get reviewAppStream => _reviewAppResponse.stream;

  ///check video call status subject holder
  PublishSubject<CheckVideoCallStatusUseCaseParams> _checkVideoCallRequest = PublishSubject();

  ///check video call status response holder
  PublishSubject<Resource<CheckVideoCallResponse>> _checkVideoCallResponse = PublishSubject();

  ///check video call status stream
  Stream<Resource<CheckVideoCallResponse>> get checkVideoCallStream => _checkVideoCallResponse.stream;

  ///get Account subject holder
  PublishSubject<GetAccountUseCaseParams> _getAccountRequest = PublishSubject();

  ///get Account response holder
  PublishSubject<Resource<GetAccountResponse>> _getAccountResponse = PublishSubject();

  ///get Account stream
  Stream<Resource<GetAccountResponse>> get getAccountStream => _getAccountResponse.stream;

  ///create Account subject holder
  PublishSubject<CreateAccountUseCaseParams> _createAccountRequest = PublishSubject();

  ///create Account response holder
  PublishSubject<Resource<CreateAccountResponse>> _createAccountResponse = PublishSubject();

  ///create Account stream
  Stream<Resource<CreateAccountResponse>> get createAccountStream => _createAccountResponse.stream;

  ///get confirm  Account data subject holder
  PublishSubject<ConfirmApplicationDataGetUseCaseParams> _getConfirmApplicationDataRequest = PublishSubject();

  ///get confirm  Account data response holder
  BehaviorSubject<Resource<GetConfirmApplicationDataResponse>> _getConfirmApplicationDataResponse =
      BehaviorSubject();

  ///get confirm  Account data stream
  Stream<Resource<GetConfirmApplicationDataResponse>> get getConfirmApplicationDataStream =>
      _getConfirmApplicationDataResponse.stream;

  ///User Status subject holder
  PublishSubject<CheckCustomerStatusUseCaseParams> _checkCustomerStatusRequest = PublishSubject();

  ///User Status response holder
  PublishSubject<Resource<CustomerStatus>> _checkCustomerStatusResponse = PublishSubject();

  ///User Status stream
  Stream<Resource<CustomerStatus>> get customerStatusStream => _checkCustomerStatusResponse.stream;

  ///remove debit lock
  PublishSubject<RemoveDebitLockUseCaseParams> _removeDebitLockRequest = PublishSubject();

  PublishSubject<Resource<bool>> _removeDebitLockResponse = PublishSubject();

  Stream<Resource<bool>> get removeDebitLockStream => _removeDebitLockResponse.stream;

  ProfileStatusInfo profileStatusInfo = ProfileStatusInfo();
  CountryResidenceInfo countryResidenceInfo = CountryResidenceInfo();
  JobDetailInfo jobDetailInfo = JobDetailInfo();
  AccountPurposeInfo accountPurposeInfo = AccountPurposeInfo();
  FatcaCrsInfo fatcaCrsInfo = FatcaCrsInfo();
  IdCardDetailsInfo idCardDetailsInfo = IdCardDetailsInfo();

  ReviewApplicationPageViewModel(
      this._reviewAppUseCase,
      this._checkVideoCallStatusUseCase,
      this._getAccountUseCase,
      this._createAccountUseCase,
      this._applicationDataGetUseCase,
      this._checkCustomerStatusUseCase,
      this._removeDebitLockUseCase) {
    _reviewAppRequest.listen((value) {
      RequestManager(value, createCall: () => _reviewAppUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _reviewAppResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _checkVideoCallRequest.listen((value) {
      RequestManager(value, createCall: () => _checkVideoCallStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkVideoCallResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _createAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _createAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getConfirmApplicationDataRequest.listen((value) {
      RequestManager(value, createCall: () => _applicationDataGetUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getConfirmApplicationDataResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _checkCustomerStatusRequest.listen((value) {
      RequestManager(value, createCall: () => _checkCustomerStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _checkCustomerStatusResponse.add(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _removeDebitLockRequest.listen((value) {
      RequestManager(value, createCall: () => _removeDebitLockUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _removeDebitLockResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getConfirmApplicationData();
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_DECLARATION_SELECTION:
        break;
      default:
        break;
    }
  }

  void validateReviewDetails() {
    _reviewAppRequest.safeAdd(ReviewApplicationUseCaseParams(
        declarationSelected: _declarationSelected.value,
        countryResidenceInfo: countryResidenceInfo,
        profileStatusInfo: profileStatusInfo,
        accountPurposeInfo: accountPurposeInfo,
        jobDetailInfo: jobDetailInfo,
        fatcaCrsInfo: fatcaCrsInfo));
  }

  void getCustomerStatus() {
    _checkCustomerStatusRequest.safeAdd(CheckCustomerStatusUseCaseParams());
  }

  void checkVideoCallStatus() {
    _checkVideoCallRequest.safeAdd(CheckVideoCallStatusUseCaseParams());
  }

  void getAccount() {
    _getAccountRequest.safeAdd(GetAccountUseCaseParams());
  }

  void getConfirmApplicationData() {
    _getConfirmApplicationDataRequest.safeAdd(ConfirmApplicationDataGetUseCaseParams());
  }

  void createAccount(CustomerAccountDetails accountDetails, CustomerInformation customerInformation) {
    _createAccountRequest.safeAdd(
        CreateAccountUseCaseParams(accountDetails: accountDetails, customerInformation: customerInformation));
  }

  ///controllers
  ///id card controllers
  TextEditingController idCardNameController = TextEditingController();
  TextEditingController idCardNationalIDController = TextEditingController();
  TextEditingController idCardDOBController = TextEditingController();
  TextEditingController idCardPlaceOfBirthController = TextEditingController();
  TextEditingController idCardGenderController = TextEditingController();
  TextEditingController idCardMotherNameController = TextEditingController();
  TextEditingController idCardLegalDocumentNoController = TextEditingController();
  TextEditingController idCardIssuingDateController = TextEditingController();
  TextEditingController idCardExpiryDateController = TextEditingController();
  TextEditingController idCardIssuingPlaceController = TextEditingController();

  ///Controllers for address
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNoController = TextEditingController();

  ///Controllers for permanent address
  TextEditingController residentPermanentCountryController = TextEditingController();
  TextEditingController residentPermanentCityController = TextEditingController();

  ///Controllers for personal details
  TextEditingController otherNationalityController = TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  TextEditingController specialNeedsPersonController = TextEditingController();
  TextEditingController employmentStatusController = TextEditingController();

  ///Controllers for job and income details
  TextEditingController businessTypeController = TextEditingController();
  TextEditingController businessTypeOtherController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController mainAnnualIncomeController = TextEditingController();
  TextEditingController employerNameController = TextEditingController();
  TextEditingController employerCountryController = TextEditingController();
  TextEditingController employerCityController = TextEditingController();
  TextEditingController employerContactController = TextEditingController();

  ///Controllers for purpose of account opening
  TextEditingController purposeOfAccountOpeningController = TextEditingController();
  TextEditingController expectedMonthlyTransactionsController = TextEditingController();
  TextEditingController expectedAnnualTransactionsController = TextEditingController();

  void updateTextFieldData(GetConfirmApplicationDataContent getConfirmApplicationDataContent) {
    countryResidenceInfo = getConfirmApplicationDataContent.countryResidenceInfo!;
    profileStatusInfo = getConfirmApplicationDataContent.profileStatusInfo!;
    jobDetailInfo = getConfirmApplicationDataContent.jobDetailInfo!;
    fatcaCrsInfo = getConfirmApplicationDataContent.fatcaCrsInfo!;
    accountPurposeInfo = getConfirmApplicationDataContent.accountPurposeInfo!;
    idCardDetailsInfo = getConfirmApplicationDataContent.idCardDetailsInfo!;

    ///id card
    idCardNameController.text = Intl.getCurrentLocale() == 'en'
        ? idCardDetailsInfo.fullNameEn ?? '-'
        : idCardDetailsInfo.fullNameAr ?? '-';

    idCardNationalIDController.text = idCardDetailsInfo.nationalID ?? '';

    idCardDOBController.text = (idCardDetailsInfo.dateOfBirth ?? '').isNotEmpty
        ? TimeUtils.getFormattedDOBIdwise(idCardDetailsInfo.dateOfBirth ?? '')
        : '';
    idCardPlaceOfBirthController.text = Intl.getCurrentLocale() == 'en'
        ? idCardDetailsInfo.placeOfBirthEn ?? '-'
        : idCardDetailsInfo.placeOfBirthAr ?? '-';
    idCardGenderController.text = idCardDetailsInfo.gender ?? '-';
    idCardLegalDocumentNoController.text = idCardDetailsInfo.documentNo ?? '-';
    idCardIssuingDateController.text = (idCardDetailsInfo.issuingDate ?? '').isNotEmpty
        ? TimeUtils.convertDateTimeToDate(idCardDetailsInfo.issuingDate ?? '')
        : '';
    idCardMotherNameController.text = Intl.getCurrentLocale() == 'en'
        ? idCardDetailsInfo.motherNameEn ?? '-'
        : idCardDetailsInfo.motherNameAr ?? '-';
    idCardIssuingPlaceController.text = Intl.getCurrentLocale() == 'en'
        ? idCardDetailsInfo.issuingPlace ?? '-'
        : idCardDetailsInfo.issuingPlace ?? '-';
    idCardExpiryDateController.text = (idCardDetailsInfo.expiryDate ?? '').isNotEmpty
        ? TimeUtils.convertDateTimeToDate(idCardDetailsInfo.expiryDate ?? '')
        : '-';

    ///address
    residentCountryController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.residentCountryName)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.residentCountryName!
            : ''
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.countryResidenceInfo!.residentCountryNameAr)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.residentCountryNameAr
            : '';
    streetAddressController.text =
        Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.streetName)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.streetName!
            : '';
    buildingNameOrNoController.text =
        Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.buildingName)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.buildingName!
            : '';
    districtController.text =
        Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.area)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.area!
            : '';
    cityController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.city)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.city!
            : ''
        : Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.cityAr)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.cityAr
            : '';

    ///permanent address
    residentPermanentCountryController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCountryName)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCountryName!
            : ''
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCountryNameAr)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCountryNameAr
            : '';
    residentPermanentCityController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCityName)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCityName!
            : ''
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCityNameAr)
            ? getConfirmApplicationDataContent.countryResidenceInfo!.perResidentCityNameAr
            : '';

    ///profile status
    spouseNameController.text =
        Validator.isNotEmptyNull(getConfirmApplicationDataContent.profileStatusInfo!.spauseName)
            ? getConfirmApplicationDataContent.profileStatusInfo!.spauseName!
            : '';
    specialNeedsPersonController.text =
        Validator.isNotEmptyNull(getConfirmApplicationDataContent.profileStatusInfo!.natureSp)
            ? getConfirmApplicationDataContent.profileStatusInfo!.natureSp!
            : '';
    employmentStatusController.text = Intl.getCurrentLocale() == 'en'
        ? getConfirmApplicationDataContent.profileStatusInfo!.employmentStatus!
        : getConfirmApplicationDataContent.profileStatusInfo?.employmentStatusAr! ?? '';

    ///job details
    occupationController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.occupation)
            ? (getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.occupation!)
            : (Validator.isNotEmptyNull(
                    getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.businessType)
                ? (getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.businessType!)
                : '')
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.occupation)
            ? (getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.occupation!)
            : (Validator.isNotEmptyNull(
                    getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.businessTypeAr)
                ? (getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.businessTypeAr)
                : '');
    mainAnnualIncomeController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.annualIncome)
        ? '${num.parse(getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.annualIncome!).toStringAsFixed(3)}'
        : '';
    employerNameController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employeeName)
        ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employeeName!
        : '';
    employerCountryController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCountry)
            ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCountry!
            : ''
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCountryAr)
            ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCountryAr
            : '';
    employerCityController.text = Intl.getCurrentLocale() == 'en'
        ? Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCity)
            ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCity!
            : ''
        : Validator.isNotEmptyNull(
                getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCityAr)
            ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerCityAr!
            : '';
    employerContactController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerContact)
        ? getConfirmApplicationDataContent.jobDetailInfo!.jobDetailContentInfo!.employerContact!
        : '';

    ///purpose of account opening
    purposeOfAccountOpeningController.text = Intl.getCurrentLocale() == 'en'
        ? getConfirmApplicationDataContent.accountPurposeInfo!.purpose!
        : getConfirmApplicationDataContent.accountPurposeInfo!.purposeAr!;
    expectedMonthlyTransactionsController.text =
        getConfirmApplicationDataContent.accountPurposeInfo!.monthlyTransaction!.toStringAsFixed(3);
    expectedAnnualTransactionsController.text =
        getConfirmApplicationDataContent.accountPurposeInfo!.anualTransaction!.toString();
  }

  ///remove debit lock
  void removeDebitLock() {
    _removeDebitLockRequest.safeAdd(RemoveDebitLockUseCaseParams());
  }

  @override
  void dispose() {
    _checkVideoCallRequest.close();
    _checkVideoCallResponse.close();
    _getAccountRequest.close();
    _getAccountResponse.close();
    _createAccountRequest.close();
    _createAccountResponse.close();
    _getConfirmApplicationDataRequest.close();
    _getConfirmApplicationDataResponse.close();
    _checkCustomerStatusRequest.close();
    _checkCustomerStatusResponse.close();
    _removeDebitLockRequest.close();
    _removeDebitLockResponse.close();
    super.dispose();
  }
}
