import 'package:domain/usecase/manage_contacts/edit_contact_IBAN_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EditUserContactotpViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///
  final EditContactOTPuseCase _manageContactOtpValidationUseCase;
  late CountdownTimerController countDownController;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///---------------------------controller----------------------------///

  TextEditingController otpController = TextEditingController();

  ///-----------------------otp-validation---------------------------///

  PublishSubject<EditContactOTPuseCaseParams> _validatedOtpRequest = PublishSubject();
  PublishSubject<Resource<bool>> _validatedOtpResponse = PublishSubject();
  Stream<Resource<bool>> get validatedOtpStream => _validatedOtpResponse.stream;

  ///-----------------------animated-button-subject---------------------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///--------------------------public-override-methods-------------------------------------///

  @override
  void dispose() {
    _validatedOtpRequest.close();
    _validatedOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }

  ///--------------------------public-other-methods-------------------------------------///
  void validateOtp() {
    _validatedOtpRequest.safeAdd(EditContactOTPuseCaseParams(otp: _otpSubject.value));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void validate(String value) {
    _otpSubject.safeAdd(value);

    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  ///--------------------------public-constructor-------------------------------------///

  EditUserContactotpViewModel(this._manageContactOtpValidationUseCase) {
    _validatedOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _manageContactOtpValidationUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _validatedOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
  }
}
