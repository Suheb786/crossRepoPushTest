import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id.dart';
import 'package:domain/model/cliq/edit_cliq_id/edit_cliq_id_otp.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/edit_cliq_id_usecase.dart';
import 'package:domain/usecase/manage_cliq/enter_otp_for_cliq_id_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'otp_for_edit_alias_mobile_no_page.dart';

class OtpForEditAliasAndMobileNoPageViewModel extends BasePageViewModel {
  final EnterOtpForCliqIdValidationUseCase _enterOtpForCliqIdValidationUseCase;
  final EditCliqIdUseCase _editCliqIdUseCase;
  final EditCliqOtpUseCase _editCliqOtpUseCase;
  final OtpForEditAliasAndMobileNoPageArguments arguments;

  OtpForEditAliasAndMobileNoPageViewModel(this._enterOtpForCliqIdValidationUseCase, this._editCliqIdUseCase,
      this.arguments, this._editCliqOtpUseCase) {
    ///validation request
    _enterOtpForCliqIdValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _enterOtpForCliqIdValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterOtpForCliqIdValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });

    ///editCliqId api request
    _editCliqIdRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => _editCliqIdUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _editCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    ///api calling for otp
    _editCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _editCliqOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _editCliqIdOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 20;
    notifyListeners();
    listenForSmsCode();
  }

  void makeEditCliqIdRequest(
      {required bool getToken,
      required String aliasId,
      required bool isAlias,
      required String aliasValue,
      required String otpCode}) {
    _editCliqIdRequest.safeAdd(EditCliqIdUseCaseParams(
        isAlias: isAlias, aliasValue: aliasValue, aliasId: aliasId, getToken: getToken, OtpCode: otpCode));
  }

  void makeOtpRequest(
      {required String aliasId,
      required String aliasValue,
      required bool isAlias,
      required String accountNumber}) {
    _editCliqIdOtpRequest
        .safeAdd(EditCliqOtpUseCaseParams(aliasId: aliasId, isAlias: isAlias, aliasValue: aliasValue));
  }

  ///validation otp request

  void validateOtp() {
    _enterOtpForCliqIdValidationRequest
        .safeAdd(EnterOtpForCliqIdValidationUseCaseParams(otp: _otpSubject.value));
  }

  /// validation for i/p and btn
  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _otpSubject.safeAdd(value);
      _showButtonSubject.safeAdd(false);
    }
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    _editCliqIdRequest.close();
    _editCliqIdResponse.close();
    super.dispose();
  }

  ///------------------------------------------variable--------------------------------------
  //edit cliq id request

  PublishSubject<EditCliqIdUseCaseParams> _editCliqIdRequest = PublishSubject();
  PublishSubject<Resource<EditCliq>> _editCliqIdResponse = PublishSubject();

  Stream<Resource<EditCliq>> get editCliqIdStream => _editCliqIdResponse.stream;

  ///otp request

  PublishSubject<EditCliqOtpUseCaseParams> _editCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<EditCliqOtp>> _editCliqIdOtpResponse = PublishSubject();

  Stream<Resource<EditCliqOtp>> get createCliqIdOtpStream => _editCliqIdOtpResponse.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  /// otp request validation
  PublishSubject<EnterOtpForCliqIdValidationUseCaseParams> _enterOtpForCliqIdValidationRequest =
      PublishSubject();

  /// otp response
  PublishSubject<Resource<bool>> _enterOtpForCliqIdValidationResponse = PublishSubject();

  /// otp stream
  Stream<Resource<bool>> get enterOtpForCliqIdValidationStream => _enterOtpForCliqIdValidationResponse.stream;
}
