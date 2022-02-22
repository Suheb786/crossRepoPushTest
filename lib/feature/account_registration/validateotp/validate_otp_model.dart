import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:domain/usecase/user/change_my_number_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/account_registration/account_registration_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ValidateOtpViewModel extends BasePageViewModel {
  final VerifyOtpUseCase _verifyOtpUseCase;

  final GetTokenUseCase _getTokenUseCase;

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

  void updateTime() {
    otpController.clear();
    resendOtp();
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
  PublishSubject<ChangeMyNumberUseCaseParams> _changeMyNumberRequest =
      PublishSubject();

  ///change my number response holder
  PublishSubject<Resource<bool>> _changeMyNumberResponse = PublishSubject();

  ///change my number stream
  Stream<Resource<bool>> get changeMyNumberStream =>
      _changeMyNumberResponse.stream;

  String _incomingSms = 'Message';

  ValidateOtpViewModel(this._verifyOtpUseCase, this._getTokenUseCase,
      this._changeMyNumberUseCase) {
    _verifyOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _verifyOtpUseCase.execute(params: value))
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
      RequestManager(value,
              createCall: () => _getTokenUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getTokenResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          initiateSmsListener();
        }
      });
    });

    _changeMyNumberRequest.listen((value) {
      RequestManager(value,
              createCall: () => _changeMyNumberUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _changeMyNumberResponse.safeAdd(event);
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
    _changeMyNumberRequest.safeAdd(ChangeMyNumberUseCaseParams(
        mobileNumber: mobileNo, countryCode: '00$countryCode'));
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

  Future<void> initiateSmsListener() async {
    String? incomingMsg = "Message";
    try {
      incomingMsg = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      incomingMsg = 'Failed to get Sms.';
    }

    ///SMS Sample: Your phone verification code is 625742.
    _incomingSms = incomingMsg!;
    print("====>Message: ${_incomingSms}");
    print(
        "${_incomingSms[32] + _incomingSms[33] + _incomingSms[34] + _incomingSms[35] + _incomingSms[36] + _incomingSms[37]}");
    otpController.text = _incomingSms[32] +
        _incomingSms[33] +
        _incomingSms[34] +
        _incomingSms[35] +
        _incomingSms[36] +
        _incomingSms[37];

    notifyListeners();
  }

  @override
  void dispose() {
    _verifyOtpRequest.close();
    _verifyOtpResponse.close();
    _errorDetectorSubject.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    AltSmsAutofill().unregisterListener();
    print('in dispose');
    super.dispose();
  }
}
