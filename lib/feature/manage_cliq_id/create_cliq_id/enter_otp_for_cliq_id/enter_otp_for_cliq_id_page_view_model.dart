import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/model/cliq/create_cliq_id/create_cliq_id_otp.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_otp_usecase.dart';
import 'package:domain/usecase/manage_cliq/create_cliq_id_usecase.dart';
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

class EnterOtpForCliqIdPageViewModel extends BasePageViewModel {
  final EnterOtpForCliqIdValidationUseCase _enterOtpForCliqIdValidationUseCase;
  final ConfirmCreateCliqIdUseCase _createCliqIdUseCase;
  final CreateCliqIdOtpUseCase _createCliqIdOtpUseCase;

  EnterOtpForCliqIdPageViewModel(
      this._enterOtpForCliqIdValidationUseCase, this._createCliqIdUseCase, this._createCliqIdOtpUseCase) {
    ///validation request
    _enterOtpForCliqIdValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _enterOtpForCliqIdValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterOtpForCliqIdValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });

    /// api calling for create cliq id
    _createCliqIdRequest.listen((value) {
      RequestManager(value, createCall: () => _createCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _createCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    /// api calling for otp on resend otp btn click
    _createCliqIdOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _createCliqIdOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _createCliqIdOtpResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });
  }

  /// validation for otp enter

  void validateOtp() {
    _enterOtpForCliqIdValidationRequest
        .safeAdd(EnterOtpForCliqIdValidationUseCaseParams(otp: _otpSubject.value));
  }

  /// validation for user i/p and showing btn

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

  /// api call
  void makeCreateCliqIDRequest(
      {required String accountNumber,
      required bool isAlias,
      required String aliasValue,
      required String otpCode,
      required bool getToken}) {
    _createCliqIdRequest.safeAdd(ConfirmCreateCliqIdParams(
        accountNumber: accountNumber,
        isAlias: isAlias,
        aliasValue: aliasValue,
        otpCode: otpCode,
        getToken: getToken));
  }

  /// api call
  void makeOtpRequest(
      {required bool getToken,
      required String aliasValue,
      required bool isAlias,
      required String accountNumber}) {
    otpController.clear();
    _createCliqIdOtpRequest.safeAdd(CreateCliqIdOtpParams(
        getToken: getToken, aliasValue: aliasValue, isAlias: isAlias, accountNumber: accountNumber));
  }

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _createCliqIdOtpRequest.close();
    _createCliqIdOtpResponse.close();
    _createCliqIdRequest.close();
    _createCliqIdResponse.close();
    _enterOtpForCliqIdValidationRequest.close();
    _enterOtpForCliqIdValidationResponse.close();

    _otpSubject.close();
    super.dispose();
  }

  ///--------------------------------variables----------------------------------------------

  PublishSubject<CreateCliqIdOtpParams> _createCliqIdOtpRequest = PublishSubject();

  PublishSubject<Resource<CreateCliqOtp>> _createCliqIdOtpResponse = PublishSubject();

  Stream<Resource<CreateCliqOtp>> get createCliqIdOtpStream => _createCliqIdOtpResponse.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  TextEditingController otpController = TextEditingController();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  /// otp request subject holder  for validation
  PublishSubject<EnterOtpForCliqIdValidationUseCaseParams> _enterOtpForCliqIdValidationRequest =
      PublishSubject();

  /// otp response holder for validation
  PublishSubject<Resource<bool>> _enterOtpForCliqIdValidationResponse = PublishSubject();

  /// otp stream for validation
  Stream<Resource<bool>> get enterOtpForCliqIdValidationStream => _enterOtpForCliqIdValidationResponse.stream;

  //*----------------Create Cliq Id--------------///

  PublishSubject<ConfirmCreateCliqIdParams> _createCliqIdRequest = PublishSubject();
  PublishSubject<Resource<ConfirmCreateCliqId>> _createCliqIdResponse = PublishSubject();

  Stream<Resource<ConfirmCreateCliqId>> get createCliqIdStream => _createCliqIdResponse.stream;
}
