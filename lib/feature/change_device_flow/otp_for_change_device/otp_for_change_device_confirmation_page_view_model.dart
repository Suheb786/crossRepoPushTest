import 'package:domain/usecase/device_change/resend_otp_device_change_usecase.dart';
import 'package:domain/usecase/device_change/verify_device_change_otp_usecase.dart';
import 'package:domain/usecase/infobip_audio/depersonalize_user_usecase.dart';
import 'package:domain/usecase/infobip_audio/save_user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpForChangeDeviceConfirmationPageViewModel extends BasePageViewModel {
  final VerifyDeviceChangeOtpUseCase _verifyDeviceChangeOtpUseCase;
  final ResendOtpDeviceChangeUseCase _resendOtpDeviceChangeUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  final DepersonalizeUserUseCase _depersonalizeUserUseCase;
  final SaveUserUseCase _saveUserUseCase;

  TextEditingController otpController = TextEditingController();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///verify otp request subject holder
  PublishSubject<VerifyDeviceChangeOtpUseCaseParams> _verifyOtpRequest = PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream => _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///resend otp request subject holder
  PublishSubject<ResendOtpDeviceChangeUseCaseParams> _resendOtpRequest = PublishSubject();

  ///resend otp response holder
  PublishSubject<Resource<bool>> _resendOtpResponse = PublishSubject();

  ///resend otp stream
  Stream<Resource<bool>> get resendOtpStream => _resendOtpResponse.stream;

  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject = PublishSubject();
  PublishSubject<DepersonalizeUserUseCaseParams> _depersonalizeUserRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _saveuserResponseSubject = PublishSubject();
  PublishSubject<Resource<bool>> _depersonalizeUserResponseSubject = PublishSubject();

  OtpForChangeDeviceConfirmationPageViewModel(
    this._verifyDeviceChangeOtpUseCase,
    this._resendOtpDeviceChangeUseCase,
    this._depersonalizeUserUseCase,
    this._saveUserUseCase,
  ) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _verifyDeviceChangeOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _resendOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _resendOtpDeviceChangeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _resendOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          listenForSmsCode();
        }
      });
    });

    _depersonalizeUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _depersonalizeUserUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _depersonalizeUserResponseSubject.safeAdd(event);
      });
    });

    _saveUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _saveuserResponseSubject.safeAdd(event);
      });
    });
  }

  void validateOtp() {
    _verifyOtpRequest.safeAdd(VerifyDeviceChangeOtpUseCaseParams(otp: _otpSubject.value, firebaseToken: ''));
  }

  void resendOtp() {
    _resendOtpRequest.safeAdd(ResendOtpDeviceChangeUseCaseParams());
  }

  void saveUserData() {
    _saveUserRequestSubject.safeAdd(SaveUserUseCaseParams());
  }

  void depersonalizeUserData() {
    _depersonalizeUserRequestSubject.safeAdd(DepersonalizeUserUseCaseParams());
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
