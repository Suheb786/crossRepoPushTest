import 'package:domain/usecase/dc_change_linked_mobile_number/dc_enter_otp_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class DcEnterOtpViewModel extends BasePageViewModel {
  DcEnterOtpUseCase _dcEnterOtpUseCase;
  TextEditingController otpController = TextEditingController();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///resend otp
  PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  PublishSubject<DcEnterOtpUseCaseParams> _dcEnterOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _dcEnterOtpResponse = PublishSubject();

  Stream<Resource<bool>> get dcEnterOtpStream => _dcEnterOtpResponse.stream;

  DcEnterOtpViewModel(this._dcEnterOtpUseCase) {
    _dcEnterOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _dcEnterOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _dcEnterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterOtp() {
    _dcEnterOtpRequest
        .safeAdd(DcEnterOtpUseCaseParams(otpCode: _otpSubject.value));
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
    _otpSubject.close();
    _showButtonSubject.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
