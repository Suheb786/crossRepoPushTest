import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/usecase/manage_cliq/add_link_account_usecase.dart';
import 'package:domain/usecase/manage_cliq/get_account_by_customerID_usecase.dart';
import 'package:domain/usecase/manage_cliq/link_bank_account_cliq_id_validate_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import 'link_account_page.dart';

class LinkAccountPageViewModel extends BasePageViewModel {
  final LinkBankAccountCliqIdValidationUseCase _linkBankAccountCliqIdValidationUseCase;
  final LinkAccountPageArgument argument;
  final AddLInkAccountUseCase _addLInkAccountUseCase;

  final GetAccountByCustomerIDUseCase _getAccountByCustomerIDUseCase;

  LinkAccountPageViewModel(this._linkBankAccountCliqIdValidationUseCase, this._getAccountByCustomerIDUseCase,
      this._addLInkAccountUseCase, this.argument) {
    ///validation request
    _linkBankAccountCliqIdValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _linkBankAccountCliqIdValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _linkBankAccountCliqIdValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _getAccountByCustomerIdRequest.listen((value) {
      RequestManager(value, createCall: () => _getAccountByCustomerIDUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getAccountByCustomerIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _linkCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _addLInkAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _linkCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void updateLinkAccount(GetAccountByCustomerId data) {
    linkBankAccountCliqIdList.add(data);
    _linkBankAccountCliqIdListRequest.safeAdd(linkBankAccountCliqIdList);
    showBtn();
  }

  void termAndConditionSelected(bool value) {
    _isSelectedRequest.safeAdd(value);
    _showButtonSubject.safeAdd(value);
    showBtn();
  }

  void validate() {
    _linkBankAccountCliqIdValidationRequest.safeAdd(LinkBankAccountCliqIdValidationUseCaseParams(
        isSelected: _isSelectedRequest.value, listOfCustomerAccount: linkBankAccountCliqIdList));
  }

  void showBtn() {
    if (linkBankAccountCliqIdList.isNotEmpty) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _linkBankAccountCliqIdValidationRequest.close();
    _linkBankAccountCliqIdValidationResponse.close();
    _linkBankAccountCliqIdListRequest.close();
    _isSelectedRequest.close();
    super.dispose();
  }

  ///-----------------------------------------variables------------------------------------

  final ScrollController controller = ScrollController();

  List<GetAccountByCustomerId> linkBankAccountCliqIdList = [];

  ///-----------for validation subject
  PublishSubject<LinkBankAccountCliqIdValidationUseCaseParams> _linkBankAccountCliqIdValidationRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _linkBankAccountCliqIdValidationResponse = PublishSubject();

  Stream<Resource<bool>> get linkBankAccountCliqIdValidationStream =>
      _linkBankAccountCliqIdValidationResponse.stream;

  PublishSubject<List<GetAccountByCustomerId>> _linkBankAccountCliqIdListRequest = PublishSubject();

  Stream<List<GetAccountByCustomerId>> get linkBankAccountCliqIdListStream =>
      _linkBankAccountCliqIdListRequest.stream;

  /// terms and conditions
  BehaviorSubject<bool> _isSelectedRequest = BehaviorSubject.seeded(false);

  Stream<bool> get isSelectedStream => _isSelectedRequest.stream;

  /// hide and show btn request and stream

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///-------------------Get Account By Customer ID----------------///

  PublishSubject<GetAccountByCustomerIDUseCaseParams> _getAccountByCustomerIdRequest = PublishSubject();

  PublishSubject<Resource<List<GetAccountByCustomerId>>> _getAccountByCustomerIdResponse = PublishSubject();

  Stream<Resource<List<GetAccountByCustomerId>>> get getAccountByCustomerIdStream =>
      _getAccountByCustomerIdResponse.stream;

  void getAccountByCustomerId() {
    _getAccountByCustomerIdRequest.safeAdd(GetAccountByCustomerIDUseCaseParams());
  }

  PublishSubject<AddLinkAccountUseCaseParams> _linkCliqIdRequest = PublishSubject();

  PublishSubject<Resource<bool>> _linkCliqIdResponse = PublishSubject();

  Stream<Resource<bool>> get linkCliqIdStream => _linkCliqIdResponse.stream;

  String accountNumber = '';

  void linkCliqId({
    required bool getToken,
    required String aliasId,
    required String linkType,
    required String accountNumber,
    required bool isAlias,
    required String aliasValue,
  }) {
    _linkCliqIdRequest.safeAdd(AddLinkAccountUseCaseParams(
        linkType: linkType,
        getToken: getToken,
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasId: aliasId,
        aliasValue: aliasValue));
  }
}
