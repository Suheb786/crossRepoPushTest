import 'package:domain/constants/error_types.dart';
import 'package:domain/model/account/check_videocall_status_response.dart';
import 'package:domain/usecase/account/check_videocall_status_usecase.dart';
import 'package:domain/usecase/register/review_app_usecase.dart';
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
  PublishSubject<Resource<List<String>>> _reviewAppResponse = PublishSubject();

  ///review stream
  Stream<Resource<List<String>>> get reviewAppStream =>
      _reviewAppResponse.stream;

  ///check video call status subject holder
  PublishSubject<CheckVideoCallStatusUseCaseParams> _checkVideoCallRequest =
      PublishSubject();

  ///check video call status response holder
  PublishSubject<Resource<CheckVideoCallResponse>> _checkVideoCallResponse =
      PublishSubject();

  ///check video call status stream
  Stream<Resource<CheckVideoCallResponse>> get checkVideoCallStream =>
      _checkVideoCallResponse.stream;

  ReviewApplicationPageViewModel(
      this._reviewAppUseCase, this._checkVideoCallStatusUseCase) {
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
        }
      });
    });

    updateTextFieldData();
  }

  void getError(Resource<List<String>> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_DECLARATION_SELECTION:
        break;
    }
  }

  void validateReviewDetails() {
    _reviewAppRequest.safeAdd(ReviewApplicationUseCaseParams(
        declarationSelected: _declarationSelected.value));
  }

  void checkVideoCallStatus() {
    _checkVideoCallRequest.safeAdd(CheckVideoCallStatusUseCaseParams());
  }

  ///controllers

  ///Controllers for address
  TextEditingController residentCountryController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController buildingNameOrNoController = TextEditingController();

  ///Controllers for permanent address
  TextEditingController residentPermanentAddressCountryController =
      TextEditingController();
  TextEditingController residentPermanentAddressCityController =
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

  void updateTextFieldData() {
    residentCountryController.text = 'Jordan';
    homeAddressController.text = 'Queen Rania Al-Abdullah';
    streetAddressController.text = 'Sweilah';
    buildingNameOrNoController.text = 'W Amman';
    residentPermanentAddressCountryController.text = 'Bahrain';
    residentPermanentAddressCityController.text = 'Sweilah';
    spouseNameController.text = 'Ameena Rasheed';
    specialNeedsPersonController.text = 'Movement';
    employmentStatusController.text = 'Full-Time Employee';
    occupationController.text = 'Senior Executive';
    mainAnnualIncomeController.text = '60,000';
    employerNameController.text = 'Jordan Insurance Company';
    employerCountryController.text = 'Jordan';
    employerCityController.text = 'Amman';
    employerContactController.text = '+962 79 333 8080';
    purposeOfAccountOpeningController.text = 'Salary';
    expectedMonthlyTransactionsController.text = '12,000';
    expectedAnnualTransactionsController.text = '102,000';
  }

  @override
  void dispose() {
    _checkVideoCallRequest.close();
    _checkVideoCallResponse.close();
    super.dispose();
  }
}
