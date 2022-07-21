import 'package:domain/usecase/evouchers/enter_code_evoucher_purchase_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterCodeEVoucherPurchasePageViewModel extends BasePageViewModel {
  final EnterCodeEVoucherPurchaseUseCase _enterCodeEVoucherPurchaseUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  TextEditingController otpController = TextEditingController();

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  ///enter code evoucher purchase request subject holder
  PublishSubject<EnterCodeEVoucherPurchaseUseCaseParams> _enterCodeEVoucherPurchaseRequest = PublishSubject();

  ///enter code evoucher purchase response holder
  PublishSubject<Resource<bool>> _enterCodeEVoucherPurchaseResponse = PublishSubject();

  ///enter code evoucher purchase stream
  Stream<Resource<bool>> get enterCodeEVoucherPurchaseStream => _enterCodeEVoucherPurchaseResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterCodeEVoucherPurchasePageViewModel(
    this._enterCodeEVoucherPurchaseUseCase,
  ) {
    _enterCodeEVoucherPurchaseRequest.listen((value) {
      RequestManager(value, createCall: () => _enterCodeEVoucherPurchaseUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterCodeEVoucherPurchaseResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateOtp() {
    _enterCodeEVoucherPurchaseRequest.safeAdd(EnterCodeEVoucherPurchaseUseCaseParams(otp: _otpSubject.value));
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

  @override
  void dispose() {
    _enterCodeEVoucherPurchaseRequest.close();
    _enterCodeEVoucherPurchaseResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
