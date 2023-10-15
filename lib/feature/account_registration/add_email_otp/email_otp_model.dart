import 'package:domain/usecase/user/resend_email_otp_usecase.dart';
import 'package:domain/usecase/user/verify_email_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../di/account_registration/account_registration_modules.dart';

class EmailOtpViewModel extends BasePageViewModel {
  final VerifyEmailOtpUseCase _verifyOtpUseCase;
  final ResendEmailOTPUseCase _resendOTPUseCase;

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  MobileNumberParams mobileNumberParams = MobileNumberParams();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  void resendOTP(BuildContext context) {
    resendOtp(context);
  }

  ///create password request subject holder
  PublishSubject<ResendEmailOTPUseCaseParams> _resendEmailOTPRequest = PublishSubject();

  /// create password response subject holder
  PublishSubject<Resource<bool>> _resendEmailOTPResponse = PublishSubject();

  Stream<Resource<bool>> get createPasswordStream => _resendEmailOTPResponse.stream;

  ///verify otp request subject holder
  PublishSubject<VerifyEmailOtpUseCaseParams> _verifyOtpRequest = PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<bool>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<bool>> get verifyOtpStream => _verifyOtpResponse.stream;

  ///error detector subject
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  ///error detector stream
  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EmailOtpViewModel(this._verifyOtpUseCase, this._resendOTPUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _verifyOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _resendEmailOTPRequest.listen((value) {
      RequestManager(value, createCall: () => _resendOTPUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _resendEmailOTPResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });
  }

  void validateOtp(BuildContext context) {
    String email =
        ProviderScope.containerOf(context).read(addEmailViewModelProvider).emailController.text.toString();
    _verifyOtpRequest.safeAdd(VerifyEmailOtpUseCaseParams(otp: _otpSubject.value, email: email));
  }

  void resendOtp(BuildContext context) {
    String email =
        ProviderScope.containerOf(context).read(addEmailViewModelProvider).emailController.text.toString();
    String password = ProviderScope.containerOf(context)
        .read(addEmailViewModelProvider)
        .createPasswordController
        .text
        .toString();

    _resendEmailOTPRequest.safeAdd(ResendEmailOTPUseCaseParams(
      emailAddress: email,
      password: password,
    ));
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
      _otpSubject.safeAdd(value);
    }
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 800), () {
      _errorDetectorSubject.safeAdd(false);
    });
  }

  listenForSmsCode() async {
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    _errorDetectorSubject.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
