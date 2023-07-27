import 'package:domain/model/dashboard/get_dashboard_data/get_dashboard_data_response.dart';
import 'package:domain/usecase/dashboard/get_dashboard_data_usecase.dart';
import 'package:domain/usecase/evouchers/e_voucher_otp_usecase.dart';
import 'package:domain/usecase/evouchers/select_account_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

import '../purchase_evoucher_page.dart';

class EvoucherSettlementAccountPageViewModel extends BasePageViewModel {
  final EVoucherOtpUseCase eVoucherOtpUseCase;

  final GetDashboardDataUseCase getDashboardDataUseCase;
  final PurchaseEVoucherPageArgument argument;
  final GetSettlementValidationUseCase _selectAccountUseCase;

  /// check Subject
  BehaviorSubject<bool> _isCheckedRequest = BehaviorSubject.seeded(true);

  Stream<bool> get isCheckedStream => _isCheckedRequest.stream;

  /// otp suject
  PublishSubject<EVoucherUsecaseOTPParams> _evoucherOtpRequest = PublishSubject();

  PublishSubject<Resource<bool>> _evoucherOtpResponse = PublishSubject();

  Stream<Resource<bool>> get evoucherOtpStream => _evoucherOtpResponse.stream;

  ///get dashboard data request
  PublishSubject<GetDashboardDataUseCaseParams> _getDashboardDataRequest = PublishSubject();

  ///get dashboard data response
  PublishSubject<Resource<GetDashboardDataResponse>> _getDashboardDataResponse = PublishSubject();

  ///get dashboard data response stream
  Stream<Resource<GetDashboardDataResponse>> get getDashboardDataStream => _getDashboardDataResponse.stream;

  ///select region amount request
  PublishSubject<GetSettlementValidationUseCaseParams> _selectAccountRequest = PublishSubject();

  PublishSubject<Resource<bool>> _selectAccountResponse = PublishSubject();

  Stream<Resource<bool>> get selectAccountStream => _selectAccountResponse.stream;

  /// button subject
  BehaviorSubject<bool> _showButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showButtonStream => _showButtonSubject.stream;

  EvoucherSettlementAccountPageViewModel(
      this._selectAccountUseCase, this.argument, this.getDashboardDataUseCase, this.eVoucherOtpUseCase) {
    _selectAccountRequest.listen((value) {
      RequestManager(value, createCall: () => _selectAccountUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _selectAccountResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          // getError(event);

          showErrorState();
        }
      });
    });

    _getDashboardDataRequest.listen((value) {
      RequestManager(value, createCall: () => getDashboardDataUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getDashboardDataResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
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
          // getError(event);
          showErrorState();
        }
      });
    });
  }

  void getDashboardData() {
    _getDashboardDataRequest.safeAdd(GetDashboardDataUseCaseParams());
  }

  void getOTP() {
    _evoucherOtpRequest.safeAdd(EVoucherUsecaseOTPParams(GetToken: true));
  }

  void check(bool value) {
    _isCheckedRequest.safeAdd(value);
  }

  // void getError(Resource<bool> event) {
  //   switch (event.appError!.type) {
  //     case ErrorType.NOTE_ENOUGH_AMOUNT:
  //       accountKey.currentState!.isValid = false;
  //       break;
  //     default:
  //       break;
  //   }
  // }

  void validateFields() {
    _selectAccountRequest.safeAdd(GetSettlementValidationUseCaseParams(
        isChecked: _isCheckedRequest.value,
        totalAmountString: "20",
        itemValueString: argument.selectedItem.fromValue));
  }

  void validate() {
    if (_isCheckedRequest.value == true) {
      _showButtonSubject.safeAdd(true);
    } else {
      _showButtonSubject.safeAdd(false);
    }
  }

  // void validate() {
  //   if (selectedRegionController.text.isNotEmpty && amountController.text.isNotEmpty) {
  //     _showButtonSubject.safeAdd(true);
  //   } else {
  //     _showButtonSubject.safeAdd(false);
  //   }
  // }

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
