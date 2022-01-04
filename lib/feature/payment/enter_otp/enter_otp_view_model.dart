import 'package:domain/model/payment/transfer_respone.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/usecase/payment/enter_otp_usecase.dart';
import 'package:domain/usecase/payment/transfer_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class EnterOtpViewModel extends BasePageViewModel {
  final TransferUseCase _transferUseCase;
  TextEditingController otpController = TextEditingController();
  EnterOtpUseCase _useCase;

  PublishSubject<EnterOtpUseCaseParams> _enterOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _enterOtpResponse = PublishSubject();

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<Resource<bool>> get enterOtpResponseStream => _enterOtpResponse.stream;

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(true);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    // notifyListeners();
  }

  ///transfer request
  PublishSubject<TransferUseCaseParams> _transferRequest = PublishSubject();

  ///transfer response
  PublishSubject<Resource<TransferSuccessResponse>> _transferResponse =
      PublishSubject();

  ///transfer response stream
  Stream<Resource<TransferSuccessResponse>> get transferStream =>
      _transferResponse.stream;

  EnterOtpViewModel(this._useCase, this._transferUseCase) {
    _enterOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _enterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });

    _transferRequest.listen((value) {
      RequestManager(value,
              createCall: () => _transferUseCase.execute(params: value))
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

  void transfer(TransferResponse transferResponse, String memo, bool isFriend,
      String beneficiaryImage) {
    print('isFriend:--->$isFriend');
    _transferRequest.safeAdd(TransferUseCaseParams(
        otpCode: _otpSubject.value,
        toAmount: transferResponse.toAmount,
        toAccount: transferResponse.toAccount,
        memo: memo,
        isFriend: isFriend,
        transferType: transferResponse.transferType,
        localEq: transferResponse.localEq,
        beneficiaryId: transferResponse.beneficiaryId,
        beneficiaryImage: beneficiaryImage));
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
    _otpSubject.close();
    _enterOtpRequest.close();
    _showButtonSubject.close();
    _enterOtpResponse.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
