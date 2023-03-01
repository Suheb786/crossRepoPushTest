import 'package:domain/usecase/rj/make_ticket_payment_usecase.dart';
import 'package:domain/usecase/rj/rj_otp_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class RjOtpValidateViewModel extends BasePageViewModel {
  final MakeTicketPaymentUseCase _makeTicketPaymentUseCase;

  final RJOtpValidateUseCase _rjOtpValidateUseCase;

  ///---------------Rj OTP Validate Details----------------------///
  PublishSubject<RJOtpValidateUseCaseParams> _rjOtpValidateRequest = PublishSubject();

  PublishSubject<Resource<bool>> _rjOtpValidateResponse = PublishSubject();

  Stream<Resource<bool>> get rjOtpValidateStream => _rjOtpValidateResponse.stream;

  void rjOtpValidate() {
    _rjOtpValidateRequest.safeAdd(RJOtpValidateUseCaseParams());
  }

  ///---------------Rj OTP Validate Details----------------------///

  ///---------------Make Ticket Payment Details----------------------///
  PublishSubject<MakeTicketPaymentUseCaseParams> _makeTicketPaymentRequest = PublishSubject();

  PublishSubject<Resource<bool>> _makeTicketPaymentResponse = PublishSubject();

  Stream<Resource<bool>> get makeTicketPaymentStream => _makeTicketPaymentResponse.stream;

  void makeTicketPayment(
      {required String referenceNumber,
      required String amount,
      required String accountNo,
      required String otpCode}) {
    _makeTicketPaymentRequest.safeAdd(MakeTicketPaymentUseCaseParams(
        referenceNumber: referenceNumber, amount: amount, accountNo: accountNo, otpCode: otpCode));
  }

  ///---------------Make Ticket Payment Details----------------------///

  RjOtpValidateViewModel(this._makeTicketPaymentUseCase, this._rjOtpValidateUseCase) {
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

    _rjOtpValidateRequest.listen((value) {
      RequestManager(value, createCall: () => _rjOtpValidateUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _rjOtpValidateResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
          notifyListeners();
          listenForSmsCode();
        }
      });
    });
  }

  ///otp controller
  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

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

  @override
  void dispose() {
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
