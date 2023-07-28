import 'package:domain/model/e_voucher/get_settlement_amount.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/get_settlement_ammount_usecase.dart';
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

import '../../../../generated/l10n.dart';
import '../purchase_evoucher_page.dart';

class EvoucherSettlementAccountPageViewModel extends BasePageViewModel {
  final EVoucherOtpUseCase eVoucherOtpUseCase;
  final GetSettlementAmountUseCase getSettlementAmountUseCase;

  final PurchaseEVoucherPageArgument argument;
  final GetSettlementValidationUseCase _selectAccountUseCase;

  ///get settlement amount
  PublishSubject<GetSettlementAmountUseCaseParams> _getSettlementAmountRequest = PublishSubject();
  PublishSubject<Resource<GetSettlementAmount>> _getSettlementAmountResponse = PublishSubject();
  Stream<Resource<GetSettlementAmount>> get getSettlementAmountStream => _getSettlementAmountResponse.stream;

  /// check Subject
  BehaviorSubject<bool> _isCheckedRequest = BehaviorSubject.seeded(true);

  Stream<bool> get isCheckedStream => _isCheckedRequest.stream;

  /// otp suject
  PublishSubject<EVoucherUsecaseOTPParams> _evoucherOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _evoucherOtpResponse = PublishSubject();

  Stream<Resource<bool>> get evoucherOtpStream => _evoucherOtpResponse.stream;

  ///select region amount request
  PublishSubject<GetSettlementValidationUseCaseParams> _selectAccountRequest = PublishSubject();

  PublishSubject<Resource<bool>> _selectAccountResponse = PublishSubject();

  Stream<Resource<bool>> get selectAccountStream => _selectAccountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EvoucherSettlementAccountPageViewModel(
      this._selectAccountUseCase, this.argument, this.eVoucherOtpUseCase, this.getSettlementAmountUseCase) {
    _getSettlementAmountRequest.listen((value) {
      RequestManager(value, createCall: () => getSettlementAmountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getSettlementAmountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
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
            updateTime();
          }
        }
      });
    });
    getSettlementAmmount(
        Amount: argument.selectedItem.fromValue.toString(),
        FromCurrency: argument.selectedItem.currency,
        ToCurrency: S.current.JOD);
  }

  void getSettlementAmmount({
    required String? Amount,
    required String? FromCurrency,
    required String? ToCurrency,
  }) {
    _getSettlementAmountRequest.safeAdd(GetSettlementAmountUseCaseParams(
        Amount: Amount, FromCurrency: FromCurrency, ToCurrency: ToCurrency, GetToken: true));
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
        itemValueString: argument.selectedItem.fromValue));
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
