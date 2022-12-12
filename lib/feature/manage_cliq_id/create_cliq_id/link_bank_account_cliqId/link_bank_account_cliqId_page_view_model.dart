import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/link_bank_account_cliq_id_validate_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class LinkBankAccountCliqIdPageViewModel extends BasePageViewModel {
  final LinkBankAccountCliqIdValidationUseCase _linkBankAccountCliqIdValidationUseCase;
  final CreateCliqIdOtpUseCase _createCliqIdOtpUseCase;

  LinkBankAccountCliqIdPageViewModel(
      this._linkBankAccountCliqIdValidationUseCase, this._createCliqIdOtpUseCase) {
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

    /// api calling for otp
    _createCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _createCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void updateLinkAccount(String data) {
    linkBankAccountCliqIdList.add(data);
    _linkBankAccountCliqIdListRequest.safeAdd(linkBankAccountCliqIdList);
  }

  void termAndConditionSelected(bool value) {
    _isSelectedRequest.safeAdd(value);
  }

  void validate() {
    _linkBankAccountCliqIdValidationRequest.safeAdd(LinkBankAccountCliqIdValidationUseCaseParams(
        isSelected: _isSelectedRequest.value, listOfString: linkBankAccountCliqIdList));
  }

  void makeOtpRequest(
      {required bool getToken,
      required String aliasValue,
      required bool isAlias,
      required String accountNumber}) {
    _createCliqIdOtpRequest.safeAdd(CreateCliqIdOtpParams(
        getToken: getToken, aliasValue: aliasValue, isAlias: isAlias, accountNumber: accountNumber));
  }

  @override
  void dispose() {
    _createCliqIdOtpRequest.close();
    _createCliqIdOtpResponse.close();
    _linkBankAccountCliqIdValidationRequest.close();
    _linkBankAccountCliqIdValidationResponse.close();
    _linkBankAccountCliqIdListRequest.close();
    _isSelectedRequest.close();
    super.dispose();
  }

  ///-----------------------------------------variables------------------------------------

  final ScrollController controller = ScrollController();

  String mobileNumber = '';

  List<String> linkBankAccountCliqIdList = [];

  ///---------for otp subject-----------------------------------

  PublishSubject<CreateCliqIdOtpParams> _createCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<CreateCliqOtp>> _createCliqIdOtpResponse = PublishSubject();

  Stream<Resource<CreateCliqOtp>> get createCliqIdOtpStream => _createCliqIdOtpResponse.stream;

  ///-----------for validation subject
  PublishSubject<LinkBankAccountCliqIdValidationUseCaseParams> _linkBankAccountCliqIdValidationRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _linkBankAccountCliqIdValidationResponse = PublishSubject();

  Stream<Resource<bool>> get linkBankAccountCliqIdValidationStream =>
      _linkBankAccountCliqIdValidationResponse.stream;

  PublishSubject<List<String>> _linkBankAccountCliqIdListRequest = PublishSubject();

  Stream<List<String>> get linkBankAccountCliqIdListStream => _linkBankAccountCliqIdListRequest.stream;

  /// terms and conditions
  BehaviorSubject<bool> _isSelectedRequest = BehaviorSubject.seeded(false);

  Stream<bool> get isSelectedStream => _isSelectedRequest.stream;
}
