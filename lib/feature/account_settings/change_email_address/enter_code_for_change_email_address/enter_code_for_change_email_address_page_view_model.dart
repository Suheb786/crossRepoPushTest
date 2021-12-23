import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/usecase/account_setting/change_email_address/validate_otp_for_new_email_address_usecase.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterCodeForChangeEmailAddressPageViewModel extends BasePageViewModel {
  final ValidateOtpForNewEmailAddressUseCase
  _validateOtpForNewEmailAddressUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime
      .now()
      .millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime
        .now()
        .millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  ///verify otp request subject holder
  PublishSubject<ValidateOtpForNewEmailAddressUseCaseParams> _verifyOtpRequest =
  PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<ProfileChangedSuccessResponse>> _verifyOtpResponse =
      PublishSubject();

  ///verify otp stream
  Stream<Resource<ProfileChangedSuccessResponse>> get verifyOtpStream =>
      _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterCodeForChangeEmailAddressPageViewModel(
      this._validateOtpForNewEmailAddressUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
          createCall: () =>
              _validateOtpForNewEmailAddressUseCase.execute(params: value))
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

  void validateOtp() {
    _verifyOtpRequest.safeAdd(
        ValidateOtpForNewEmailAddressUseCaseParams(otp: _otpSubject.value));
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
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
