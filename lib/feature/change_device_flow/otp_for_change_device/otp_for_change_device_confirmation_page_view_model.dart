import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:domain/usecase/device_change/resend_otp_device_change_usecase.dart';
import 'package:domain/usecase/device_change/verify_device_change_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class OtpForChangeDeviceConfirmationPageViewModel extends BasePageViewModel {
  final VerifyDeviceChangeOtpUseCase _verifyDeviceChangeOtpUseCase;
  final ResendOtpDeviceChangeUseCase _resendOtpDeviceChangeUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  TextEditingController otpController = TextEditingController();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///verify otp request subject holder
  PublishSubject<VerifyDeviceChangeOtpUseCaseParams> _verifyOtpRequest =
      PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream => _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///resend otp request subject holder
  PublishSubject<ResendOtpDeviceChangeUseCaseParams> _resendOtpRequest =
      PublishSubject();

  ///resend otp response holder
  PublishSubject<Resource<bool>> _resendOtpResponse = PublishSubject();

  ///resend otp stream
  Stream<Resource<bool>> get resendOtpStream => _resendOtpResponse.stream;

  OtpForChangeDeviceConfirmationPageViewModel(
      this._verifyDeviceChangeOtpUseCase, this._resendOtpDeviceChangeUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _verifyDeviceChangeOtpUseCase.execute(params: value))
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
      RequestManager(value,
              createCall: () =>
                  _resendOtpDeviceChangeUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _resendOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          initiateSmsListener();
        }
      });
    });
  }

  void validateOtp() {
    _verifyOtpRequest.safeAdd(VerifyDeviceChangeOtpUseCaseParams(
        otp: _otpSubject.value, firebaseToken: ''));
  }

  void resendOtp() {
    _resendOtpRequest.safeAdd(ResendOtpDeviceChangeUseCaseParams());
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  String _incomingSms = 'Message';

  Future<void> initiateSmsListener() async {
    String? incomingMsg = "Message";
    try {
      incomingMsg = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      incomingMsg = 'Failed to get Sms.';
    }

    ///SMS Sample: Your phone verification code is 625742.
    _incomingSms = incomingMsg!;
    print("====>Message<====: ${_incomingSms}");
    print(
        "${_incomingSms[32] + _incomingSms[33] + _incomingSms[34] + _incomingSms[35] + _incomingSms[36] + _incomingSms[37]}");
    otpController.text = _incomingSms[32] +
        _incomingSms[33] +
        _incomingSms[34] +
        _incomingSms[35] +
        _incomingSms[36] +
        _incomingSms[37];

    notifyListeners();
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
