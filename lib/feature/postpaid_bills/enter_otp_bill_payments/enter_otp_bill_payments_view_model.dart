import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/usecase/bill_payment/enter_otp_bill_paymnets_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
import 'package:domain/usecase/payment/transfer_verify_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpBillPaymentsViewModel extends BasePageViewModel {
  final TransferUseCase _transferUseCase;
  TextEditingController otpController = TextEditingController();
  EnterOtpBillPaymentsUseCase _useCase;

  final TransferVerifyUseCase _transferVerifyUseCase;

  PublishSubject<EnterOtpBillPaymentsUseCaseParams> _enterOtpBillPaymentsRequest = PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpBillPaymentsResponse = PublishSubject();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<Resource<bool>> get enterOtpBillPaymentsResponseStream => _enterOtpBillPaymentsResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///resend otp
  PublishSubject<GetTokenUseCaseParams> _getTokenRequest = PublishSubject();

  PublishSubject<Resource<bool>> _transferVerifyResponse = PublishSubject();

  ///transfer verify response stream
  Stream<Resource<bool>> get transferVerifyStream => _transferVerifyResponse.stream;

  void updateTime() {
    // endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    // notifyListeners();
    verifyTransfer();
  }

  ///transfer request
  PublishSubject<TransferUseCaseParams> _transferRequest = PublishSubject();

  ///transfer response
  PublishSubject<Resource<TransferSuccessResponse>> _transferResponse = PublishSubject();

  ///transfer response stream
  Stream<Resource<TransferSuccessResponse>> get transferStream => _transferResponse.stream;

  PublishSubject<TransferVerifyUseCaseParams> _transferVerifyRequest = PublishSubject();

  EnterOtpBillPaymentsViewModel(this._useCase, this._transferUseCase, this._transferVerifyUseCase) {
    // _enterOtpBillPaymentsRequest.listen((value) {
    //   RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
    //     _enterOtpBillPaymentsResponse.safeAdd(event);
    //     if (event.status == Status.ERROR) {
    //       showErrorState();
    //     }
    //   });
    // });
    //
  }

  void enterOtpBillPayments() {
    _enterOtpBillPaymentsRequest.safeAdd(EnterOtpBillPaymentsUseCaseParams(
        billerType: "", amount: "", currencyCode: "", accountNo: "", isNewBiller: false));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
      _otpSubject.safeAdd(value);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  void verifyTransfer() {
    _transferVerifyRequest.safeAdd(TransferVerifyUseCaseParams());
  }

  @override
  void dispose() {
    _otpSubject.close();
    _enterOtpBillPaymentsRequest.close();
    _showButtonSubject.close();
    _enterOtpBillPaymentsResponse.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
