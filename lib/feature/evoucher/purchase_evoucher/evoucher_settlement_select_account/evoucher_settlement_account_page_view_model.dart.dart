import 'package:domain/model/e_voucher/e_voucher_otp.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/select_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../purchase_evoucher_page.dart';

class EvoucherSettlementAccountPageViewModel extends BasePageViewModel {
  final EVoucherOtpUseCase eVoucherOtpUseCase;

  final PurchaseEVoucherPageArgument argument;
  final GetSettlementValidationUseCase _selectAccountUseCase;

  ///get settlement amount

  BehaviorSubject<double> _getSettlementAmountResponse = BehaviorSubject();

  Stream<double> get getSettlementAmountStream => _getSettlementAmountResponse.stream;

  getSettleValue(double value) {
    _getSettlementAmountResponse.safeAdd(value);
  }

  /// check Subject
  BehaviorSubject<bool> _isCheckedRequest = BehaviorSubject.seeded(true);

  Stream<bool> get isCheckedStream => _isCheckedRequest.stream;

  /// otp suject
  PublishSubject<EVoucherUsecaseOTPParams> _evoucherOtpRequest = PublishSubject();

  PublishSubject<Resource<EVoucherOTP>> _evoucherOtpResponse = PublishSubject();

  Stream<Resource<EVoucherOTP>> get evoucherOtpStream => _evoucherOtpResponse.stream;

  ///select region amount request
  PublishSubject<GetSettlementValidationUseCaseParams> _selectAccountRequest = PublishSubject();

  PublishSubject<Resource<bool>> _selectAccountResponse = PublishSubject();

  Stream<Resource<bool>> get selectAccountStream => _selectAccountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  String mobileCode = "";
  String mobileNumber = "";

  EvoucherSettlementAccountPageViewModel(this._selectAccountUseCase, this.argument, this.eVoucherOtpUseCase) {
    _selectAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _selectAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _selectAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _evoucherOtpRequest.listen((value) {
      RequestManager(value, createCall: () => eVoucherOtpUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _evoucherOtpResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
          if (event.status == Status.SUCCESS) {
            mobileCode = event.data?.mobileCode ?? "";
            mobileNumber = event.data?.mobileNumber ?? "";
            updateTime();
          }
        }
      });
    });
  }

  void getOTP() {
    _evoucherOtpRequest.safeAdd(EVoucherUsecaseOTPParams(GetToken: true));
  }

  void check(bool value) {
    _isCheckedRequest.safeAdd(value);
  }

  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void updateTime() {
    endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
    notifyListeners();
  }

  validateFields(BuildContext context) {
    _selectAccountRequest.safeAdd(GetSettlementValidationUseCaseParams(
        isChecked: _isCheckedRequest.value,
        totalAmountString: ProviderScope.containerOf(context)
                .read(appHomeViewModelProvider)
                .dashboardDataContent
                .account
                ?.availableBalance ??
            "",
        itemValueString: _getSettlementAmountResponse.value));
  }

  void validate() {
    if (_isCheckedRequest.value == true) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  @override
  void dispose() {
    _selectAccountRequest.close();
    _selectAccountResponse.close();
    _showButtonSubject.close();
    _evoucherOtpRequest.close();
    _evoucherOtpResponse.close();

    super.dispose();
  }
}
