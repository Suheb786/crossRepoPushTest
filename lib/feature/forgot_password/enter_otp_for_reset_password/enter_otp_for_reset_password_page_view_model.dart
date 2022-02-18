import 'package:domain/model/forget_password/verify_forget_password_otp_response.dart';
import 'package:domain/usecase/forgot_password/enter_otp_for_reset_password_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/forgot_password/forgot_password_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterOTPForResetPasswordPageViewModel extends BasePageViewModel {
  final EnterOtpForResetPasswordUseCase _enterOtpForResetPasswordUsecase;

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  ///verify otp request subject holder
  PublishSubject<EnterOtpForResetPasswordUseCaseParams> _verifyOtpRequest =
      PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<VerifyForgetPasswordOtpResponse>> _verifyOtpResponse =
      PublishSubject();

  ///verify otp stream
  Stream<Resource<VerifyForgetPasswordOtpResponse>> get verifyOtpStream =>
      _verifyOtpResponse.stream;

  ///error detector subject
  BehaviorSubject<bool> _errorDetectorSubject = BehaviorSubject.seeded(false);

  ///error detector stream
  Stream<bool> get errorDetectorStream => _errorDetectorSubject.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterOTPForResetPasswordPageViewModel(this._enterOtpForResetPasswordUsecase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _enterOtpForResetPasswordUsecase.execute(params: value))
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

  void validateOtp(BuildContext context) {
    _verifyOtpRequest.safeAdd(EnterOtpForResetPasswordUseCaseParams(
        otp: _otpSubject.value,
        email: ProviderScope.containerOf(context)
            .read(forgotPasswordViewModelProvider)
            .email,
        idExpiry: ProviderScope.containerOf(context)
            .read(forgotPasswordViewModelProvider)
            .expiryDate,
        idNo: ProviderScope.containerOf(context)
            .read(forgotPasswordViewModelProvider)
            .nationalId,
        password: ProviderScope.containerOf(context)
            .read(createNewPasswordViewModelProvider)
            .createPasswordController
            .text,
        confirmPassword: ProviderScope.containerOf(context)
            .read(createNewPasswordViewModelProvider)
            .confirmPasswordController
            .text));
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void showErrorState() {
    _errorDetectorSubject.safeAdd(true);
    Future.delayed(Duration(milliseconds: 800), () {
      _errorDetectorSubject.safeAdd(false);
    });
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
