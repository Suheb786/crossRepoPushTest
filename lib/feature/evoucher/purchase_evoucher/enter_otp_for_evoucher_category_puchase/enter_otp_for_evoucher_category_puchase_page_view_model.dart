import 'package:domain/usecase/evouchers/enter_otp_for_evoucher_category_purchase_usecase.dart';
import 'package:domain/usecase/evouchers/place_order_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../purchase_evoucher_page.dart';

class EnterOtpForEVoucherCategoryPurchasePageViewModel extends BasePageViewModel {
  final PurchaseEVoucherPageArgument argument;
  final PlaceOrderUseCase placeOrderUseCase;

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

  ///place order
  PublishSubject<PlaceOrderUseCaseParams> _placeOrderRequest = PublishSubject();
  PublishSubject<Resource<bool>> _placeOrderResponse = PublishSubject();
  Stream<Resource<bool>> get placeOrderStream => _enterOtpResponse.stream;

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

  EnterOtpForEVoucherCategoryPurchasePageViewModel(
      this._enterOtpForEVoucherPurchaseCategoryUseCase, this.argument, this.placeOrderUseCase) {
    _enterOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterOtpForEVoucherPurchaseCategoryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        // updateLoader();
        _enterOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
    this._placeOrderRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => placeOrderUseCase.execute(params: value),
      ).asFlow().listen((event) {
        // updateLoader();
        _placeOrderResponse.safeAdd(event);
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
      _otpSubject.safeAdd(value);
      _showButtonSubject.safeAdd(false);
    }
  }

  void placeOrder(
      {required String exchangeRate,
      required String Denomination,
      required String reconcilationCurrency,
      required String Discount,
      required String VoucherName,
      required String VoucherCategory,
      required String AccountNo}) {
    _placeOrderRequest.safeAdd(PlaceOrderUseCaseParams(
      Denomination: Denomination,
      exchangeRate: exchangeRate,
      reconcilationCurrency: reconcilationCurrency,
      Discount: Discount,
      VoucherName: VoucherName,
      VoucherCategory: VoucherCategory,
      AccountNo: AccountNo,
      GetToken: true,
    ));
  }

  listenForSmsCode() async {
    otpController.clear();
    SmsAutoFill().listenForCode();
  }

  @override
  void dispose() {
    otpController.clear();
    _enterOtpRequest.close();
    _enterOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
