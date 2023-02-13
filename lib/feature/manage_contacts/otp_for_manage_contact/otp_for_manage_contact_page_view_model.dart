import 'package:domain/usecase/manage_contacts/manage_contact_otp_validation_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpForManageContactPageViewModel extends BasePageViewModel {
  final ManageContactOtpValidationUseCase _manageContactOtpValidationUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  TextEditingController otpController = TextEditingController();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///for Otp Validation
  PublishSubject<ManageContactOtpValidationUseCaseParams> _validatedOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _validatedOtpResponse = PublishSubject();

  Stream<Resource<bool>> get validatedOtpStream => _validatedOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  OtpForManageContactPageViewModel(this._manageContactOtpValidationUseCase) {
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

  void validateOtp() {
    _validatedOtpRequest.safeAdd(ManageContactOtpValidationUseCaseParams(otp: _otpSubject.value));
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
    _validatedOtpRequest.close();
    _validatedOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
