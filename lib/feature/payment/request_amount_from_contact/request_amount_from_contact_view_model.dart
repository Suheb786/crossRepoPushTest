import 'package:domain/model/dashboard/get_dashboard_data/account.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/model/payment/get_account_by_alias_content_response.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/model/purpose/purpose.dart';
import 'package:domain/model/purpose/purpose_detail.dart';
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
  Account selectedAccount = Account();
  GetAccountByAliasUseCase _getAccountByAliasUseCase;

  BehaviorSubject<String> _purposeSubject = BehaviorSubject();

  Stream<String> get purposeStream => _purposeSubject.stream;

  BehaviorSubject<String> _purposeDetailSubject = BehaviorSubject();

  Stream<String> get purposeDetailStream => _purposeDetailSubject.stream;

  Beneficiary? beneficiary;

  PublishSubject<RequestAmountFromContactUseCaseParams> _requestFromContactRequest = PublishSubject();

  PublishSubject<Resource<RequestToPayContentResponse>> _requestFromContactResponse = PublishSubject();

  BehaviorSubject<GetAccountByAliasUseCaseParams> _getAccountByAliasRequest = BehaviorSubject();

  Purpose? purpose;

  PurposeDetail? purposeDetail;

  BehaviorSubject<Resource<GetAccountByAliasContentResponse>> _getAccountByAliasResponse = BehaviorSubject();

  Stream<Resource<GetAccountByAliasContentResponse>> get getAccountByAliasResponseStream =>
      _getAccountByAliasResponse.stream;

  GetAccountByAliasContentResponse? getAccountByAliasResult;

  Stream<Resource<RequestToPayContentResponse>> get requestFromContactResponseStream =>
      _requestFromContactResponse.stream;

  void updatePurposeDetail(PurposeDetail value) {
    purposeDetail = value;
    _purposeDetailSubject.safeAdd(value.labelEn!);
  }

  void updatePurpose(Purpose value) {
    purpose = value;
    _purposeSubject.safeAdd(value.labelEn!);
  }

  bool showBackButton = false;

  RequestAmountFromContactViewModel(
      this._requestAmountFromContactUseCase, this._getAccountByAliasUseCase, this.beneficiary) {
    _getAccountByAliasRequest.listen((value) {
      print("got beneficiary iban: ${beneficiary!.iban}");
      RequestManager(value, createCall: () => _getAccountByAliasUseCase.execute(params: value))
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
          getAccountByAliasResult = event.data!;
        }
      });
    });

    _requestFromContactRequest.listen((value) {
      RequestManager(value, createCall: () => _requestAmountFromContactUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _requestFromContactResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    getAccountByAlias();
  }

  setShowBackButton(bool needBackButton) {
    this.showBackButton = needBackButton;
  }

  void getAccountByAlias() {
    _getAccountByAliasRequest.safeAdd(GetAccountByAliasUseCaseParams(
      fromAccount: selectedAccount.accountNo,
        value: beneficiary?.identifier ?? '', currency: "JOD", beneficiaryId: beneficiary?.id ?? ''));
  }

  List<String> myList = [];
  String currentPinValue = '0';

  void changeValue(String value) {
    if (value == ".") {
      if (!currentPinValue.contains(value)) {
        myList.add(value);
        currentPinValue = myList.join("");
      }
    } else {
      if (myList.contains(".")) {
        if (myList.indexOf(".") > myList.length - 4) {
          myList.add(value);
        }
      } else {
        myList.add(value);
      }
      currentPinValue = myList.join("");
    }
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
      myList.removeAt(myList.length - 1);
      if (myList.isEmpty) {
        currentPinValue = "0";
      } else {
        currentPinValue = myList.join();
      }
    } else if (myList.isEmpty) {
      currentPinValue = "0";
    }
    print("got myList : $myList");
    notifyListeners();
  }

  void requestFromNewRecipient(BuildContext context) {
    _requestFromContactRequest.safeAdd(RequestAmountFromContactUseCaseParams(
        fromAccount: selectedAccount.accountNo,
        alias: beneficiary!.iban,
        addressCity: getAccountByAliasResult!.getAccountByAliasContent!.addressCity ?? "",
        addressCountry: getAccountByAliasResult!.getAccountByAliasContent!.addressCountry ?? "",
        dbtrSurname: getAccountByAliasResult!.getAccountByAliasContent!.surname ?? "",
        purpose: purpose == null
            ? (beneficiary!.purposeParent == null || beneficiary!.purposeParent!.isEmpty
                ? ''
                : beneficiary!.purposeParent)
            : purpose!.code!,
        purposeDetail: purposeDetail == null
            ? (beneficiary!.purpose == null || beneficiary!.purpose!.isEmpty ? '' : beneficiary!.purpose!)
            : purposeDetail!.strCode!,
        amount: double.parse(currentPinValue),
        dbtrBic: getAccountByAliasResult != null
            ? getAccountByAliasResult!.getAccountByAliasContent!.bic ?? ""
            : "",
        dbtrAcct: beneficiary!.accountNo ?? "",
        dbtrName: beneficiary!.fullName ?? "",
        type: beneficiary!.purposeType ?? "",
        limit: purposeDetail == null ? beneficiary!.limit : purposeDetail!.limit,
        detCustomerType: beneficiary!.detCustomerType ?? ""));
  }

  @override
  void dispose() {
    _purposeSubject.close();
    _purposeDetailSubject.close();
    super.dispose();
  }
}
