import 'package:domain/constants/error_types.dart';
import 'package:domain/model/cliq/return_RTP_request_otp/return_RTP_request_otp.dart';
import 'package:domain/usecase/manage_cliq/return_RTP_request_usecase.dart';
import 'package:domain/usecase/manage_cliq/return_rtp_request_otp_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/ui/molecules/textfield/app_textfield.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:domain/usecase/activity/return_payment_OTP_usecase.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ReturnPaymentOtpPageViewModel extends BasePageViewModel {
  final ReturnPaymentOTPUseCase _returnPaymentOTPUseCase;
  final ReturnRTPrequestOTPUsecase _returnRTPrequestOTPUsecase;
  final ReturnRTPrequestUsecase _returnRTPrequestUsecase;

  ///--------------------------public-instance-valiables-------------------------------------///

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///--------------------------late-valiables-------------------------------------///

  late CountdownTimerController countDownController;

  ///--------------------------final-valiables-------------------------------------///

  final GlobalKey<AppTextFieldState> otpKey = GlobalKey();
  // final AddContactIbanOTPuseCase addContactIbanOTPuseCase;

  ///--------------------------controllers-------------------------------------///

  TextEditingController otpController = TextEditingController();

  PublishSubject<ReturnRTPrequestUsecaseParams> _returnRTPreqeustrequest = PublishSubject();

  PublishSubject<Resource<bool>> _returnRTPreqeustresponse = PublishSubject();

  Stream<Resource<bool>> get returnRTPrequeststream => _returnRTPreqeustresponse.stream;

  void returnRTPrequest({
    required String? custID,
    required String? messageID,
    required String? dbtrAcct,
    required String? dbtrName,
    required String? cdtrAcct,
    required String? cdtrName,
    required String? currency,
    required double? amount,
    required String? rtrnReason,
    required String? rtrnAddInfo,
    required bool? isDispute,
    required String? disputeRefNo,
    required String? otpCode,
    required bool getToken,
  }) {
    _returnRTPreqeustrequest.safeAdd(
      ReturnRTPrequestUsecaseParams(
          CustID: custID,
          MessageID: messageID,
          DbtrAcct: dbtrAcct,
          DbtrName: dbtrName,
          CdtrAcct: cdtrAcct,
          CdtrName: cdtrName,
          Currency: currency,
          Amount: amount,
          RtrnReason: rtrnReason,
          RtrnAddInfo: rtrnAddInfo,
          IsDispute: isDispute,
          DisputeRefNo: disputeRefNo,
          OtpCode: otpCode,
          GetToken: getToken),
    );
  }

  PublishSubject<ReturnPaymentOTPUseCaseParams> _returnPaymentOtpValidationRequest = PublishSubject();
  PublishSubject<Resource<bool>> _returnPaymentOtpValidationResponse = PublishSubject();

  ReturnPaymentOtpPageViewModel(
      this._returnPaymentOTPUseCase, this._returnRTPrequestOTPUsecase, this._returnRTPrequestUsecase) {
    _returnPaymentOtpValidationRequest.listen((value) {
      RequestManager(value, createCall: () => _returnPaymentOTPUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _returnPaymentOtpValidationResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else {}
      });
    });
    _returnRTPreqeustrequest.listen((value) {
      RequestManager(value, createCall: () => _returnRTPrequestUsecase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _returnRTPreqeustresponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else {}
      });
    });
  }
  Stream<Resource<bool>> get returnPaymentOtpValidationStream => _returnPaymentOtpValidationResponse.stream;

  ///--------------------------otp-subject-------------------------------------///

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  ///--------------------------animated-button-subject-------------------------------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonSubjectStream => _showButtonSubject.stream;

  ///--------------------------public-override-methods-------------------------------------///

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();

    super.dispose();
  }

  ///--------------------------public-other-methods-------------------------------------///

  void validateOTP() {
    _returnPaymentOtpValidationRequest.safeAdd(ReturnPaymentOTPUseCaseParams(otp: _otpSubject.value));
  }

  void validate(String val) {
    _otpSubject.safeAdd(val);
    if (otpController.text.isNotEmpty && otpController.text.length == 6) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void getError(Resource<bool> event) {
    switch (event.appError?.type) {
      case ErrorType.INVALID_OTP:
        break;
      default:
    }
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  ///--------------------------public-constructor-------------------------------------///

}
