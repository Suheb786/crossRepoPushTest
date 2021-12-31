import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/usecase/payment/get_account_by_alias_usecase.dart';
import 'package:domain/usecase/payment/request_amount_from_contact_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class RequestAmountFromContactViewModel extends BasePageViewModel {
  RequestAmountFromContactUseCase _requestAmountFromContactUseCase;

  GetAccountByAliasUseCase _getAccountByAliasUseCase;

  BehaviorSubject<String> _purposeSubject = BehaviorSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  BehaviorSubject<String> _purposeDetailSubject = BehaviorSubject();

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  Beneficiary? beneficiary;

  PublishSubject<RequestAmountFromContactUseCaseParams>
  _requestFromContactRequest = PublishSubject();

  PublishSubject<Resource<RequestToPayContentResponse>>
  _requestFromContactResponse = PublishSubject();

  BehaviorSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest =
  BehaviorSubject();

  BehaviorSubject<
      Resource<GetAccountByAliasContentResponse>> _getAccountByAliasResponse =
  BehaviorSubject();

  Stream<Resource<GetAccountByAliasContentResponse>>
  get getAccountByAliasResponseStream => _getAccountByAliasResponse.stream;

  Stream<Resource<RequestToPayContentResponse>>
  get requestFromContactResponseStream =>
      _requestFromContactResponse.stream;

  void updatePurposeDetail(String value) {
    _purposeDetailSubject.safeAdd(value);
  }

  void updatePurpose(String value) {
    _purposeSubject.safeAdd(value);
  }

  RequestAmountFromContactViewModel(this._requestAmountFromContactUseCase,
      this._getAccountByAliasUseCase, this.beneficiary) {
    _getAccountByAliasRequest.listen((value) {
      print("got beneficiary iban: ${beneficiary!.iban}");
      RequestManager(value,
          createCall: () =>
              _getAccountByAliasUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountByAliasResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          print("got error type: ${event.appError!.type}");
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          print("got bic: ${event.data!.getAccountByAliasContent!.bic}");
        }
      });
    });

    _requestFromContactRequest.listen((value) {
      RequestManager(value,
          createCall: () =>
              _requestAmountFromContactUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _requestFromContactResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getAccountByAlias();
  }

  void getAccountByAlias() {
    _getAccountByAliasRequest.safeAdd(GetAccountByAliasUseCaseParams(
        value: beneficiary!.iban, currency: "JOD"));
  }

  List<String> myList = [];
  String currentPinValue = '0';

  void changeValue(String value) {
    myList.add(value);
    currentPinValue = myList.join("");
    notifyListeners();
  }

  void updateValue() {
    currentPinValue = currentPinValue.substring(0, currentPinValue.length - 1);
    myList.clear();
    if (currentPinValue.length < 1) {
      currentPinValue = '0';
    }
    notifyListeners();
  }

  void clearValue() {
    if (myList.isNotEmpty) {
      myList.clear();
      currentPinValue = "0";
    }
    notifyListeners();
  }

  void requestFromNewRecipient(BuildContext context) {
    _requestFromContactRequest.safeAdd(RequestAmountFromContactUseCaseParams(
      purpose: _purposeSubject.value,
      purposeDetail: _purposeDetailSubject.value,
      amount: int.parse(currentPinValue),
      dbtrBic: beneficiary!.iban ?? "",
      dbtrAcct: beneficiary!.accountNo ?? "",
      dbtrName: beneficiary!.fullName ?? "",
    ));
  }

  @override
  void dispose() {
    _purposeSubject.close();
    _purposeDetailSubject.close();
    super.dispose();
  }
}
