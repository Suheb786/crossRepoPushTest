import 'package:domain/usecase/activity/activity_otp_validation_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RejectRequestPaymentOtpPageViewModel extends BasePageViewModel {
  final ActivityOtpValidationUseCase _activityOtpValidationUseCase;

  RejectRequestPaymentOtpPageViewModel(this._activityOtpValidationUseCase) {
    ///OTP validation request
    _otpValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _activityOtpValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _otpValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///validation otp request

  void validateOtp() {
    _otpValidationRequest.safeAdd(ActivityOtpValidationUseCaseParams(otp: _otpSubject.value));
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

  ///------------------------------------------variable--------------------------------------

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///========================================== otp request validation==============================///
  PublishSubject<ActivityOtpValidationUseCaseParams> _otpValidationRequest = PublishSubject();

  PublishSubject<Resource<bool>> _otpValidationResponse = PublishSubject();

  Stream<Resource<bool>> get otpValidationStream => _otpValidationResponse.stream;

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    _otpValidationRequest.close();
    _otpValidationResponse.close();

    super.dispose();
  }
}
