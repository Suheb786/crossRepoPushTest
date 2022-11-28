import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/usecase/account_setting/change_email_address/add_new_email_address_usecase.dart';
import 'package:domain/usecase/account_setting/change_email_address/validate_otp_for_new_email_address_usecase.dart';
import 'package:domain/usecase/infobip_audio/save_user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterCodeForChangeEmailAddressPageViewModel extends BasePageViewModel {
  final ValidateOtpForNewEmailAddressUseCase _validateOtpForNewEmailAddressUseCase;

  final AddNewEmailAddressUseCase _addNewEmailUseCase;

  final SaveUserUseCase _saveUserUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  TextEditingController otpController = TextEditingController();

  ///verify otp request subject holder
  PublishSubject<ValidateOtpForNewEmailAddressUseCaseParams> _verifyOtpRequest = PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<ProfileChangedSuccessResponse>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<ProfileChangedSuccessResponse>> get verifyOtpStream => _verifyOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///resend otp request subject holder
  PublishSubject<AddNewEmailAddressUseCaseParams> _resendOtpRequest = PublishSubject();

  ///resend otp response holder
  PublishSubject<Resource<bool>> _resendOtpResponse = PublishSubject();

  ///resend otp stream
  Stream<Resource<bool>> get resendOtpStream => _resendOtpResponse.stream;

  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _saveuserResponseSubject = PublishSubject();

  EnterCodeForChangeEmailAddressPageViewModel(
      this._validateOtpForNewEmailAddressUseCase, this._addNewEmailUseCase, this._saveUserUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _validateOtpForNewEmailAddressUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _resendOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _addNewEmailUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _resendOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });

    _saveUserRequestSubject.listen((value) {
      RequestManager(value, createCall: () {
        return _saveUserUseCase.execute(params: value);
      }).asFlow().listen((event) {
        _saveuserResponseSubject.safeAdd(event);
      });
    });
  }

  void validateOtp({required String email}) {
    _verifyOtpRequest
        .safeAdd(ValidateOtpForNewEmailAddressUseCaseParams(otp: _otpSubject.value, email: email));
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void resendOtp({required String email}) {
    _resendOtpRequest.safeAdd(AddNewEmailAddressUseCaseParams(email: email));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void saveUserData() {
    _saveUserRequestSubject.safeAdd(SaveUserUseCaseParams());
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
