import 'package:neo_bank/base/base_page_view_model.dart';

class PaymentActivityViewModel extends BasePageViewModel {
  // PaymentActivityTransactionUseCase _useCase;
  //
  // PublishSubject<PaymentActivityTransactionUseCaseParams>
  // _paymentActivityTransactionRequest = PublishSubject();
  //
  // PublishSubject<Resource<PaymentActivityResponse>>
  // _paymentActivityTransactionResponse = PublishSubject();
  //
  // Stream<Resource<PaymentActivityResponse>>
  // get paymentActivityTransactionResponse =>
  //     _paymentActivityTransactionResponse.stream;
  //
  // PaymentActivityViewModel(this._useCase){
  //   _paymentActivityTransactionRequest.listen((value) {
  //     RequestManager(value, createCall: () => _useCase.execute(params: value))
  //         .asFlow()
  //         .listen((event) {
  //       updateLoader();
  //       _paymentActivityTransactionResponse.safeAdd(event);
  //       if (event.status == Status.ERROR) {
  //         showErrorState();
  //       }
  //     });
  //   });
  //   getPaymentActivity();
  // }
  //
  //
  // void getPaymentActivity() {
  //   _paymentActivityTransactionRequest.safeAdd(PaymentActivityTransactionUseCaseParams());
  // }
  //
  // @override
  // void dispose() {
  //   _paymentActivityTransactionRequest.close();
  //   _paymentActivityTransactionResponse.close();
  //   super.dispose();
  // }
}
