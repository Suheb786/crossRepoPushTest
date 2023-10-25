import 'package:domain/model/user/user.dart';
import 'package:domain/usecase/account/send_mobile_otp_usecase.dart';
import 'package:domain/usecase/account/verify_mobile_otp_usecase.dart';
import 'package:domain/usecase/user/change_my_number_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/register_prospect_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/account_registration/account_registration_modules.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ValidateOtpViewModel extends BasePageViewModel {
  final VerifyOtpUseCase _verifyOtpUseCase;
  final OnboardingVerifyMobileOtpUsecase _onboardingVerifyMobileOtpUsecase;
  final GetTokenUseCase _getTokenUseCase;
  final SendMobileOTPUsecase _sendMobileOTPUsecase;
  final RegisterProspectUseCase _registerProspectUseCase;

  final ChangeMyNumberUseCase _changeMyNumberUseCase;

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  MobileNumberParams mobileNumberParams = MobileNumberParams();

  // ///timer subject holder
  // BehaviorSubject<int> _timerRequest = BehaviorSubject.seeded(
  //     DateTime.now().millisecondsSinceEpoch + 1000 * 120);
  //
  // ///timer response holder
  // Stream<int> get timerStream => _timerRequest.stream;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTimer() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  void resendOTP(BuildContext context) {
    otpController.clear();
    sendMobileOtp(context);
  }

  ///verify otp request subject holder
  PublishSubject<VerifyOtpUseCaseParams> _verifyOtpRequest = PublishSubject();

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

  ///resend otp
  PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  PublishSubject<Resource<bool>> _getTokenResponse = PublishSubject();

  Stream<Resource<bool>> get getTokenStream => _getTokenResponse.stream;

  ///change my number request subject holder
  PublishSubject<ChangeMyNumberUseCaseParams> _changeMyNumberRequest = PublishSubject();

  ///change my number response holder
  PublishSubject<Resource<bool>> _changeMyNumberResponse = PublishSubject();

  ///change my number stream
  Stream<Resource<bool>> get changeMyNumberStream => _changeMyNumberResponse.stream;

  ///-------send Mobile Otp--------->
  PublishSubject<SendMobileOTPUsecaseParams> _sendMobileOTPRequest = PublishSubject();

  PublishSubject<Resource<bool>> _sendMobileOTPResponse = PublishSubject();

  Stream<Resource<bool>> get sendMobileOTPResponseStream => _sendMobileOTPResponse.stream;

  ///-------verify Mobile Otp--------->
  PublishSubject<OnboardingVerifyMobileOtpUsecaseParams> _verifyMobileOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _verifyMobileOtpResponse = PublishSubject();

  Stream<Resource<bool>> get verifyMobileOtpResponseStream => _verifyMobileOtpResponse.stream;

  ///Register user request subject holder
  PublishSubject<RegisterProspectUseCaseParams> _registerUserRequest = PublishSubject();

  /// Register user response subject holder
  PublishSubject<Resource<User>> _registerUserResponse = PublishSubject();

  Stream<Resource<User>> get registerUserStream => _registerUserResponse.stream;

  ValidateOtpViewModel(this._verifyOtpUseCase, this._getTokenUseCase, this._changeMyNumberUseCase,
      this._sendMobileOTPUsecase, this._onboardingVerifyMobileOtpUsecase, this._registerProspectUseCase) {
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

    _getTokenRequest.listen((value) {
      RequestManager(value, createCall: () => _getTokenUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getTokenResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          listenForSmsCode();
        }
      });
    });

    _changeMyNumberRequest.listen((value) {
      RequestManager(value, createCall: () => _changeMyNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeMyNumberResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
    _registerUserRequest.listen((value) {
      RequestManager(value, createCall: () => _registerProspectUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _registerUserResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _sendMobileOTPRequest.listen((value) {
      RequestManager(value, createCall: () => _sendMobileOTPUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _sendMobileOTPResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTimer();
          listenForSmsCode();
        }
      });
    });
    _verifyMobileOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _onboardingVerifyMobileOtpUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _verifyMobileOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void validateOtp() {
    _verifyOtpRequest.safeAdd(VerifyOtpUseCaseParams(otp: _otpSubject.value));
  }

  void resendOtp() {
    _getTokenRequest.safeAdd(GetTokenUseCaseParams());
  }

  void changeMyNumber(String mobileNo, String countryCode) {
    _changeMyNumberRequest
        .safeAdd(ChangeMyNumberUseCaseParams(mobileNumber: mobileNo, countryCode: '00$countryCode'));
  }

  void sendMobileOtp(BuildContext context) {
    _sendMobileOTPRequest.safeAdd(SendMobileOTPUsecaseParams(
      GetToken: true,
      MobileNumber:
          ProviderScope.containerOf(context).read(addNumberViewModelProvider).mobileNumberController.text,
      MobileCode:
          ProviderScope.containerOf(context).read(addNumberViewModelProvider).countryData.phoneCode ?? "",
    ));
  }

  void verifyMobileOtp({required String? OTPCode, required String? MobileNo}) {
    _verifyMobileOtpRequest
        .safeAdd(OnboardingVerifyMobileOtpUsecaseParams(OTPCode: OTPCode, MobileNo: MobileNo));
  }

  void registerUser(
      {String? email,
      String? phone,
      String? country,
      String? mobileCode,
      String? referralCode,
      String? password,
      String? confirmPassword}) {
    _registerUserRequest.safeAdd(RegisterProspectUseCaseParams(
        email: email,
        countryName: country,
        mobileNumber: phone,
        mobileCode: '00$mobileCode',
        userName: email,
        referralCode: referralCode,
        password: password,
        confirmPassword: confirmPassword));
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
