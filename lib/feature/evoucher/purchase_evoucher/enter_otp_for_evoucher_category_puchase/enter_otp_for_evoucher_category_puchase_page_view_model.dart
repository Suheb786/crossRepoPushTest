import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
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
  final EVoucherOtpUseCase eVoucherOtpUseCase;
  final EnterOtpForEVoucherCategoryPurchaseUseCase _enterOtpForEVoucherPurchaseCategoryUseCase;

  TextEditingController otpController = TextEditingController();

  ///countdown controller
  late CountdownTimerController countDownController;

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
    listenForSmsCode();
  }

  /// make otp suject
  PublishSubject<EVoucherUsecaseOTPParams> _evoucherOtpRequest = PublishSubject();
  PublishSubject<Resource<bool>> _evoucherOtpResponse = PublishSubject();
  Stream<Resource<bool>> get evoucherOtpStream => _evoucherOtpResponse.stream;

  ///place order
  PublishSubject<PlaceOrderUseCaseParams> _placeOrderRequest = PublishSubject();
  PublishSubject<Resource<bool>> _placeOrderResponse = PublishSubject();
  Stream<Resource<bool>> get placeOrderStream => _validateOtpResponse.stream;

  ///enter otp request subject holder
  PublishSubject<EnterOtpForEVoucherCategoryPurchaseUseCaseParams> _validateOtpRequest = PublishSubject();
  PublishSubject<Resource<bool>> _validateOtpResponse = PublishSubject();
  Stream<Resource<bool>> get enterOtpStream => _validateOtpResponse.stream;

  BehaviorSubject<String> _otpSubject = BehaviorSubject.seeded("");

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);
  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EnterOtpForEVoucherCategoryPurchasePageViewModel(this._enterOtpForEVoucherPurchaseCategoryUseCase,
      this.argument, this.placeOrderUseCase, this.eVoucherOtpUseCase) {
    _validateOtpRequest.listen((value) {
      RequestManager(value,
              createCall: () => _enterOtpForEVoucherPurchaseCategoryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _validateOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {}
      });
    });
    this._placeOrderRequest.listen((value) {
      RequestManager(
        value,
        createCall: () => placeOrderUseCase.execute(params: value),
      ).asFlow().listen((event) {
        updateLoader();
        _placeOrderResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        }
      });
    });
    _evoucherOtpRequest.listen((value) {
      RequestManager(value, createCall: () => eVoucherOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _evoucherOtpResponse.safeAdd(event);
        updateLoader();
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        } else if (event.status == Status.SUCCESS) {
          updateTime();
        }
      });
    });
  }

  void makeOTPRequest() {
    otpController.clear();
    _evoucherOtpRequest.safeAdd(EVoucherUsecaseOTPParams(GetToken: true));
  }

  void validateOtp() {
    _validateOtpRequest.safeAdd(EnterOtpForEVoucherCategoryPurchaseUseCaseParams(otp: _otpSubject.value));
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
    _validateOtpRequest.close();
    _validateOtpResponse.close();
    countDownController.disposeTimer();
    _showButtonSubject.close();
    _otpSubject.close();
    countDownController.disposeTimer();
    super.dispose();
  }
}
