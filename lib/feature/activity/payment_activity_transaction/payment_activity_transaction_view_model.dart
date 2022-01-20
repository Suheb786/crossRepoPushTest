import 'package:domain/model/payment/payment_activity_response.dart';
import 'package:domain/usecase/activity/payment_activity_transaction_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/model/payment_activity_item.dart';
import 'package:neo_bank/utils/asset_utils.dart';
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

  BehaviorSubject<List<PaymentActivityItem>> _transactionListSubject =
      BehaviorSubject();

  Stream<List<PaymentActivityItem>> get transactionListStream =>
      _transactionListSubject.stream;

  PublishSubject<Resource<PaymentActivityResponse>>
      _paymentActivityTransactionResponse = PublishSubject();

  Stream<Resource<PaymentActivityResponse>>
      get paymentActivityTransactionResponse =>
          _paymentActivityTransactionResponse.stream;

  List<PaymentActivityItem> transactionList = [
    PaymentActivityItem(
        createdAt: "12 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Sent"),
    PaymentActivityItem(
        createdAt: "11 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Request"),
    PaymentActivityItem(
        createdAt: "12 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Sent"),
    PaymentActivityItem(
        createdAt: "11 September",
        image: AssetUtils.image,
        amount: "10,000 JOD",
        name: "Shakila",
        time: "6:35PM",
        status: "Pending",
        type: "Request"),
  ];

  PaymentActivityTransactionViewModel(this._useCase) {
    _paymentActivityTransactionRequest.listen((value) {
      RequestManager(value, createCall: () => _useCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _paymentActivityTransactionResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
        } else if (event.status == Status.SUCCESS) {
          print(
              "got the value: ${event.data!.paymentActivityContent![0].rtpDate}");
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
    _transactionListSubject.close();
    _paymentActivityTransactionRequest.close();
    super.dispose();
  }
}
