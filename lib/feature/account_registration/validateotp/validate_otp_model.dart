import 'package:domain/usecase/user/change_my_number_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
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

  // ///timer subject holder
  // BehaviorSubject<int> _timerRequest = BehaviorSubject.seeded(
  //     DateTime.now().millisecondsSinceEpoch + 1000 * 120);
  //
  // ///timer response holder
  // Stream<int> get timerStream => _timerRequest.stream;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
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
        mobileNumber: mobileNo, countryCode: countryCode));
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
