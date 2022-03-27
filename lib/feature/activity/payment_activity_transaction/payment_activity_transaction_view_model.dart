import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class PaymentActivityTransactionViewModel extends BasePageViewModel {
  PaymentActivityTransactionUseCase _useCase;

  /// payment activity subject holder
  PublishSubject<PaymentActivityTransactionUseCaseParams>
      _paymentActivityTransactionRequest = PublishSubject();

  PublishSubject<Resource<PaymentActivityResponse>>
      _paymentActivityTransactionResponse = PublishSubject();

  Stream<Resource<PaymentActivityResponse>>
      get paymentActivityTransactionResponse =>
          _paymentActivityTransactionResponse.stream;

  ///transaction type
  BehaviorSubject<String> _transactionTypeResponse = BehaviorSubject();

  Stream<String> get transactionTypeResponseStream =>
      _transactionTypeResponse.stream;

  ///payment period
  BehaviorSubject<String> _paymentPeriodResponse = BehaviorSubject();

  Stream<String> get paymentPeriodResponseStream =>
      _paymentPeriodResponse.stream;

  PaymentActivityTransactionViewModel(this._useCase) {
    _paymentActivityTransactionRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _paymentActivityTransactionResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    getPaymentActivity(30);
  }

  void getPaymentActivity(int filterDays) {
    _paymentActivityTransactionRequest.safeAdd(
        PaymentActivityTransactionUseCaseParams(filterDays: filterDays));
  }

  void updateTransactionType(String value) {
    _transactionTypeResponse.safeAdd(value);
  }

  void updatePaymentPeriod(String value) {
    _paymentPeriodResponse.safeAdd(value);
    getPaymentActivity(getFilterDays(value));
  }

  int getFilterDays(String value) {
    switch (value) {
      case "Last 30 days":
        return 30;
      case "Last 3 months":
        return 90;
      case "Last 6 months":
        return 180;
      default:
        return 180;
    }
  }

  @override
  void dispose() {
    _paymentActivityTransactionResponse.close();
    _paymentActivityTransactionRequest.close();
    super.dispose();
  }
}
