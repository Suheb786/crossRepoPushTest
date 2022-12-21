import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/usecase/payment/enter_otp_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
import 'package:domain/usecase/payment/transfer_verify_usecase.dart';
import 'package:domain/usecase/user/get_token_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpViewModel extends BasePageViewModel {
  final TransferUseCase _transferUseCase;
  TextEditingController otpController = TextEditingController();
  EnterOtpUseCase _useCase;

  final TransferVerifyUseCase _transferVerifyUseCase;

  PublishSubject<EnterOtpUseCaseParams> _enterOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpResponse = PublishSubject();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<Resource<bool>> get enterOtpResponseStream => _enterOtpResponse.stream;

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

  EnterOtpViewModel(this._useCase, this._transferUseCase, this._transferVerifyUseCase) {
    _transferVerifyRequest.listen((value) {
      RequestManager(value, createCall: () => _transferVerifyUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferVerifyResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          listenForSmsCode();
        }
      });
    });

    _enterOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value)).asFlow().listen((event) {
        _enterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _transferRequest.listen((value) {
      RequestManager(value, createCall: () => _transferUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void enterOtp() {
    _enterOtpRequest.safeAdd(EnterOtpUseCaseParams(otpCode: _otpSubject.value));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  void transfer({required TransferResponse transferResponse,
    required String memo,
    required bool isFriend,
    required String beneficiaryImage,
    required String nickName,
    required num limit,
    required String amount,
    required String recipientName,
    required String recipientAddress}) {
    print('isFriend:--->$isFriend');
    _transferRequest.safeAdd(TransferUseCaseParams(
        limit: limit,
        otpCode: _otpSubject.value,
        toAmount: double.parse(amount),
        toAccount: transferResponse.toAccount,
        memo: memo,
        nickName: nickName,
        isFriend: isFriend,
        transferType: transferResponse.transferType,
        localEq: double.parse(amount),
        beneficiaryId: transferResponse.beneficiaryId,
        beneficiaryImage: beneficiaryImage,
        type: "",
        detCustomerType: "",
        recipientName: recipientName,
        recipientAddress: recipientAddress));
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
    _enterOtpRequest.close();
    _showButtonSubject.close();
    _enterOtpResponse.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
