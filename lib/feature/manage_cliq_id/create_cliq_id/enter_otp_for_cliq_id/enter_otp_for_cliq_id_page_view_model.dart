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
  final EnterOtpForCliqIdUseCase _enterOtpForCliqIdUseCase;

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

  /// otp request subject holder
  PublishSubject<EnterOtpForCliqIdUseCaseParams> _enterOtpForCliqIdRequest =
      PublishSubject();

  /// otp response holder
  PublishSubject<Resource<bool>> _enterOtpForCliqIdResponse = PublishSubject();

  /// otp stream
  Stream<Resource<bool>> get enterOtpForCliqIdStream =>
      _enterOtpForCliqIdResponse.stream;

  EnterOtpForCliqIdPageViewModel(this._enterOtpForCliqIdUseCase) {
    _enterOtpForCliqIdRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _enterOtpForCliqIdUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterOtpForCliqIdResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });
  }

  void validateOtp() {
    _enterOtpForCliqIdRequest
        .safeAdd(EnterOtpForCliqIdUseCaseParams(otp: _otpSubject.value));
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
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
