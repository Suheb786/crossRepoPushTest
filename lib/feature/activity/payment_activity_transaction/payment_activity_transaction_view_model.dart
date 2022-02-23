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

    getPaymentActivity();
  }

  void getPaymentActivity() {
    _paymentActivityTransactionRequest
        .safeAdd(PaymentActivityTransactionUseCaseParams());
  }

  @override
  void dispose() {
    _paymentActivityTransactionResponse.close();
    _paymentActivityTransactionRequest.close();
    super.dispose();
  }
}
