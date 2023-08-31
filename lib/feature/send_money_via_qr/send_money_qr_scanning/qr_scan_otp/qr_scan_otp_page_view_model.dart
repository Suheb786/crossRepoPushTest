import 'package:domain/model/qr/qr_transfer_response.dart';
import 'package:domain/usecase/payment/qr_scan_otp_usecase.dart';
import 'package:domain/usecase/payment/transfer_qr_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/payment/payment_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class QRScanOTPPageViewModel extends BasePageViewModel {
  final QRScanOTPUseCase _qrScanOTPUseCase;
  final TransferQRUseCase _transferQRUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  TextEditingController otpController = TextEditingController();

  ///-----------------------------------------view button----------------------------------------------///

  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  void validate(String value) {
    if (value.isNotEmpty && value.length == 6) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  ///-----------------------------------------view button----------------------------------------------///

  ///-----------------------------------------resend otp----------------------------------------------///
  PublishSubject<QRScanOTPUseCaseParams> _resendOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _resendOtpResponse = PublishSubject();

  Stream<Resource<bool>> get resendOtpStream => _resendOtpResponse.stream;

  void resendOtp() {
    _resendOtpRequest.safeAdd(QRScanOTPUseCaseParams());
  }

  ///-----------------------------------------resend otp----------------------------------------------///

  ///----------------Transfer QR Usecase---------------///

  PublishSubject<TransferQRUseCaseParams> _transferQRRequest = PublishSubject();

  PublishSubject<Resource<QRTransferResponse>> _transferQRResponse = PublishSubject();

  Stream<Resource<QRTransferResponse>> get transferQRStream => _transferQRResponse.stream;

  void transferQR({required BuildContext context, String? fromAccount}) {
    var data = ProviderScope.containerOf(context).read(sendMoneyQrScanningViewModelProvider).arguments;
    _transferQRRequest.safeAdd(TransferQRUseCaseParams(
        fromAccount: fromAccount,
        toAccount: data?.accountNo ?? '',
        toAmount: data?.amount ?? '',
        requestId: data?.requestId ?? '',
        otp: otpController.text));
  }

  ///----------------Transfer QR Usecase---------------///

  QRScanOTPPageViewModel(this._qrScanOTPUseCase, this._transferQRUseCase) {
    _resendOtpRequest.listen((value) {
      RequestManager(value, createCall: () => _qrScanOTPUseCase.execute(params: value))
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

    _transferQRRequest.listen((value) {
      RequestManager(value, createCall: () => _transferQRUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _transferQRResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _resendOtpRequest.close();
    _resendOtpResponse.close();
    _transferQRRequest.close();
    _transferQRResponse.close();
    super.dispose();
  }
}
