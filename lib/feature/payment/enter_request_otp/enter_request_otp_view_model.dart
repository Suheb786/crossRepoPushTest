import 'package:domain/usecase/payment/enter_request_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterRequestOtpViewModel extends BasePageViewModel {
  TextEditingController otpController = TextEditingController();
  EnterRequestOtpUseCase _useCase;

  PublishSubject<EnterRequestOtpUseCaseParams> _enterOtpRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpResponse = PublishSubject();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<Resource<bool>> get enterOtpResponseStream => _enterOtpResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    // notifyListeners();
  }

  EnterRequestOtpViewModel(this._useCase) {
    _enterOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void enterOtp() {
    _enterOtpRequest
        .safeAdd(EnterRequestOtpUseCaseParams(otpCode: _otpSubject.value));
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
    _enterOtpRequest.close();
    _showButtonSubject.close();
    _enterOtpResponse.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
