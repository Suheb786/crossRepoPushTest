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
import 'package:domain/model/user/confirm_application_data_get/job_detail_content_info.dart';
import 'package:domain/model/user/confirm_application_data_get/job_detail_info.dart';
import 'package:domain/model/user/confirm_application_data_get/profile_status_info.dart';
import 'package:domain/usecase/account/check_videocall_status_usecase.dart';
import 'package:domain/usecase/bank_smart/create_account_usecase.dart';
import 'package:domain/usecase/bank_smart/get_account_usecase.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';
import 'package:domain/usecase/user/confirm_application_data_get_usecase.dart';
import 'package:domain/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ReviewApplicationPageViewModel extends BasePageViewModel {
  final ReviewApplicationUseCase _reviewAppUseCase;
  final CheckVideoCallStatusUseCase _checkVideoCallStatusUseCase;
  final GetAccountUseCase _getAccountUseCase;
  final CreateAccountUseCase _createAccountUseCase;

  final ConfirmApplicationDataGetUseCase _applicationDataGetUseCase;

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
  PublishSubject<ReviewApplicationUseCaseParams> _reviewAppRequest =
      PublishSubject();

  ///review response holder
  PublishSubject<Resource<bool>> _reviewAppResponse = PublishSubject();

  ///review stream
  Stream<Resource<bool>> get reviewAppStream => _reviewAppResponse.stream;

  ///check video call status subject holder
  PublishSubject<CheckVideoCallStatusUseCaseParams> _checkVideoCallRequest =
      PublishSubject();

  ///check video call status response holder
  PublishSubject<Resource<CheckVideoCallResponse>> _checkVideoCallResponse =
      PublishSubject();

  ///check video call status stream
  Stream<Resource<CheckVideoCallResponse>> get checkVideoCallStream =>
      _checkVideoCallResponse.stream;

  ///get Account subject holder
  PublishSubject<GetAccountUseCaseParams> _getAccountRequest = PublishSubject();

  ///get Account response holder
  PublishSubject<Resource<GetAccountResponse>> _getAccountResponse =
      PublishSubject();

  ///get Account stream
  Stream<Resource<GetAccountResponse>> get getAccountStream =>
      _getAccountResponse.stream;

  ///create Account subject holder
  PublishSubject<CreateAccountUseCaseParams> _createAccountRequest =
      PublishSubject();

  ///create Account response holder
  PublishSubject<Resource<CreateAccountResponse>> _createAccountResponse =
      PublishSubject();

  ///create Account stream
  Stream<Resource<CreateAccountResponse>> get createAccountStream =>
      _createAccountResponse.stream;

  ///get confirm  Account data subject holder
  PublishSubject<ConfirmApplicationDataGetUseCaseParams>
      _getConfirmApplicationDataRequest = PublishSubject();

  ///get confirm  Account data response holder
  PublishSubject<Resource<GetConfirmApplicationDataResponse>>
      _getConfirmApplicationDataResponse = PublishSubject();

  ///get confirm  Account data stream
  Stream<Resource<GetConfirmApplicationDataResponse>>
      get getConfirmApplicationDataStream =>
          _getConfirmApplicationDataResponse.stream;

  ProfileStatusInfo profileStatusInfo = ProfileStatusInfo();
  CountryResidenceInfo countryResidenceInfo = CountryResidenceInfo();
  JobDetailInfo jobDetailInfo = JobDetailInfo();
  AccountPurposeInfo accountPurposeInfo = AccountPurposeInfo();
  FatcaCrsInfo fatcaCrsInfo = FatcaCrsInfo();

  ReviewApplicationPageViewModel(
      this._reviewAppUseCase,
      this._checkVideoCallStatusUseCase,
      this._getAccountUseCase,
      this._createAccountUseCase,
      this._applicationDataGetUseCase) {
    _reviewAppRequest.listen((value) {
      RequestManager(value,
              createCall: () => _reviewAppUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _reviewAppResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });

    _checkVideoCallRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _checkVideoCallStatusUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _checkVideoCallResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _createAccountRequest.listen((value) {
      RequestManager(value,
              createCall: () => _createAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createAccountResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getConfirmApplicationDataRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _applicationDataGetUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _getConfirmApplicationDataResponse.add(event);
        if (event.status == Status.ERROR) {
          showErrorState();
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
    }
  }

  void validateReviewDetails() {
    _reviewAppRequest.safeAdd(ReviewApplicationUseCaseParams(
        declarationSelected: _declarationSelected.value,
        countryResidenceInfo: CountryResidenceInfo(
            userId: countryResidenceInfo.userId,
            residantCountry: residentCountryController.text,
            buildingName: buildingNameOrNoController.text,
            streetName: streetAddressController.text,
            area: districtController.text,
            city: cityController.text,
            perResidantCountry: residentPermanentCountryController.text,
            perCity: residentPermanentCityController.text,
            isActive: countryResidenceInfo.isActive,
            createdOn: countryResidenceInfo.createdOn,
            id: countryResidenceInfo.id),
        profileStatusInfo: ProfileStatusInfo(
            id: profileStatusInfo.id,
            createdOn: profileStatusInfo.createdOn,
            isActive: profileStatusInfo.isActive,
            userId: profileStatusInfo.userId,
            employmentStatus: employmentStatusController.text,
            specialPerson: profileStatusInfo.specialPerson,
            married: profileStatusInfo.married,
            natureSp: specialNeedsPersonController.text,
            spauseName: spouseNameController.text),
        accountPurposeInfo: AccountPurposeInfo(
            userId: accountPurposeInfo.userId,
            isActive: accountPurposeInfo.isActive,
            createdOn: accountPurposeInfo.createdOn,
            id: accountPurposeInfo.id,
            isOther: accountPurposeInfo.isOther,
            isBillPayment: accountPurposeInfo.isBillPayment,
            isTransfer: accountPurposeInfo.isTransfer,
            isCashDeposit: accountPurposeInfo.isCashDeposit,
            monthlyTransaction:
                double.parse(expectedMonthlyTransactionsController.text),
            anualTransaction:
                double.parse(expectedAnnualTransactionsController.text),
            purpose: purposeOfAccountOpeningController.text),
        jobDetailInfo: JobDetailInfo(
            additionalIncomeInfo: jobDetailInfo.additionalIncomeInfo,
            jobDetailContentInfo: JobDetailContentInfo(
                id: jobDetailInfo.jobDetailContentInfo!.id,
                createdOn: jobDetailInfo.jobDetailContentInfo!.createdOn,
                isActive: jobDetailInfo.jobDetailContentInfo!.isActive,
                userId: jobDetailInfo.jobDetailContentInfo!.userId,

                ///change to occupation
                profession: occupationController.text,
                mainSource: jobDetailInfo.jobDetailContentInfo!.mainSource,
                employeeName: employerNameController.text,
                employerCountry: employerCountryController.text,
                employerCity: employerCityController.text,
                employerContact: employerContactController.text,
                additionalIncome:
                    jobDetailInfo.jobDetailContentInfo!.additionalIncome,
                annualIncome: mainAnnualIncomeController.text)),
        fatcaCrsInfo: fatcaCrsInfo));
  }

  void checkVideoCallStatus() {
    _checkVideoCallRequest.safeAdd(CheckVideoCallStatusUseCaseParams());
  }

  void getAccount() {
    _getAccountRequest.safeAdd(GetAccountUseCaseParams());
  }

  void getConfirmApplicationData() {
    _getConfirmApplicationDataRequest
        .safeAdd(ConfirmApplicationDataGetUseCaseParams());
  }

  void createAccount(CustomerAccountDetails accountDetails,
      CustomerInformation customerInformation) {
    _createAccountRequest.safeAdd(CreateAccountUseCaseParams(
        accountDetails: accountDetails,
        customerInformation: customerInformation));
  }

  ///controllers

  ///Controllers for address
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNoController = TextEditingController();

  ///Controllers for permanent address
  TextEditingController residentPermanentCountryController =
      TextEditingController();
  TextEditingController residentPermanentCityController =
      TextEditingController();

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
  TextEditingController purposeOfAccountOpeningController =
      TextEditingController();
  TextEditingController expectedMonthlyTransactionsController =
      TextEditingController();
  TextEditingController expectedAnnualTransactionsController =
      TextEditingController();

  // void updateTextFieldData() {
  //   residentCountryController.text = 'Jordan';
  //   homeAddressController.text = 'Queen Rania Al-Abdullah';
  //   streetAddressController.text = 'Sweilah';
  //   buildingNameOrNoController.text = 'W Amman';
  //   residentPermanentAddressCountryController.text = 'Bahrain';
  //   residentPermanentAddressCityController.text = 'Sweilah';
  //   spouseNameController.text = 'Ameena Rasheed';
  //   specialNeedsPersonController.text = 'Movement';
  //   employmentStatusController.text = 'Full-Time Employee';
  //   occupationController.text = 'Senior Executive';
  //   mainAnnualIncomeController.text = '60,000';
  //   employerNameController.text = 'Jordan Insurance Company';
  //   employerCountryController.text = 'Jordan';
  //   employerCityController.text = 'Amman';
  //   employerContactController.text = '+962 79 333 8080';
  //   purposeOfAccountOpeningController.text = 'Salary';
  //   expectedMonthlyTransactionsController.text = '12,000';
  //   expectedAnnualTransactionsController.text = '102,000';
  // }

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
    super.dispose();
  }

  void updateTextFieldData(
      GetConfirmApplicationDataContent getConfirmApplicationDataContent) {
    countryResidenceInfo =
        getConfirmApplicationDataContent.countryResidenceInfo!;
    profileStatusInfo = getConfirmApplicationDataContent.profileStatusInfo!;
    jobDetailInfo = getConfirmApplicationDataContent.jobDetailInfo!;
    fatcaCrsInfo = getConfirmApplicationDataContent.fatcaCrsInfo!;
    accountPurposeInfo = getConfirmApplicationDataContent.accountPurposeInfo!;

    ///address
    residentCountryController.text =
        getConfirmApplicationDataContent.countryResidenceInfo!.residantCountry!;
    streetAddressController.text =
        getConfirmApplicationDataContent.countryResidenceInfo!.streetName!;
    buildingNameOrNoController.text =
        getConfirmApplicationDataContent.countryResidenceInfo!.buildingName!;
    districtController.text =
        getConfirmApplicationDataContent.countryResidenceInfo!.area!;
    cityController.text =
        getConfirmApplicationDataContent.countryResidenceInfo!.city!;

    ///permanent address
    residentPermanentCountryController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .countryResidenceInfo!.perResidantCountry!)
        ? getConfirmApplicationDataContent
            .countryResidenceInfo!.perResidantCountry!
        : '';
    residentPermanentCityController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.countryResidenceInfo!.perCity!)
        ? getConfirmApplicationDataContent.countryResidenceInfo!.perCity!
        : '';

    ///profile status
    spouseNameController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.profileStatusInfo!.spauseName!)
        ? getConfirmApplicationDataContent.profileStatusInfo!.spauseName!
        : '';
    specialNeedsPersonController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent.profileStatusInfo!.natureSp!)
        ? getConfirmApplicationDataContent.profileStatusInfo!.natureSp!
        : '';
    employmentStatusController.text =
        getConfirmApplicationDataContent.profileStatusInfo!.employmentStatus!;

    ///job details
    occupationController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.profession!)
        ? (getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.profession!)
        : '';
    mainAnnualIncomeController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.annualIncome!)
        ? getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.annualIncome!
        : '';
    employerNameController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.employeeName!)
        ? getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.employeeName!
        : '';
    employerCountryController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.employerCountry!)
        ? getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.employerCountry!
        : '';
    employerCityController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.employerCity!)
        ? getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.employerCity!
        : '';
    employerContactController.text = Validator.isNotEmptyNull(
            getConfirmApplicationDataContent
                .jobDetailInfo!.jobDetailContentInfo!.employerContact!)
        ? getConfirmApplicationDataContent
            .jobDetailInfo!.jobDetailContentInfo!.employerContact!
        : '';

    ///purpose of account opening
    purposeOfAccountOpeningController.text =
        getConfirmApplicationDataContent.accountPurposeInfo!.purpose!;
    expectedMonthlyTransactionsController.text =
        getConfirmApplicationDataContent.accountPurposeInfo!.monthlyTransaction!
            .toString();
    expectedAnnualTransactionsController.text = getConfirmApplicationDataContent
        .accountPurposeInfo!.anualTransaction!
        .toString();

    print(
        'value---->${getConfirmApplicationDataContent.fatcaCrsInfo!.response5 == "true"}');
  }
}
