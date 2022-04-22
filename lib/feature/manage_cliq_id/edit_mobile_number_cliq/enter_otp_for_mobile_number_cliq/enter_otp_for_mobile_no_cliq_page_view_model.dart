import 'package:domain/usecase/manage_cliq/enter_otp_for_mobile_number_cliq_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpForMobileNumberCliqPageViewModel extends BasePageViewModel {
  final EnterOtpForMobileNumberCliqUseCase _enterOtpForMobileNumberCliqUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///verify otp request subject holder
  PublishSubject<EnterOtpForMobileNumberCliqUseCaseParams> _verifyOtpRequest =
      PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse =
      PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream =>
      _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterOtpForMobileNumberCliqPageViewModel(
      this._enterOtpForMobileNumberCliqUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _enterOtpForMobileNumberCliqUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateOtp({required String mobile, required String mobileCode}) {
    _verifyOtpRequest.safeAdd(EnterOtpForMobileNumberCliqUseCaseParams(
        otp: _otpSubject.value, mobileNo: mobile, mobileCode: '00$mobileCode'));
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
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
