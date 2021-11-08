import 'package:domain/constants/error_types.dart';
import 'package:domain/model/register/expected_Transactionss.dart';
import 'package:domain/usecase/register/purpose_of_account_opening_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PurposeOfAccountOpeningPageViewModel extends BasePageViewModel {
  final PurposeOfAccountOpeningUseCase _purposeOfAccountOpeningUseCase;

  ///controllers and keys
  final TextEditingController purposeOfAccountOpeningController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> purposeOfAccountOpeningKey =
      GlobalKey(debugLabel: "purposeOfAccountOpening");

  final TextEditingController transactionTypeController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> transactionTypeKey =
      GlobalKey(debugLabel: "transactionType");

  final TextEditingController expectedAnnualTransactionController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> expectedAnnualTransactionKey =
      GlobalKey(debugLabel: "expectedAnnualTransaction");

  final TextEditingController expectedMonthlyTransactionController =
      TextEditingController();
  final GlobalKey<AppTextFieldState> expectedMonthlyTransactionKey =
      GlobalKey(debugLabel: "expectedMonthlyTransaction");

  ///update purpose of account opening  textfield value
  void updatePurposeOfAccountOpening(String value) {
    purposeOfAccountOpeningController.text = value;
  }

  ///purpose of account opening request subject holder
  PublishSubject<PurposeOfAccountOpeningUseCaseParams>
      _purposeOfAccountOpeningRequest = PublishSubject();

  ///purpose of account opening response holder
  PublishSubject<Resource<bool>> _purposeOfAccountOpeningResponse =
      PublishSubject();

  ///purpose of account opening stream
  Stream<Resource<bool>> get purposeOfAccountOpeningStream =>
      _purposeOfAccountOpeningResponse.stream;

  ///all field validate subject
  PublishSubject<bool> _allFieldValidatorSubject = PublishSubject();

  ///all field validate stream
  Stream<bool> get allFieldValidatorStream => _allFieldValidatorSubject.stream;

  bool isValid() {
    bool valid = false;
    if (purposeOfAccountOpeningController.text.isNotEmpty &&
        expectedAnnualTransactionController.text.isNotEmpty &&
        expectedMonthlyTransactionController.text.isNotEmpty) {
      valid = true;
    }
    _allFieldValidatorSubject.safeAdd(valid);
    return valid;
  }

  List<ExpectedTransactions> expectedTransactionsList = [
    ExpectedTransactions(type: 'Cash Deposit'),
    ExpectedTransactions(type: 'Transfers'),
    ExpectedTransactions(type: 'Bill Payments'),
    ExpectedTransactions(type: 'Others')
  ];

  ///get expected Transactions response holder
  BehaviorSubject<Resource<List<ExpectedTransactions>>>
      _getExpectedTransactionsResponse = BehaviorSubject();

  ///get expected Transactions stream
  Stream<Resource<List<ExpectedTransactions>>>
      get getExpectedTransactionsStream =>
          _getExpectedTransactionsResponse.stream;

  void selectExpectedTransactions(int index) {
    List<ExpectedTransactions>? expectedTransactionsList =
        _getExpectedTransactionsResponse.value.data;
    expectedTransactionsList?.elementAt(index).isSelected =
        !(expectedTransactionsList.elementAt(index).isSelected);
    _getExpectedTransactionsResponse
        .safeAdd(Resource.success(data: expectedTransactionsList));
  }

  PurposeOfAccountOpeningPageViewModel(this._purposeOfAccountOpeningUseCase) {
    _purposeOfAccountOpeningRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _purposeOfAccountOpeningUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _purposeOfAccountOpeningResponse.add(event);
        if (event.status == Status.ERROR) {
          getError(event);
          showErrorState();
        }
      });
    });
    _getExpectedTransactionsResponse
        .safeAdd(Resource.success(data: expectedTransactionsList));
  }

  void getError(Resource<bool> event) {
    switch (event.appError!.type) {
      case ErrorType.INVALID_PURPOSE_OF_ACCOUNT_OPENING:
        purposeOfAccountOpeningKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXPECTED_ANNUAL_TRANSACTION:
        expectedAnnualTransactionKey.currentState!.isValid = false;
        break;
      case ErrorType.INVALID_EXPECTED_MONTHLY_TRANSACTION:
        expectedMonthlyTransactionKey.currentState!.isValid = false;
        break;
    }
  }

  void validatePurposeOfAccountOpening() {
    _purposeOfAccountOpeningRequest
        .safeAdd(PurposeOfAccountOpeningUseCaseParams(
      purposeOfAccountOpening: purposeOfAccountOpeningController.text,
      expectedAnnualTransaction: expectedAnnualTransactionController.text,
      expectedMonthlyTransaction: expectedMonthlyTransactionController.text,
    ));
  }

  @override
  void dispose() {
    _purposeOfAccountOpeningRequest.close();
    _purposeOfAccountOpeningResponse.close();
    _allFieldValidatorSubject.close();
    _getExpectedTransactionsResponse.close();
    super.dispose();
  }
}
