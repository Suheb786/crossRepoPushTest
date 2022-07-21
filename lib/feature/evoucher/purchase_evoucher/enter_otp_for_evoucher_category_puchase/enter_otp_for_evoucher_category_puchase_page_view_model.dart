import 'package:domain/usecase/evouchers/enter_otp_for_evoucher_category_purchase_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

class EnterOtpForEVoucherCategoryPurchasePageViewModel extends BasePageViewModel {
  final EnterOtpForEVoucherCategoryPurchaseUseCase _enterOtpForEVoucherPurchaseCategoryUseCase;

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  TextEditingController otpController = TextEditingController();

  ///enter otp request subject holder
  PublishSubject<EnterOtpForEVoucherCategoryPurchaseUseCaseParams> _enterOtpRequest = PublishSubject();

  ///enter otp response holder
  PublishSubject<Resource<bool>> _enterOtpResponse = PublishSubject();

  ///enter otp stream
  Stream<Resource<bool>> get enterOtpStream => _enterOtpResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterOtpForEVoucherCategoryPurchasePageViewModel(this._enterOtpForEVoucherPurchaseCategoryUseCase) {
    _enterOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterOtpForEVoucherPurchaseCategoryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _enterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
  }

  void validateOtp() {
    _enterOtpRequest.safeAdd(EnterOtpForEVoucherCategoryPurchaseUseCaseParams(otp: _otpSubject.value));
  }

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
    _enterOtpRequest.close();
    _enterOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    super.dispose();
  }
}
