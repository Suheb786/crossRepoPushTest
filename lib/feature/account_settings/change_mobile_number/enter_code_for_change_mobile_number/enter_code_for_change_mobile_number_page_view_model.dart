import 'package:domain/model/profile_settings/profile_changed_success_response.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/add_new_mobile_number_usecase.dart';
import 'package:domain/usecase/account_setting/change_mobile_number/validate_otp_for_new_mobile_number_usecase.dart';
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

class EnterCodeForChangeMobileNumberPageViewModel extends BasePageViewModel {
  final ValidateOtpForNewMobileNumberUseCase _validateOtpForNewMobileNumberUseCase;

  final AddNewMobileNumberUseCase _resendOtpUseCase;

  final SaveUserUseCase _saveUserUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  TextEditingController otpController = TextEditingController();

  PublishSubject<SaveUserUseCaseParams> _saveUserRequestSubject = PublishSubject();

  PublishSubject<Resource<bool>> _saveuserResponseSubject = PublishSubject();

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///verify otp request subject holder
  PublishSubject<ValidateOtpForNewMobileNumberUseCaseParams> _verifyOtpRequest = PublishSubject();

  ///verify otp response holder
  PublishSubject<Resource<ProfileChangedSuccessResponse>> _verifyOtpResponse = PublishSubject();

  ///verify otp stream
  Stream<Resource<ProfileChangedSuccessResponse>> get verifyOtpStream => _verifyOtpResponse.stream;

  ///resend otp request subject holder
  PublishSubject<AddNewMobileNumberUseCaseParams> _resendOtpRequest = PublishSubject();

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterCodeForChangeMobileNumberPageViewModel(
      this._validateOtpForNewMobileNumberUseCase, this._resendOtpUseCase, this._saveUserUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _validateOtpForNewMobileNumberUseCase.execute(params: value))
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
      RequestManager(value, createCall: () => _resendOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
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

  void validateOtp({required String mobile, required String mobileCode}) {
    _verifyOtpRequest.safeAdd(ValidateOtpForNewMobileNumberUseCaseParams(
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

  void changeOtp({required String mobileCode, required String mobileNo}) {
    _resendOtpRequest
        .safeAdd(AddNewMobileNumberUseCaseParams(mobileCode: '00$mobileCode', mobileNumber: mobileNo));
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
