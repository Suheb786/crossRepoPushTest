import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:domain/usecase/rj/make_ticket_payment_usecase.dart';
import 'package:domain/usecase/user/change_my_number_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:domain/usecase/user/verify_otp_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RjOtpValidateViewModel extends BasePageViewModel {
  final MakeTicketPaymentUseCase _makeTicketPaymentUseCase;

  ///---------------Get Flight Details----------------------///
  PublishSubject<MakeTicketPaymentUseCaseParams> _makeTicketPaymentRequest = PublishSubject();

  PublishSubject<Resource<bool>> _makeTicketPaymentResponse = PublishSubject();

  Stream<Resource<bool>> get makeTicketPaymentStream => _makeTicketPaymentResponse.stream;

  void makeTicketPayment() {
    _makeTicketPaymentRequest
        .safeAdd(MakeTicketPaymentUseCaseParams(referenceNumber: '', amount: '', accountNo: ''));
  }

  ///---------------Get Flight Details----------------------///

  RjOtpValidateViewModel(this._makeTicketPaymentUseCase) {
    _makeTicketPaymentRequest.listen((value) {
      RequestManager(value, createCall: () => _makeTicketPaymentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _makeTicketPaymentResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

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
  PublishSubject<ChangeMyNumberUseCaseParams> _changeMyNumberRequest = PublishSubject();

  ///change my number response holder
  PublishSubject<Resource<bool>> _changeMyNumberResponse = PublishSubject();

  ///change my number stream
  Stream<Resource<bool>> get changeMyNumberStream => _changeMyNumberResponse.stream;

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
